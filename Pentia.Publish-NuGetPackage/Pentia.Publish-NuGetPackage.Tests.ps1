# Requires https://github.com/pester/Pester: Install-Module Pester -Force -SkipPublisherCheck
Import-Module "$PSScriptRoot\Pentia.Publish-NuGetPackage.psm1" -Force

Describe "Install-NuGetExe" {
    
    InModuleScope "Pentia.Publish-NuGetPackage" {

        Describe "global NuGet.exe usage" {
    
            Mock Get-GlobalNuGetPath { return "$TestDrive\4.4.1.0" }
        
            It "should return an absolute path when NuGet.exe *is* available via PATH" {
                try {
                    # Arrange
                    Push-Location $TestDrive
            
                    # Act
                    $nugetPath = Get-NuGetPath
        
                    # Assert
                    $nugetPath | Should Be "$TestDrive\4.4.1.0"
                }
                finally {             
                    Pop-Location   
                }
            }
        }

        Describe "local NuGet.exe usage" {
            
            Mock Get-GlobalNuGetPath { return $null }

            It "should return an absolute path when NuGet *isn't* available via PATH" {
                try {
                    # Arrange
                    Push-Location $TestDrive
        
                    # Act
                    $nugetPath = Get-NuGetPath

                    # Assert
                    $nugetPath | Should Be "$TestDrive\.pentia\nuget.exe"
                }
                finally {             
                    Pop-Location   
                }
            }

            It "should detect when NuGet.exe is missing ""locally""" {
                try {
                    # Arrange
                    Push-Location $TestDrive
            
                    # Act
                    $isNugetExeInstalled = Test-NuGetInstall
    
                    # Assert
                    $isNugetExeInstalled | Should Be $false
                }
                finally {
                    Pop-Location                
                }
            }
    
            It "should download NuGet.exe during install" {
                try {
                    # Arrange
                    Push-Location $TestDrive
            
                    # Act
                    Install-NuGetExe
    
                    # Assert
                    Test-NuGetInstall | Should Be $true
                }
                finally {
                    Pop-Location                
                }
            }    
        }

    }
}

function New-NuGetConfig {
    if (Test-Path "NuGet.config") {
        return
    }
    Set-Content -Path "NuGet.config" -Value '<configuration><packageSources><clear /><add key="NuGet official package source" value="https://api.nuget.org/v3/index.json" /></packageSources></configuration>'
}

Describe "Restore-NuGetPackage" {
    It "should invoke NuGet.exe and restore packages" {
        Push-Location $TestDrive
        try {
            # Arrange
            Install-NuGetExe
            New-NuGetConfig
            Set-Content -Path "packages.config" -Value "<packages><package id=""jQuery"" version=""3.2.1"" /></packages>"
        
            # Act
            Restore-NuGetPackage -SolutionDirectory "."

            # Assert
            $isSpecificPackageInstalled = Test-Path "packages\jQuery.3.2.1\"
            $isSpecificPackageInstalled | Should Be $true
        }
        finally {
            Pop-Location                
        }
    }

    It "should fail when user interaction is required" {
        Push-Location $TestDrive
        try {
            # Arrange
            Get-ChildItem $TestDrive -Recurse | Remove-Item -Recurse -Force
            Install-NuGetExe
            Set-Content -Path "$TestDrive\NuGet.config" -Value '<configuration>
                <packageSources>
                    <clear />
                    <add key="A repository which requires credentials" 
                         value="https://pentia.pkgs.visualstudio.com/_packaging/nuget-pentia/nuget/v3/index.json" />
                </packageSources>
            </configuration>'

            Set-Content -Path "packages.config" -Value "<packages><package id=""This-Package-Does-Not-Exist-Locally"" version=""1.2.3"" /></packages>"
        
            # Act
            $invocation = { 
                Restore-NuGetPackage -SolutionDirectory "."
            }

            # Assert
            $invocation | Should Throw "NuGet command failed."
        }
        finally {
            Pop-Location                
        }
    }
}

Describe "Install-NuGetPackage" {
    It "should invoke NuGet.exe and install the latest version of a package" {
        Push-Location $TestDrive
        try {
            # Arrange
            Install-NuGetExe
            New-NuGetConfig
            Install-NuGetPackage -SolutionDirectory "." -PackageId "jQuery" -PackageVersion "3.2.1"
        
            # Act
            Install-NuGetPackage -SolutionDirectory "." -PackageId "jQuery"

            # Assert
            $jQueryPackagePaths = Get-ChildItem "packages\jQuery.*\"
            $jQueryPackagePaths.Count | Should Be 2
        }
        finally {
            Pop-Location                
        }
    }

    It "should invoke NuGet.exe and install all packages in packages.config" {
        Push-Location $TestDrive
        try {
            # Arrange
            Install-NuGetExe
            New-NuGetConfig
            Set-Content -Path "packages.config" -Value "<packages><package id=""Newtonsoft.Json"" version=""10.0.2"" /><package id=""Newtonsoft.Json"" version=""10.0.3"" /></packages>"
        
            # Act
            Install-NuGetPackage -SolutionDirectory "." -PackageConfigFile "packages.config"

            # Assert
            $newtonsoftJsonPackagePaths = Get-ChildItem "packages\Newtonsoft.*\"
            $newtonsoftJsonPackagePaths.Count | Should Be 2
        }
        finally {
            Pop-Location                
        }
    }
}

Describe "Copy-PackageFolder" {

    InModuleScope "Pentia.Publish-NuGetPackage" {
        
        Context "RoboCopy success" {

            It "should set a zero exit code" {
                # Arrange

                ## Create source directory
                $source = "$TestDrive\test-source"
                New-Item -Path $source -ItemType Directory | Out-Null
                New-Item -Path "$source\test.txt" -ItemType File | Out-Null

                ## Create empty target directory - this ensures that RoboCopy sets the exit code to "2", because the target directory exists.
                $target = "$TestDrive\test-target"
                New-Item -Path $target -ItemType Directory | Out-Null

                # Act
                Copy-PackageFolder -SourceFriendlyName "Test" -Source $source -Target $target

                # Assert
                $LASTEXITCODE | Should Be 0
                Test-Path -Path "$target\test.txt" | Should be $true
            }

        }

        Context "RoboCopy failure" {

            Mock Invoke-RoboCopy {
                $global:LASTEXITCODE = -100
            }

            It "should set a non-zero exit code" {
                # Arrange
                
                ## Create source directory
                $source = "$TestDrive\test-source"
                New-Item -Path $source -ItemType Directory | Out-Null
                New-Item -Path "$source\test.txt" -ItemType File | Out-Null

                ## Create read-only file in target directory
                $target = "$TestDrive\test-target"
                New-Item -Path $target -ItemType Directory | Out-Null
                $testFilePath = "$target\test.txt"
                New-Item -Path $testFilePath -ItemType File | Out-Null
                Set-Content -Path $testFilePath -Value "Hello World!"
                Set-ItemProperty -Path $testFilePath -Name "IsReadOnly" -Value $true

                # Act
                Copy-PackageFolder -SourceFriendlyName "Test" -Source $source -Target $target -ErrorAction "Continue"

                # Assert
                $global:LASTEXITCODE | Should Not Be 0
            }

        }

    }

}

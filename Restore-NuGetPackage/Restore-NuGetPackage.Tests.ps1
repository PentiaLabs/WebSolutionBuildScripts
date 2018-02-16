# Requires https://github.com/pester/Pester: Install-Module Pester -Force -SkipPublisherCheck
Import-Module "$PSScriptRoot\Restore-NuGetPackage.psm1" -Force

Describe "Install-NuGetExe" {
    
    InModuleScope "Restore-NuGetPackage" {

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
            
            Mock Get-GlobalNuGetPath { return $Null }

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
                    $isNugetExeInstalled | Should Be $False
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
                    Test-NuGetInstall | Should Be $True
                }
                finally {
                    Pop-Location                
                }
            }    
        }

    }
}

Describe "Restore-NuGetPackage" {
    It "should invoke NuGet.exe and restore packages" {
        Push-Location $TestDrive
        try {
            # Arrange
            Install-NuGetExe
            Set-Content -Path "packages.config" -Value "<packages><package id=""jQuery"" version=""3.2.1"" /></packages>"
        
            # Act
            Restore-NuGetPackage -SolutionDirectory "."

            # Assert
            $isSpecificPackageInstalled = Test-Path "packages\jQuery.3.2.1\"
            $isSpecificPackageInstalled | Should Be $True
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

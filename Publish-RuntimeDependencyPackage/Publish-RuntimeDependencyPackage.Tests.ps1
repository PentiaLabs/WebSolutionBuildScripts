# Requires https://github.com/pester/Pester: Install-Module Pester -Force -SkipPublisherCheck
Remove-Module Publish-RuntimeDependencyPackage -ErrorAction SilentlyContinue
Import-Module "$PSScriptRoot\Publish-RuntimeDependencyPackage.psm1" -Force

# Test internal functions
InModuleScope Publish-RuntimeDependencyPackage {
    Describe "Test-PackageProvider" {
        It "should return '$True' when the specified Package Provider is installed" {
            # Arrange
            $packageProvider = "NuGet"
    
            # Act
            $isInstalled = Test-PackageProvider $packageProvider
    
            # Assert
            $isInstalled | Should Be $True
        }

        It "should return '$False' when the specified Package Provider is not installed" {
            # Arrange
            $packageProvider = "This package provider is not installed"
    
            # Act
            $isInstalled = Test-PackageProvider $packageProvider
    
            # Assert
            $isInstalled | Should Be $False
        }
    }

    Describe "Get-RuntimeDependencyPackageFromCache" { 
        It "should find package by name and version" {
            # Arrange
            $packageName = "jQuery"
            $packageVersion = "3.1.1"
            $packageSource = "https://www.nuget.org/api/v2"
            $package = Install-Package -Name $packageName -RequiredVersion $packageVersion -Source $packageSource -Force

            # Act
            $cachedPackage = Get-RuntimeDependencyPackageFromCache -PackageName $package.Name -PackageVersion $package.Version

            # Assert
            $cachedPackage | Should Not Be $Null
        }  

        It "should return null when package is not found" {
            # Arrange
            $packageName = "This package is not installed"
            $packageVersion = "1234567890"
    
            # Act
            $cachedPackage = Get-RuntimeDependencyPackageFromCache -PackageName $packageName -PackageVersion $packageVersion
    
            # Assert
            $cachedPackage | Should Be $Null
        }
    }

    Describe "Install-RuntimeDependencyPackage" {    
        It "should throw a helpful error message if the package is not found" {
            # Arrange
            $packageName = "This-package-does-not-exist"
            $packageVersion = "1.0.0"
            $packageSource = "$PSScriptRoot\..\TestContent\TestPackages\"

            # Act
            $invocation = { Install-RuntimeDependencyPackage -PackageName $packageName -PackageVersion $packageVersion -PackageSource $packageSource }

            # Assert
            $invocation | Should Throw "The package '$packageName' version '$packageVersion' couldn't be found in the source '$packageSource'. Make sure that all required package sources are set up correctly, e.g. 'Register-PackageSource -Name ""Pentia NuGet"" -Location ""http://tund/nuget/Nuget"" -Trusted -ProviderName ""NuGet""'."
        }

        It "should install NuGet packages from the specified source" {
            # Arrange
            $packageName = "jquery"
            $packageVersion = "3.1.1"
            $packageSource = "$PSScriptRoot\..\TestContent\TestPackages\"

            # Act
            $installedPackage = Install-RuntimeDependencyPackage -PackageName $packageName -PackageVersion $packageVersion -PackageSource $packageSource

            # Assert
            $installedPackage.Name | Should Be $packageName
            $installedPackage.Version | Should Be $packageVersion
        }

        It "should handle missing NuGet package sources by searching in all registered sources" {
            # Arrange
            $packageName = "jquery"
            $packageVersion = "3.1.1"
            $packageSourceName = "Publish-RuntimeDependencyPackage.Tests - nuget.org API v2"
            Register-PackageSource -Name $packageSourceName -ProviderName "NuGet" -Location "https://www.nuget.org/api/v2" -ErrorAction SilentlyContinue
        
            Try {
                # Act
                $installedPackage = Install-RuntimeDependencyPackage -PackageName $packageName -PackageVersion $packageVersion
            
                # Assert
                $installedPackage.Name | Should Be $packageName
                $installedPackage.Version | Should Be $packageVersion                
            }
            Finally {
                Unregister-PackageSource -Name $packageSourceName -ErrorAction SilentlyContinue
            }
        }
    }

    Describe "Copy-RuntimeDependencyPackageContent" {
        $packageName = "sample-runtime-dependency"
        $packageVersion = "1.0.0"
        $packageSource = "$PSScriptRoot\..\TestContent\TestPackages\"
        $destination = "$TestDrive"
        $installedPackage = Install-Package -Name $packageName -RequiredVersion $packageVersion -Source $packageSource -Destination $destination
    
        It "should copy 'Webroot' folder contents to the target webroot path" {
            # Arrange
            $expectedFileNames = @("Web.config", "WebrootSampleFile.txt")
            $webrootOutputPath = "$TestDrive\my-webroot"
            $dataOutputPath = "$TestDrive\not-used-in-this-test"

            # Act
            Copy-RuntimeDependencyPackageContent -Package $installedPackage -WebrootOutputPath $webrootOutputPath -DataOutputPath $dataOutputPath

            # Assert
            $files = Get-ChildItem -Path $webrootOutputPath | Select-Object -ExpandProperty "Name"
            $files | Should Be $expectedFileNames
        }
    
        It "should copy 'Data' folder contents to the target data path" {
            # Arrange
            $expectedFileNames = @("DataSampleFile.txt")
            $webrootOutputPath = "$TestDrive\not-used-in-this-test"
            $dataOutputPath = "$TestDrive\my-data-folder"

            # Act
            Copy-RuntimeDependencyPackageContent -Package $installedPackage -WebrootOutputPath $webrootOutputPath -DataOutputPath $dataOutputPath

            # Assert
            $files = Get-ChildItem -Path $dataOutputPath | Select-Object -ExpandProperty "Name"
            $files | Should Be $expectedFileNames
        }
    }
}

# Test public functions
Describe "Publish-RuntimeDependencyPackage" {
    It "publishes package contents" {
        # Arrange
        $packageName = "sample-runtime-dependency"
        $packageVersion = "1.0.0"
        $packageSource = "$PSScriptRoot\..\TestContent\TestPackages\"
        $webrootOutputPath = "$TestDrive\my-webroot-folder"
        $dataOutputPath = "$TestDrive\my-data-folder"
        $expectedFileNames = @("DataSampleFile.txt", "Web.config", "WebrootSampleFile.txt")
        Uninstall-Package -Name $packageName -ErrorAction SilentlyContinue

        # Act
        Publish-RuntimeDependencyPackage -PackageName $packageName -PackageVersion $packageVersion -PackageSource $packageSource -WebrootOutputPath $webrootOutputPath -DataOutputPath $dataOutputPath

        # Assert
        $files = Get-ChildItem -Path $TestDrive -Recurse -File | Select-Object -ExpandProperty "Name"
        $files | Should Be $expectedFileNames
    }
}    
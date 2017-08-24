# Requires https://github.com/pester/Pester: Install-Module Pester -Force -SkipPublisherCheck
Import-Module "$PSScriptRoot\Install-RuntimeDependencyPackage.ps1" -Force

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
    It "should install NuGet packages from the specified source" {
        # Arrange
        $packageName = "jquery"
        $packageVersion = "3.1.1"
        $packageSource = "$PSScriptRoot\TestPackages\"

        # Act
        $installedPackage = Install-RuntimeDependencyPackage -PackageName $packageName -PackageVersion $packageVersion -PackageSource $packageSource

        # Assert
        $installedPackage.Name | Should Be $packageName
        $installedPackage.Version | Should Be $packageVersion
    }
}

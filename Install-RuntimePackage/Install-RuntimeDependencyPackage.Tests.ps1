# Requires https://github.com/pester/Pester: Install-Module Pester -Force -SkipPublisherCheck
Import-Module "$PSScriptRoot\Install-RuntimeDependencyPackage.ps1" -Force

Describe "Test-PackageProvider" {
    It "should return '$True' when the specified Package Provider is installed" {
        # Arrange
        $packageProvider = "NuGet"
    
        # Act
        $result = Test-PackageProvider $packageProvider
    
        # Assert
        $result | Should Be $True
    }

    It "should return '$False' when the specified Package Provider is not installed" {
        # Arrange
        $packageProvider = "This package provider is not installed"
    
        # Act
        $result = Test-PackageProvider $packageProvider
    
        # Assert
        $result | Should Be $False
    }
}

Describe "Get-RuntimeDependencyPackageFromCache" {  
    It "should find package by name and version" {
        # Arrange
        $packageName = "jQuery"
        $packageVersion = "3.1.1"
        $packageSource = "https://www.nuget.org/api/v2"
        Install-Package -Name $packageName -RequiredVersion $packageVersion -Source $packageSource -Force

        # Act
        $nugetPackage = Get-RuntimeDependencyPackageFromCache -PackageName $packageName -PackageVersion $packageVersion

        # Assert
        $nugetPackage | Should Not Be $Null
    }  

    It "should return null when package is not found" {
        # Arrange
        $packageName = "This package is not installed"
        $packageVersion = "1234567890"
    
        # Act
        $nugetPackage = Get-RuntimeDependencyPackageFromCache -PackageName $packageName -PackageVersion $packageVersion
    
        # Assert
        $nugetPackage | Should Be $Null
    }
}

Describe "Install-RuntimeDependencyPackage" {  
    It "should install NuGet packages from the specified source" {
        # Arrange
        $packageName = "jquery"
        $packageVersion = "3.1.1"
        $packageSource = "$PSScriptRoot\TestPackages\"
        Uninstall-Package -Name $packageName -RequiredVersion $packageVersion -ErrorAction SilentlyContinue

        # Act
        $package = Install-RuntimeDependencyPackage -PackageName $packageName -PackageVersion $packageVersion -PackageSource $packageSource

        # Assert
        $package.Name | Should Be $packageName
        $package.Version | Should Be $packageVersion
    }
}
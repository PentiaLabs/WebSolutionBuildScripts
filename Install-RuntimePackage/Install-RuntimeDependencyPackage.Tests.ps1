# Requires https://github.com/pester/Pester: Install-Module Pester -Force -SkipPublisherCheck
Import-Module "$PSScriptRoot\Install-RuntimeDependencyPackage.ps1" -Force

Describe "Get-RuntimeDependencyPackageFromCache" {  
    It "should find package by name and version" {
        # Arrange
        $packageName = "jQuery"
        $packageVersion = "3.1.1"
        Install-Package -Name $packageName -RequiredVersion $packageVersion -ProviderName "NuGet" #-ErrorAction SilentlyContinue

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
    # "Mock" doesn't work in PS 5 - see https://github.com/pester/Pester/wiki/Mocking-with-Pester
    # It "should display a helpful error when NuGet isn't resgistered as a package provider" {
    #     # Arrange
    #     Mock Get-PackageProvider { return @() }

    #     # Act
    #     $getPackage = { Get-RuntimeDependencyPackageFromCache -PackageName "jQuery" -PackageVersion "3.1.1" }

    #     # Assert
    #     $getPackage | Should Throw "The NuGet package provider isn't installed. Run 'Install-PackageProvider -Name NuGet' from an elevated PowerShell prompt."
    # }

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
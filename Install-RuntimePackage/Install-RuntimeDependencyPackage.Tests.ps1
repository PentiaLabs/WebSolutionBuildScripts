# Requires https://github.com/pester/Pester: Install-Module Pester -Force -SkipPublisherCheck
Import-Module "$PSScriptRoot\Install-RuntimeDependencyPackage.ps1" -Force

Describe "Get-RuntimeDependencyPackageFromCache" {  
    It "should find package by name and version" {
        # Arrange
        # TODO: Install a test package
        $packageName = "Sitecore.Full"
        $packageVersion = "8.2.170407"

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

Describe "Test-Url" {
    It "should return true for HTTP URL" {
        # Arrange
        $url = "http://localhost"

        # Act
        $isUrl = Test-Url $url

        # Assert
        $isUrl | Should Be $True
    }
    
    It "should return true for HTTPS URL" {
        # Arrange
        $url = "https://localhost"

        # Act
        $isUrl = Test-Url $url

        # Assert
        $isUrl | Should Be $True
    }
    
    It "should return false for file URI" {
        # Arrange
        $url = "file://C/Temp"

        # Act
        $isUrl = Test-Url $url

        # Assert
        $isUrl | Should Be $False
    }
}

Describe "Install-RuntimeDependencyPackage" {  
    It "should install NuGet packages from the specified source" {
        # Arrange
        $packageName = "Sitecore.Full"
        $packageVersion = "8.2.170407"

        # Act
        $nugetPackage = Install-RuntimeDependencyPackage -PackageName $packageName -PackageVersion $packageVersion

        # Assert
        $nugetPackage | Should Not Be $Null
    }
}
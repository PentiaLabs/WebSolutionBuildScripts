# Requires https://github.com/pester/Pester: Install-Module Pester -Force -SkipPublisherCheck
Import-Module "$PSScriptRoot\Install-RuntimeDependencyPackage.ps1" -Force

Describe "Get-RuntimeDependencyPackageFromCache" {
    It "should find packages by name and version" {
        # Arrange
        # TODO: Install a test package
        $packageName = "Sitecore.Full"
        $packageVersion = "8.2.1704071"

        # Act
        $nugetPackage = Get-RuntimeDependencyPackageFromCache -PackageName $packageName -PackageVersion $packageVersion

        # Assert
        $nugetPackage | Should Be $Null
    }
}

# It "should find packages by name and version" {
#     # Arrange

#     # Act

#     # Assert
    
# }
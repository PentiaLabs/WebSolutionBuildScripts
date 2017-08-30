# Requires https://github.com/pester/Pester: Install-Module Pester -Force -SkipPublisherCheck
Import-Module "$PSScriptRoot\Publish-HelixSolution.ps1" -Force

Describe "Get-RuntimeDependencies" {
    It "should throw an exception if the file doesn't exist" {
        # Arrange
        $runtimeDependencyConfigurationFilePath = "$TestDrive\test-configuration-file.config"

        # Act
        $invocation = { Get-RuntimeDependencies -ConfigurationFilePath $runtimeDependencyConfigurationFilePath }

        # Assert
        $invocation | Should Throw "File '$runtimeDependencyConfigurationFilePath' not found. Runtime dependencies are expected to be defined in '$runtimeDependencyConfigurationFilePath' by convention."
    }
    
    It "should throw an exception if the file isn't valid XML" {
        # Arrange
        $runtimeDependencyConfigurationFilePath = "$TestDrive\test-configuration-file.config"
        Set-Content -Path $runtimeDependencyConfigurationFilePath -Value "This isn't XML"
    
        # Act
        $invocation = { Get-RuntimeDependencies -ConfigurationFilePath $runtimeDependencyConfigurationFilePath }
    
        # Assert
        $invocation | Should Throw "File '$runtimeDependencyConfigurationFilePath' isn't valid XML. Run 'Get-Help Get-RuntimeDependencies -Full' for expected usage."
    }

    It "should throw an exception if the 'packages' element doesn't exist" {
        # Arrange
        $runtimeDependencyConfigurationFilePath = "$TestDrive\test-configuration-file.config"
        Set-Content -Path $runtimeDependencyConfigurationFilePath -Value "<root></root>"

        # Act
        $invocation = { Get-RuntimeDependencies -ConfigurationFilePath $runtimeDependencyConfigurationFilePath }

        # Assert
        $invocation | Should Throw "No 'packages' element found in '$runtimeDependencyConfigurationFilePath'. Run 'Get-Help XYZ' for correct usage."
    }

    It "should return all package references found in the configuration file" {
        # Arrange
        $runtimeDependencyConfigurationFilePath = "$TestDrive\test-configuration-file.config"
        $packagesConfig = '<?xml version="1.0" encoding="utf-8"?>
<packages>
    <package id="jQuery" version="3.1.1" />
    <package id="NLog" version="4.3.10" />
</packages>'
        Set-Content -Path $runtimeDependencyConfigurationFilePath -Value $packagesConfig

        # Act
        $runtimeDependencies = Get-RuntimeDependencies -ConfigurationFilePath $runtimeDependencyConfigurationFilePath

        # Assert
        $runtimeDependencies.Count | Should Be 2
        $runtimeDependencies[0].id | Should Be "jQuery"
        $runtimeDependencies[0].version | Should Be "3.1.1"
    }
}
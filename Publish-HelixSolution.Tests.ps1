# Requires https://github.com/pester/Pester: Install-Module Pester -Force -SkipPublisherCheck
Import-Module "$PSScriptRoot\Publish-HelixSolution.ps1" -Force

Describe "Get-RuntimeDependency" {
    It "should throw an exception if the file doesn't exist" {
        # Arrange
        $runtimeDependencyConfigurationFilePath = "$TestDrive\test-configuration-file.config"

        # Act
        $invocation = { Get-RuntimeDependency -ConfigurationFilePath $runtimeDependencyConfigurationFilePath }

        # Assert
        $invocation | Should Throw "File '$runtimeDependencyConfigurationFilePath' not found."
    }
    
    It "should throw an exception if the file isn't valid XML" {
        # Arrange
        $runtimeDependencyConfigurationFilePath = "$TestDrive\test-configuration-file.config"
        Set-Content -Path $runtimeDependencyConfigurationFilePath -Value "This isn't XML"
    
        # Act
        $invocation = { Get-RuntimeDependency -ConfigurationFilePath $runtimeDependencyConfigurationFilePath }
    
        # Assert
        $invocation | Should Throw "File '$runtimeDependencyConfigurationFilePath' isn't valid XML. Run 'Get-Help Get-RuntimeDependency -Full' for expected usage."
    }

    It "should throw an exception if the 'packages' element doesn't exist" {
        # Arrange
        $runtimeDependencyConfigurationFilePath = "$TestDrive\test-configuration-file.config"
        Set-Content -Path $runtimeDependencyConfigurationFilePath -Value "<root></root>"

        # Act
        $invocation = { Get-RuntimeDependency -ConfigurationFilePath $runtimeDependencyConfigurationFilePath }

        # Assert
        $invocation | Should Throw "No 'packages' root element found in '$runtimeDependencyConfigurationFilePath'. Run 'Get-Help Get-RuntimeDependency -Full' for expected usage."
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
        $runtimeDependencies = Get-RuntimeDependency -ConfigurationFilePath $runtimeDependencyConfigurationFilePath
        $jQuery = $runtimeDependencies | Select-Object -First 1
        $NLog = $runtimeDependencies | Select-Object -Last 1

        # Assert
        $runtimeDependencies.Count | Should Be 2
        $jQuery.id | Should Be "jQuery"
        $jQuery.version | Should Be "3.1.1"
        $NLog.id | Should Be "NLog"
        $NLog.version | Should Be "4.3.10"
    }
}
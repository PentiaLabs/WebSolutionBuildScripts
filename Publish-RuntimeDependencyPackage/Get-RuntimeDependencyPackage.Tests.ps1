# Requires https://github.com/pester/Pester: Install-Module Pester -Force -SkipPublisherCheck
Import-Module "$PSScriptRoot\Get-RuntimeDependencyPackage.psm1" -Force

Describe "Get-RuntimeDependencyPackage" {
    It "should throw an exception if the file doesn't exist" {
        # Arrange
        $runtimeDependencyConfigurationFilePath = "$TestDrive\test-configuration-file.config"

        # Act
        $invocation = { Get-RuntimeDependencyPackage -ConfigurationFilePath $runtimeDependencyConfigurationFilePath }

        # Assert
        $invocation | Should Throw "File '$runtimeDependencyConfigurationFilePath' not found."
    }
    
    It "should throw an exception if the file isn't valid XML" {
        # Arrange
        $runtimeDependencyConfigurationFilePath = "$TestDrive\test-configuration-file.config"
        Set-Content -Path $runtimeDependencyConfigurationFilePath -Value "This isn't XML"
    
        # Act
        $invocation = { Get-RuntimeDependencyPackage -ConfigurationFilePath $runtimeDependencyConfigurationFilePath }
    
        # Assert
        $invocation | Should Throw "File '$runtimeDependencyConfigurationFilePath' isn't valid XML. Run 'Get-Help Get-RuntimeDependencyPackage -Full' for expected usage."
    }

    It "should throw an exception if the 'packages' element doesn't exist" {
        # Arrange
        $runtimeDependencyConfigurationFilePath = "$TestDrive\test-configuration-file.config"
        Set-Content -Path $runtimeDependencyConfigurationFilePath -Value "<root></root>"

        # Act
        $invocation = { Get-RuntimeDependencyPackage -ConfigurationFilePath $runtimeDependencyConfigurationFilePath }

        # Assert
        $invocation | Should Throw "No 'packages' root element found in '$runtimeDependencyConfigurationFilePath'. Run 'Get-Help Get-RuntimeDependencyPackage -Full' for expected usage."
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
        $runtimeDependencies = Get-RuntimeDependencyPackage -ConfigurationFilePath $runtimeDependencyConfigurationFilePath
        $jQuery = $runtimeDependencies | Select-Object -First 1
        $NLog = $runtimeDependencies | Select-Object -Last 1

        # Assert
        $runtimeDependencies.Count | Should Be 2
        $jQuery.id | Should Be "jQuery"
        $jQuery.version | Should Be "3.1.1"
        $NLog.id | Should Be "NLog"
        $NLog.version | Should Be "4.3.10"
    }
    
    It "should return an array even if only one package reference is defined in the configuration file" {
        # Arrange
        $runtimeDependencyConfigurationFilePath = "$TestDrive\test-configuration-file.config"
        $packagesConfig = '<?xml version="1.0" encoding="utf-8"?>
    <packages>
        <package id="jQuery" version="3.1.1" />
    </packages>'
        Set-Content -Path $runtimeDependencyConfigurationFilePath -Value $packagesConfig
    
        # Act
        $runtimeDependencies = Get-RuntimeDependencyPackage -ConfigurationFilePath $runtimeDependencyConfigurationFilePath
        $jQuery = $runtimeDependencies[0]
    
        # Assert
        $runtimeDependencies.Count | Should Be 1
        $jQuery.id | Should Be "jQuery"
        $jQuery.version | Should Be "3.1.1"
    }
}
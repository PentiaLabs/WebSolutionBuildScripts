# Requires https://github.com/pester/Pester: Install-Module Pester -Force -SkipPublisherCheck
Import-Module "$PSScriptRoot\Publish-HelixSolution.ps1" -Force

Describe "Get-RuntimeDependencies" {
    It "should throw an exception if the file doesn't exist" {
        # Arrange
        $runtimeDependencyConfigurationFilePath = "$TestDrive\test-configuration-file.json"

        # Act
        $invocation = { Get-RuntimeDependencies -ConfigurationFilePath $runtimeDependencyConfigurationFilePath }

        # Assert
        $invocation | Should Throw "File '$runtimeDependencyConfigurationFilePath' not found. Runtime dependencies are expected to be defined in '$runtimeDependencyConfigurationFilePath' by convention."
    }
    
    It "should throw an exception if the file isn't valid JSON" {
        # Arrange
        $runtimeDependencyConfigurationFilePath = "$TestDrive\test-configuration-file.json"
        Set-Content -Path $runtimeDependencyConfigurationFilePath -Value "This is not JSON"
    
        # Act
        $invocation = { Get-RuntimeDependencies -ConfigurationFilePath $runtimeDependencyConfigurationFilePath }
    
        # Assert
        $invocation | Should Throw "The file '$runtimeDependencyConfigurationFilePath' isn't valid JSON. Run 'Get-Help XYZ' to see the expected configuration format."
    }

    It "should throw an exception if the 'packages' property doesn't exist" {
        # Arrange
        $runtimeDependencyConfigurationFilePath = "$TestDrive\test-configuration-file.json"
        Set-Content -Path $runtimeDependencyConfigurationFilePath -Value "{Packages:[]}"

        # Act
        $invocation = { Get-RuntimeDependencies -ConfigurationFilePath $runtimeDependencyConfigurationFilePath }

        # Assert
        $invocation | Should Throw "The 'packages' property doesn't exist in the configuration file '$runtimeDependencyConfigurationFilePath'."
    }

    It "should return all runtime dependencies in the configuration file" {
        # Arrange
        $runtimeDependencyConfigurationFilePath = "$TestDrive\test-configuration-file.json"
        $testPackage1Json = "{""name"":""Test 1"",""version:"":""1.0.0"",""location"":""not used""}"
        $testPackage2Json = "{""name"":""Test 2"",""version:"":""2.0.0"",""location"":""not used""}"
        Set-Content -Path $runtimeDependencyConfigurationFilePath -Value "{""packages"":[$testPackage1Json, $testPackage2Json]}"

        # Act
        $runtimeDependencies = Get-RuntimeDependencies -ConfigurationFilePath $runtimeDependencyConfigurationFilePath

        # Assert
        $runtimeDependencies.Count | Should Be 2
    }
}
# Requires https://github.com/pester/Pester: Install-Module Pester -Force -SkipPublisherCheck
#Requires -Modules Pester
Import-Module "$PSScriptRoot\Get-ConfigurationTransformFile.psm1" -Force

function New-ConfigTransformFile {
    param (
        [Parameter(Mandatory = $true)]
        [string]$FileName
    )
    $testConfigFile = "$TestDrive\src\$FileName"
    New-Item -Path "$TestDrive\src\" -ItemType Directory -ErrorAction SilentlyContinue | Out-Null
    Set-Content -Path $testConfigFile -Encoding UTF8 -Value "<?xml version=`"1.0`" encoding=`"utf-8`"?><configuration xmlns:xdt=`"http://schemas.microsoft.com/XML-Document-Transform`"><my-setting value=`"Feature.WebProject`" xdt:Transform=`"Insert`"/></configuration>"
    $testConfigFile
}

Describe "Get-ConfigurationTransformFile" {
    It "should throw an exception when SolutionRootPath is not a valid path" {
        # Arrange
        $nonValidPath = "A:\blabla"	
			
        # Act
        $invocation = {Get-ConfigurationTransformFile -SolutionRootPath $nonValidPath -BuildConfigurations "Debug"} 
 
        # Assert
        $invocation | Should Throw "Path '$nonValidPath' not found."
    }

    It "should return all *.config files for a given build configuration" {
        # Arrange
        $testConfigFile = "test.debug.config"
        $testConfigFile = New-ConfigTransformFile -FileName $testConfigFile

        # Act
        $transformFiles = Get-ConfigurationTransformFile -SolutionRootPath "$TestDrive" -BuildConfigurations "Debug"

        # Assert
        $transformFiles | Should Exist
        $transformFiles | Should Be $testConfigFile
    }

    It "should return all *.config files for multiple build configurations" {
        # Arrange
        $testConfigFiles = "test.debug.config", "test.release.config"
        $testConfigFiles = $testConfigFiles | ForEach-Object { New-ConfigTransformFile -FileName $_ }
        $buildConfigurations = "debug", "release"

        # Act
        $transformFiles = Get-ConfigurationTransformFile -SolutionRootPath $TestDrive -BuildConfigurations $buildConfigurations 

        # Assert
        $transformFiles | Should Be $testConfigFiles
        $transformFiles.Length | Should Be 2
    }

    It "should only return *.config files for the specified build configurations" {
        # Arrange
        $testConfigFiles = @("test.debug.config", "test.release.config", "test.development.config", "test.preproduction.config")
        $testConfigFiles = $testConfigFiles | ForEach-Object { New-ConfigTransformFile -FileName $_ }
        $buildConfigurations = "debug", "release"

        # Act
        $transformFiles = Get-ConfigurationTransformFile -SolutionRootPath $TestDrive -BuildConfigurations $buildConfigurations 

        # Assert 
        $transformFiles.Length | Should Be 2
        $transformFiles[0] | Should Be $testConfigFiles[0]
        $transformFiles[1] | Should Be $testConfigFiles[1]
    }

    It "should only return XML files with XDT equal to http://schemas.microsoft.com/XML-Document-Transform" {
        # Arrange
        $debugConfig = New-ConfigTransformFile -FileName "test.debug.config"
        $testConfigFile = "$TestDrive\Test.nonvalid.config"
        Set-Content -Path $testConfigFile -Encoding UTF8 -Value "<?xml version=`"1.0`" encoding=`"utf-8`"?><configuration><my-setting value=`"Feature.WebProject`"/></configuration>"
        $buildConfigurations = "nonvalid", "debug"

        # Act
        $transformFiles = Get-ConfigurationTransformFile -SolutionRootPath $TestDrive -BuildConfigurations $buildConfigurations
	
        # Assert
        $transformFiles | Should Be $debugConfig
    }

    It "should return an array of strings" {
        # Arrange
        $testConfigFiles = "test.debug.config", "test.release.config"
        $testConfigFiles = $testConfigFiles | ForEach-Object { New-ConfigTransformFile -FileName $_ }
        $buildConfigurations = "debug", "release"

        # Act
        $transformFiles = Get-ConfigurationTransformFile -SolutionRootPath $TestDrive -BuildConfigurations $buildConfigurations 
		
        # Assert
        # Command in front of the $transformFiles is the Powershell Unary operator, 
        # which tells powershell to send the entire object at once through the pipeline
        , $transformFiles | Should BeOfType System.Array
    }
    
    It "should exclude irrelevant system folders by default" {
        # Arrange
        $validConfiguration = "<?xml version=`"1.0`" encoding=`"utf-8`"?><configuration xmlns:xdt=`"http://schemas.microsoft.com/XML-Document-Transform`"><my-setting value=`"Feature.WebProject`" xdt:Transform=`"Insert`"/></configuration>"

        $nodeModules = New-Item -Path "$TestDrive\src\MyProject\code\node_modules" -ItemType Directory
        Set-Content -Path "$nodeModules\My.NodeModules.config" -Encoding UTF8 -Value $validConfiguration

        $bowerComponents = New-Item -Path "$TestDrive\src\MyProject\code\bower_components" -ItemType Directory
        Set-Content -Path "$bowerComponents\My.BowerComponents.config" -Encoding UTF8 -Value $validConfiguration
            
        # Act
        $actualProjects = Get-ConfigurationTransformFile -SolutionRootPath $TestDrive -BuildConfigurations "NodeModules", "BowerComponents"
            
        # Assert
        $actualProjects.Count | Should Be 0
    }
    
    It "should throw an exception when the XML is not valid" {
        #Arrange
        $testConfigFile = "$TestDrive\src\Test.debug.config"
        Set-Content -Path $testConfigFile -Encoding UTF8 -Value "Blaaaaarrgghh version=`"1.0`" encoding=`"utf-8`"?><configuration><my-setting value=`"Feature.WebProject`"/></configuration>"
        $buildConfigurations = "Debug"
    
        #Act
        #The pipe at the end tells powershell to pipe the error stream out into the variable
        $invocation = { Get-ConfigurationTransformFile -SolutionRootPath $TestDrive -BuildConfigurations $buildConfigurations }
        
        #Assert
        $invocation | Should Throw "Error reading XML file '$testConfigFile': Exception calling `"Load`" with `"1`" argument(s): `"Data at the root level is invalid. Line 1, position 1.`""
    }
}

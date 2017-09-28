# Requires https://github.com/pester/Pester: Install-Module Pester -Force -SkipPublisherCheck
#Requires -Modules Pester
Import-Module "$PSScriptRoot\Get-ConfigurationTransformFile.psm1" -Force

Function New-ConfigTransformFile ($path) {
    $testConfigFile = "$TestDrive\$path"
    Set-Content -Path $testConfigFile -Encoding UTF8 -Value "<?xml version=`"1.0`" encoding=`"utf-8`"?><configuration xmlns:xdt=`"http://schemas.microsoft.com/XML-Document-Transform`"><my-setting value=`"Feature.WebProject`" xdt:Transform=`"Insert`"/></configuration>"
    return $testConfigFile
}

Describe "Get-ConfigurationTransformFile" {
    It "should throw an exception when SolutionRootPath is not a valid path" {
        # Arrange
        $nonValidPath = "A:\blabla"	
			
        # Act
        $invocation = {Get-ConfigurationTransformFile -SolutionRootPath $nonValidPath -BuildConfigurations "Debug"} 
 
        # Assert
        $invocation | Should throw "Path '$nonValidPath' not found."
    }

    It "should return all *.config files for a given build configuration" {
        # Arrange
        $testConfigFile = "test.debug.config"
        $testConfigFile = New-ConfigTransformFile -path $testConfigFile

        # Act
        $transformFiles = Get-ConfigurationTransformFile -SolutionRootPath "$TestDrive" -BuildConfigurations "Debug"

        # Assert
        $transformFiles | Should Exist
        $transformFiles | Should be $testConfigFile
    }

    It "should return all *.config files for multiple build configurations" {
        # Arrange
        $testConfigFiles = "test.debug.config", "test.release.config"
        $testConfigFiles = $testConfigFiles | ForEach-Object { New-ConfigTransformFile -path $_ }
        $buildConfigurations = "debug", "release"

        # Act
        $transformFiles = Get-ConfigurationTransformFile -SolutionRootPath $TestDrive -BuildConfigurations $buildConfigurations 

        # Assert
        $transformFiles | Should be $testConfigFiles
        $transformFiles.Length | Should be 2
    }

    It "should only return *.config files for the specified build configurations" {
        # Arrange
        $testConfigFiles = @("test.debug.config", "test.release.config", "test.development.config", "test.preproduction.config")
        $testConfigFiles = $testConfigFiles | ForEach-Object { New-ConfigTransformFile -path $_ }
        $buildConfigurations = "debug", "release"

        # Act
        $transformFiles = Get-ConfigurationTransformFile -SolutionRootPath $TestDrive -BuildConfigurations $buildConfigurations 

        # Assert 
        $transformFiles.Length | Should be 2
        $transformFiles[0] | Should be $testConfigFiles[0]
        $transformFiles[1] | Should be $testConfigFiles[1]
    }

    It "should only return XML files with XDT equal to http://schemas.microsoft.com/XML-Document-Transform" {
        # Arrange
        $debugConfig = New-ConfigTransformFile -path "test.debug.config"
        $testConfigFile = "$TestDrive\Test.nonvalid.config"
        Set-Content -Path $testConfigFile -Encoding UTF8 -Value "<?xml version=`"1.0`" encoding=`"utf-8`"?><configuration><my-setting value=`"Feature.WebProject`"/></configuration>"
        $buildConfigurations = "nonvalid", "debug"

        # Act
        $transformFiles = Get-ConfigurationTransformFile -SolutionRootPath $TestDrive -BuildConfigurations $buildConfigurations
	
        # Assert
        $transformFiles | Should be $debugConfig
    }

    It "should return an array of strings" {
        # Arrange
        $testConfigFiles = "test.debug.config", "test.release.config"
        $testConfigFiles = $testConfigFiles | ForEach-Object { New-ConfigTransformFile -path $_ }
        $buildConfigurations = "debug", "release"

        # Act
        $transformFiles = Get-ConfigurationTransformFile -SolutionRootPath $TestDrive -BuildConfigurations $buildConfigurations 
		
        # Assert
        # Command in front of the $transformFiles is the Powershell Unary operator, 
        # which tells powershell to send the entire object at once through the pipeline
        , $transformFiles | Should BeOfType System.Array
    }

    It "should throw an exception when the XML is not valid" {
        #Arrange
        $testConfigFile = "$TestDrive\Test.debug.config"
        Set-Content -Path $testConfigFile -Encoding UTF8 -Value "Blaaaaarrgghh version=`"1.0`" encoding=`"utf-8`"?><configuration><my-setting value=`"Feature.WebProject`"/></configuration>"
        $buildConfigurations = "Debug"

        #Act
        #The pipe at the end tells powershell to pipe the error stream out into the variable
        $invocation = { Get-ConfigurationTransformFile -SolutionRootPath $TestDrive -BuildConfigurations $buildConfigurations }
	
        #Assert
        $invocation | Should Throw "Error reading XML file '$testConfigFile': Exception calling `"Load`" with `"1`" argument(s): `"Data at the root level is invalid. Line 1, position 1.`""
    }
}

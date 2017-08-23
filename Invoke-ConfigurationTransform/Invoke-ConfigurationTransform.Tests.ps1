# Requires https://github.com/pester/Pester: Install-Module Pester -Force -SkipPublisherCheck
Import-Module "$PSScriptRoot\Invoke-ConfigurationTransform.psm1" -Force

Describe "Get-PathOfFileToTransform" {
    It "should return the path of the file to transform" {
        # Arrange
        $configurationTransformFilePath = "C:\MySolution\src\Foundation\MyProject\Code\App_Config\MyConfig.Debug.config"
        $webrootDirectory = "C:\webroot"
        $expectedPath = "C:\webroot\App_Config\MyConfig.config"

        # Act
        $actualPath = Get-PathOfFileToTransform -ConfigurationTransformFilePath $configurationTransformFilePath -WebrootDirectory $webrootDirectory

        # Assert
        $actualPath | Should Be $expectedPath
    }
}

Describe "Invoke-ConfigurationTransform" {
    It "can transform XML using XDT" {
        # Arrange
        Set-Content -Path "TestDrive:\test.config" -Value "<?xml version=""1.0"" encoding=""utf-8""?><configuration></configuration>"
        Set-Content -Path "TestDrive:\test.Transform.config" -Value "<configuration xmlns:xdt=""http://schemas.microsoft.com/XML-Document-Transform""><setting xdt:Transform=""Insert"" /></configuration>"
        
        $expectedTransformedContent = "<?xml version=""1.0"" encoding=""utf-8""?><configuration><setting /></configuration>"
        
        # Act
        $transformedXML = Invoke-ConfigurationTransform -XmlFilePath "$TestDrive\test.config" -XdtFilePath "$TestDrive\test.Transform.config"
        
        # Assert
        $transformedXML | Should Be $expectedTransformedContent
    }
}

Describe "Configuration transformation integration test" {    
    It "applies configuration transforms to the correct configuration file in the webroot" {
        # Arrange
        New-Item -Path "TestDrive:\WebsiteRoot\" -ItemType Directory
        New-Item -Path "TestDrive:\WebsiteRoot\App_Config" -ItemType Directory
        Set-Content -Path "TestDrive:\WebsiteRoot\App_Config\Web.config" -Value "<?xml version=""1.0"" encoding=""utf-8""?><configuration></configuration>"
        $webrootDirectory = "$TestDrive\WebsiteRoot\"
        
        New-Item -Path "TestDrive:\ProjectRoot" -ItemType Directory
        New-Item -Path "TestDrive:\ProjectRoot\App_Config" -ItemType Directory
        Set-Content -Path "TestDrive:\ProjectRoot\App_Config\Web.Debug.config" -Value "<configuration xmlns:xdt=""http://schemas.microsoft.com/XML-Document-Transform""><setting xdt:Transform=""Insert"" /></configuration>"
        $configurationTransformFilePath = "$TestDrive\ProjectRoot\App_Config\Web.Debug.config"
        
        $expectedTransformedContent = "<?xml version=""1.0"" encoding=""utf-8""?><configuration><setting /></configuration>"

        # Act
        $pathOfFileToTransform = Get-PathOfFileToTransform -ConfigurationTransformFilePath $configurationTransformFilePath -WebrootDirectory $webrootDirectory
        $transformedContent = Invoke-ConfigurationTransform -XmlFilePath $pathOfFileToTransform -XdtFilePath $configurationTransformFilePath
        $transformedContent | Out-File $pathOfFileToTransform -Encoding utf8

        # Assert
        $transformedContent = Get-Content -Path "TestDrive:\WebsiteRoot\App_Config\Web.config"
        $transformedContent | Should Be $expectedTransformedContent
    }
}
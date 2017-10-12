# Requires https://github.com/pester/Pester: Install-Module Pester -Force -SkipPublisherCheck
Import-Module "$PSScriptRoot\Invoke-ConfigurationTransform.psm1" -Force

Describe "Get-PathOfFileToTransform" {
    It "should return the path of the file to transform" {
        # Arrange
        $configurationTransformFilePath = "C:\MySolution\src\Foundation\MyProject\Code\App_Config\MyConfig.Debug.config"
        $webrootOutputPath = "C:\webroot"
        $expectedPath = "C:\webroot\App_Config\MyConfig.config"

        # Act
        $actualPath = Get-PathOfFileToTransform -ConfigurationTransformFilePath $configurationTransformFilePath -WebrootOutputPath $webrootOutputPath

        # Assert
        $actualPath | Should Be $expectedPath
    }
    
    It "should return the path of the Web.config file to transform" {
        # Arrange
        $configurationTransformFilePath = "C:\MySolution\src\Foundation\MyProject\Code\Web.Feature.WebProject.Debug.config"
        $webrootOutputPath = "C:\webroot"
        $expectedPath = "C:\webroot\Web.config"

        # Act
        $actualPath = Get-PathOfFileToTransform -ConfigurationTransformFilePath $configurationTransformFilePath -WebrootOutputPath $webrootOutputPath

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

    It "applies multiple XDTs as expected" {
        # Arrange
        $configurationFilePath = "TestDrive:\test.config"
        Set-Content -Path $configurationFilePath -Value "<?xml version=""1.0"" encoding=""utf-8""?><configuration></configuration>"
        Set-Content -Path "TestDrive:\test.Transform1.config" -Value "<configuration xmlns:xdt=""http://schemas.microsoft.com/XML-Document-Transform""><setting value=""one"" xdt:Transform=""Insert"" /></configuration>"
        Set-Content -Path "TestDrive:\test.Transform2.config" -Value "<configuration xmlns:xdt=""http://schemas.microsoft.com/XML-Document-Transform""><setting value=""two"" xdt:Transform=""Insert"" /></configuration>"
        
        $expectedTransformedContent = "<?xml version=""1.0"" encoding=""utf-8""?><configuration><setting value=""one"" /><setting value=""two"" /></configuration>"
        
        # Act
        Invoke-ConfigurationTransform -XmlFilePath "$TestDrive\test.config" -XdtFilePath "$TestDrive\test.Transform1.config" | Set-Content -Path $configurationFilePath
        Invoke-ConfigurationTransform -XmlFilePath "$TestDrive\test.config" -XdtFilePath "$TestDrive\test.Transform2.config" | Set-Content -Path $configurationFilePath
        $transformedXML = Get-Content -Path $configurationFilePath
        
        # Assert
        $transformedXML | Should Be $expectedTransformedContent
    }
}

Describe "Configuration transformation integration test" {    
    It "applies configuration transforms to the correct configuration file in the webroot" {
        # Arrange
        New-Item -Path "TestDrive:\WebsiteRoot\" -ItemType Directory
        New-Item -Path "TestDrive:\WebsiteRoot\App_Config" -ItemType Directory
        Set-Content -Path "TestDrive:\WebsiteRoot\App_Config\MyConfig.config" -Value "<?xml version=""1.0"" encoding=""utf-8""?><configuration></configuration>"
        $webrootOutputPath = "$TestDrive\WebsiteRoot\"
        
        New-Item -Path "TestDrive:\ProjectRoot" -ItemType Directory
        New-Item -Path "TestDrive:\ProjectRoot\App_Config" -ItemType Directory
        Set-Content -Path "TestDrive:\ProjectRoot\App_Config\MyConfig.Debug.config" -Value "<configuration xmlns:xdt=""http://schemas.microsoft.com/XML-Document-Transform""><setting xdt:Transform=""Insert"" /></configuration>"
        $configurationTransformFilePath = "$TestDrive\ProjectRoot\App_Config\MyConfig.Debug.config"
        
        $expectedTransformedContent = "<?xml version=""1.0"" encoding=""utf-8""?><configuration><setting /></configuration>"

        # Act
        $pathOfFileToTransform = Get-PathOfFileToTransform -ConfigurationTransformFilePath $configurationTransformFilePath -WebrootOutputPath $webrootOutputPath
        $transformedContent = Invoke-ConfigurationTransform -XmlFilePath $pathOfFileToTransform -XdtFilePath $configurationTransformFilePath
        $transformedContent | Out-File $pathOfFileToTransform -Encoding utf8

        # Assert
        $transformedContent = Get-Content -Path "TestDrive:\WebsiteRoot\App_Config\MyConfig.config"
        $transformedContent | Should Be $expectedTransformedContent
    }
}
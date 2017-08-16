# Requires https://github.com/pester/Pester: Install-Module Pester -Force -SkipPublisherCheck
. "$PSScriptRoot\Invoke-ConfigurationTransform.ps1"

Describe "Invoke-ConfigurationTransform" {
    It "applies configuration transforms to the correct configuration file in the webroot" {
        # Arrange
        New-Item -Path "TestDrive:\WebsiteRoot\" -ItemType Directory
        New-Item -Path "TestDrive:\WebsiteRoot\App_Config" -ItemType Directory
        Set-Content -Path "TestDrive:\WebsiteRoot\App_Config\Web.config" -Value "<?xml version=""1.0"" encoding=""utf-8""?><configuration></configuration>"
        $websiteRoot = "$TestDrive\WebsiteRoot\"
        
        New-Item -Path "TestDrive:\ProjectRoot" -ItemType Directory
        New-Item -Path "TestDrive:\ProjectRoot\App_Config" -ItemType Directory
        Set-Content -Path "TestDrive:\ProjectRoot\App_Config\Web.Debug.config" -Value "<configuration xmlns:xdt=""http://schemas.microsoft.com/XML-Document-Transform""><setting xdt:Transform=""Insert"" /></configuration>"
        $configurationTransformFilePath = "$TestDrive\ProjectRoot\App_Config\Web.Debug.config"
        
        $expectedTransformedContent = "<?xml version=""1.0"" encoding=""utf-8""?><configuration><setting /></configuration>"

        # Act
        $result = Invoke-ConfigurationTransform -ConfigurationTransformFilePath $configurationTransformFilePath -WebrootDirectory $websiteRoot

        # Assert
        $result | Should Be $expectedTransformedContent
    }
}
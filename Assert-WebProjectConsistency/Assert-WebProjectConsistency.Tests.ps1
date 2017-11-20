Import-Module "$PSScriptRoot\Assert-WebProjectConsistency.psm1" -Force

Describe "Assert-WebProjectConsistency" {
  
    InModuleScope "Assert-WebProjectConsistency" {
  
        Describe "Test-SlowCheetah" {
            It "should find references to SlowCheetah" {
                # Arrange
                $projectFileWithSlowCheetah = "<?xml version=`"1.0`" encoding=`"utf-8`"?>
                <Project ToolsVersion=`"14.0`" DefaultTargets=`"Build`" xmlns=`"http://schemas.microsoft.com/developer/msbuild/2003`">
                  <Import Project=`"..\..\..\..\packages\SlowCheetah.2.5.48\build\SlowCheetah.targets`" Condition=`"Exists('..\..\..\..\packages\SlowCheetah.2.5.48\build\SlowCheetah.targets')`" />
                  <Target Name=`"EnsureNuGetPackageBuildImports`" BeforeTargets=`"PrepareForBuild`">
                    <PropertyGroup>
                      <ErrorText>This project references NuGet package(s) that are missing on this computer. Use NuGet Package Restore to download them.  For more information, see http://go.microsoft.com/fwlink/?LinkID=322105. The missing file is {0}.</ErrorText>
                    </PropertyGroup>
                    <Error Condition=`"!Exists('..\..\..\..\packages\SlowCheetah.2.5.48\build\SlowCheetah.targets')`" Text=`"`$([System.String]::Format('`$(ErrorText)', '..\..\..\..\packages\SlowCheetah.2.5.48\build\SlowCheetah.targets'))`" />
                  </Target>
                </Project>"
                $filePath = "$TestDrive/sample.config"
                Set-Content -Path $filePath -Value $projectFileWithSlowCheetah -Encoding UTF8
  
                # Act
                $containsSlowCheetah = Test-SlowCheetah -ProjectFilePath $filePath
  
                # Assert
                $containsSlowCheetah | Should Be $True
            }

            It "should find no references to SlowCheetah" {
                # Arrange
                $projectFileWithoutSlowCheetah = "<?xml version=`"1.0`" encoding=`"utf-8`"?>
                <Project ToolsVersion=`"14.0`" DefaultTargets=`"Build`" xmlns=`"http://schemas.microsoft.com/developer/msbuild/2003`">
                  <Import Project=`"..\..\..\..\packages\SlowCheetos.2.5.48\build\SlowCheetos.targets`" Condition=`"Exists('..\..\..\..\packages\SlowCheetos.2.5.48\build\SlowCheetos.targets')`" />
                  <Target Name=`"EnsureNuGetPackageBuildImports`" BeforeTargets=`"PrepareForBuild`">
                    <PropertyGroup>
                      <ErrorText>This project references NuGet package(s) that are missing on this computer. Use NuGet Package Restore to download them.  For more information, see http://go.microsoft.com/fwlink/?LinkID=322105. The missing file is {0}.</ErrorText>
                    </PropertyGroup>
                    <Error Condition=`"!Exists('..\..\..\..\packages\SlowCheetos.2.5.48\build\SlowCheetos.targets')`" Text=`"`$([System.String]::Format('`$(ErrorText)', '..\..\..\..\packages\SlowCheetos.2.5.48\build\SlowCheetos.targets'))`" />
                  </Target>
                </Project>"
                $filePath = "$TestDrive/sample.config"
                Set-Content -Path $filePath -Value $projectFileWithoutSlowCheetah -Encoding UTF8

                # Act
                $containsSlowCheetah = Test-SlowCheetah -ProjectFilePath $filePath

                # Assert
                $containsSlowCheetah | Should Be $False
            }
        }

        Describe "Test-XdtBuildAction" {
            It "should detect incorrect build action" {
                # Arrange
                $projectFileContents = "<?xml version=`"1.0`" encoding=`"utf-8`"?>
                <Project ToolsVersion=`"14.0`" DefaultTargets=`"Build`" xmlns=`"http://schemas.microsoft.com/developer/msbuild/2003`">
                  <ItemGroup>
                    <Content Include=`"App_Config\ConnectionStrings.config`"></Content>
                    <None Include=`"App_Config\ConnectionStrings.Debug.config`"></None>
                    <Content Include=`"App_Config\ConnectionStrings.Release.config`"></Content>
                  </ItemGroup>
                </Project>"
                $filePath = "$TestDrive/sample.config"
                Set-Content -Path $filePath -Value $projectFileContents -Encoding UTF8

                # Act
                $hasCorrectBuildAction = Test-XdtBuildActionContent -BuildConfiguration "Debug" -ProjectFilePath $filePath

                # Assert
                $hasCorrectBuildAction | Should Be $False
            }

            It "should detect correct build action" {
                # Arrange
                $projectFileContents = "<?xml version=`"1.0`" encoding=`"utf-8`"?>
                <Project ToolsVersion=`"14.0`" DefaultTargets=`"Build`" xmlns=`"http://schemas.microsoft.com/developer/msbuild/2003`">
                  <ItemGroup>
                    <Content Include=`"App_Config\ConnectionStrings.config`"></Content>
                    <None Include=`"App_Config\ConnectionStrings.Debug.config`"></None>
                    <Content Include=`"App_Config\ConnectionStrings.Release.config`"></Content>
                  </ItemGroup>
                </Project>"
                $filePath = "$TestDrive/sample.config"
                Set-Content -Path $filePath -Value $projectFileContents -Encoding UTF8

                # Act
                $hasCorrectBuildAction = Test-XdtBuildActionContent -BuildConfiguration "Release" -ProjectFilePath $filePath

                # Assert
                $hasCorrectBuildAction | Should Be $True
            }
        }

        Describe "Test-ReservedFilePath" {
            It "should warn about files named ""Web.config""" {
                # Arrange
                $projectFileContents = "<?xml version=`"1.0`" encoding=`"utf-8`"?>
                <Project ToolsVersion=`"14.0`" DefaultTargets=`"Build`" xmlns=`"http://schemas.microsoft.com/developer/msbuild/2003`">
                  <ItemGroup>
                    <Content Include=`"Web.config`"></Content>
                  </ItemGroup>
                </Project>"
                $filePath = "$TestDrive/sample.config"
                Set-Content -Path $filePath -Value $projectFileContents -Encoding UTF8

                # Act
                $containsFilesWithReservedPath = Test-ReservedFilePath -ProjectFilePath $filePath

                # Assert
                $containsFilesWithReservedPath | Should Be $True
            }

            It "should ignore irrelevant file names" {
                # Arrange
                $projectFileContents = "<?xml version=`"1.0`" encoding=`"utf-8`"?>
                <Project ToolsVersion=`"14.0`" DefaultTargets=`"Build`" xmlns=`"http://schemas.microsoft.com/developer/msbuild/2003`">
                  <ItemGroup>
                    <Content Include=`"Views\Web.config`"></Content>
                    <Content Include=`"App_Config\Web.config`"></Content>
                  </ItemGroup>
                </Project>"
                $filePath = "$TestDrive/sample.config"
                Set-Content -Path $filePath -Value $projectFileContents -Encoding UTF8

                # Act
                $containsFilesWithReservedPath = Test-ReservedFilePath -ProjectFilePath $filePath

                # Assert
                $containsFilesWithReservedPath | Should Be $False
            }
        }
        
        Describe "Test-XmlDeclaration" {
            It "should detect existance of an XML declaration" {
                # Arrange
                $filePath = "$TestDrive/sample.config"
                Set-Content -Path $filePath -Value "<?xml version=`"1.0`" encoding=`"utf-8`"?><Project />" -Encoding UTF8
            
                # Act
                $hasXmlDeclaration = Test-XmlDeclaration -Path $filePath
            
                # Assert
                $hasXmlDeclaration | Should Be $True
            }
        
            It "should detect missing XML declaration" {
                # Arrange
                $filePath = "$TestDrive/sample.config"
                Set-Content -Path $filePath -Value "<Project />" -Encoding UTF8
        
                # Act
                $hasXmlDeclaration = Test-XmlDeclaration -Path $filePath
        
                # Assert
                $hasXmlDeclaration | Should Be $False
            }
        }

        Describe "Test-XmlFileEncoding" {          
            It "should handle missing XML declaration" {
                # Arrange
                $filePath = "$TestDrive/sample.config"
                Set-Content -Path $filePath -Value "<Project />" -Encoding Ascii
          
                # Act
                $hasCorrectEncoding = Test-XmlFileEncoding -Path $filePath

                # Assert
                $hasCorrectEncoding | Should Be $False
            }

            It "should detect file encoding match" {
                # Arrange
                $filePath = "$TestDrive/sample.config"
                Set-Content -Path $filePath -Value "<?xml version=`"1.0`" encoding=`"utf-8`"?><Project />" -Encoding UTF8
        
                # Act
                $hasCorrectEncoding = Test-XmlFileEncoding -Path $filePath
        
                # Assert
                $hasCorrectEncoding | Should Be $True
            }
          
            It "should detect file encoding mismatch" {
                # Arrange
                $filePath = "$TestDrive/sample.config"
                Set-Content -Path $filePath -Value "<?xml version=`"1.0`" encoding=`"utf-8`"?><Project />" -Encoding Ascii
          
                # Act
                $hasCorrectEncoding = Test-XmlFileEncoding -Path $filePath
          
                # Assert
                $hasCorrectEncoding | Should Be $False
            }
        }
    }
}

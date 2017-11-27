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

        Describe "Test-ContentFileExists" {
            $ProjectFilePath = "$TestDrive\temp.csproj"
            $ProjectFileContent = "<Test><Content Include=""MyFile.txt""></Content></Test>"
            $AbsoluteContentFilePath = "$TestDrive\MyFile.txt"
            Set-Content -Path $ProjectFilePath -Value $ProjectFileContent -Encoding UTF8

            It "should detect existing file" {
                # Arrange
                Set-Content -Path $AbsoluteContentFilePath -Value "Hello World!"

                # Act
                $referencedFileExists = Test-ContentFileExists -ProjectFilePath $ProjectFilePath

                # Assert
                $referencedFileExists | Should Be $True
            }

            It "should detect missing file" {
                # Arrange
                Remove-Item -Path $AbsoluteContentFilePath -ErrorAction SilentlyContinue
                
                # Act
                $referencedFileExists = Test-ContentFileExists -ProjectFilePath $ProjectFilePath
                
                # Assert
                $referencedFileExists | Should Be $False
            }
        }

        Describe "Test-BuildConfigurationExists" {

            $ProjectFileContent = "<?xml version=""1.0"" encoding=""utf-8""?>
            <Project ToolsVersion=""14.0"" DefaultTargets=""Build"" xmlns=""http://schemas.microsoft.com/developer/msbuild/2003"">
              <Import Project=""`$(MSBuildExtensionsPath)\`$(MSBuildToolsVersion)\Microsoft.Common.props"" Condition=""Exists('`$(MSBuildExtensionsPath)\`$(MSBuildToolsVersion)\Microsoft.Common.props')"" />
              <PropertyGroup>
                <Configuration Condition="" '`$(Configuration)' == '' "">Debug</Configuration>
                <Platform Condition="" '`$(Platform)' == '' "">AnyCPU</Platform>
                <ProjectGuid>{EA2CCCED-A0F6-48AB-BC14-96D290BF2B47}</ProjectGuid>
                <OutputType>Library</OutputType>
                <AppDesignerFolder>Properties</AppDesignerFolder>
                <RootNamespace>Cabana.Arwen.Navigation</RootNamespace>
                <AssemblyName>Cabana.Arwen.Navigation</AssemblyName>
                <TargetFrameworkVersion>v4.6.1</TargetFrameworkVersion>
                <FileAlignment>512</FileAlignment>
                <TargetFrameworkProfile />
              </PropertyGroup>
              <PropertyGroup Condition="" '`$(Configuration)|`$(Platform)' == 'Debug|AnyCPU' "">
                <DebugSymbols>true</DebugSymbols>
                <DebugType>full</DebugType>
                <Optimize>false</Optimize>
                <OutputPath>bin\Debug\</OutputPath>
                <DefineConstants>DEBUG;TRACE</DefineConstants>
                <ErrorReport>prompt</ErrorReport>
                <WarningLevel>4</WarningLevel>
              </PropertyGroup>
              <PropertyGroup Condition="" '`$(Configuration)|`$(Platform)' == 'Release|AnyCPU' "">
                <DebugType>pdbonly</DebugType>
                <Optimize>true</Optimize>
                <OutputPath>bin\Release\</OutputPath>
                <DefineConstants>TRACE</DefineConstants>
                <ErrorReport>prompt</ErrorReport>
                <WarningLevel>4</WarningLevel>
              </PropertyGroup>
              <PropertyGroup Condition=""'`$(Configuration)|`$(Platform)' == 'Dev|AnyCPU'"">
                <DebugSymbols>true</DebugSymbols>
                <OutputPath>bin\Dev\</OutputPath>
                <DefineConstants>DEBUG;TRACE</DefineConstants>
                <DebugType>full</DebugType>
                <PlatformTarget>AnyCPU</PlatformTarget>
                <ErrorReport>prompt</ErrorReport>
                <CodeAnalysisRuleSet>MinimumRecommendedRules.ruleset</CodeAnalysisRuleSet>
              </PropertyGroup>
              <PropertyGroup Condition=""'`$(Configuration)|`$(Platform)' == 'Test|AnyCPU'"">
                <DebugSymbols>true</DebugSymbols>
                <OutputPath>bin\Test\</OutputPath>
                <DefineConstants>DEBUG;TRACE</DefineConstants>
                <DebugType>full</DebugType>
                <PlatformTarget>AnyCPU</PlatformTarget>
                <ErrorReport>prompt</ErrorReport>
                <CodeAnalysisRuleSet>MinimumRecommendedRules.ruleset</CodeAnalysisRuleSet>
              </PropertyGroup>
              <PropertyGroup Condition=""'`$(Configuration)|`$(Platform)' == 'Staging|AnyCPU'"">
                <OutputPath>bin\Staging\</OutputPath>
              </PropertyGroup>
            </Project>"
            $ProjectFilePath = "$TestDrive\temp.csproj"
            
            It "should detect existing build configuration" {
                # Arrange
                Set-Content -Path  $ProjectFilePath -Value $ProjectFileContent -Encoding UTF8
            
                # Act
                $buildConfigurationExists = Test-BuildConfigurationExists -ProjectFilePath $ProjectFilePath -BuildConfiguration "Staging"
            
                # Assert
                $buildConfigurationExists | Should Be $True
            }
            
            It "should detect missing build configuration" {
                # Arrange
                Set-Content -Path  $ProjectFilePath -Value $ProjectFileContent -Encoding UTF8
                            
                # Act
                $buildConfigurationExists = Test-BuildConfigurationExists -ProjectFilePath $ProjectFilePath -BuildConfiguration "something that does not exist"

                # Assert
                $buildConfigurationExists | Should Be $False
            }
        }
    }
}

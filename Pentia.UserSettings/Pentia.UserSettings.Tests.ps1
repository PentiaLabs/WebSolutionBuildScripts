# Requires https://github.com/pester/Pester: Install-Module Pester -Force -SkipPublisherCheck
Import-Module "$PSScriptRoot\Pentia.UserSettings.psm1" -Force

Describe "UserSettings" {    

    Describe "Set-UserSettings" {
        $SolutionRootPath = $TestDrive

        It "should write user settings to the specified settings path" {
            # Arrange
            $settings = @{
                webrootOutputPath  = "$TestDrive\www"
                dataOutputPath     = "$TestDrive\data"
                buildConfiguration = "Debug"
            }

            # Act
            Set-UserSettings -Settings $settings -SolutionRootPath $SolutionRootPath

            # Assert
            Test-Path $SolutionRootPath | Should Be $true
        }
    
        It "should save user settings as valid JSON" {
            # Arrange
            $settings = @{
                webrootOutputPath  = "$TestDrive\www"
                dataOutputPath     = "$TestDrive\data"
                buildConfiguration = "Debug"
            }

            # Act
            $savedSettings = Get-Content "$SolutionRootPath/.pentia/user-settings.json" | ConvertFrom-Json

            # Assert
            $savedSettings.webrootOutputPath | Should Be $settings.webrootOutputPath
            $savedSettings.dataOutputPath | Should Be $settings.dataOutputPath
            $savedSettings.buildConfiguration | Should Be $settings.buildConfiguration
        }
    }
    
    Describe "Get-UserSettings" {
        It "should return an empty object if no user settings are found" {
            # Arrange
            $solutionRootPath = "$TestDrive"
            
            # Act
            $savedSettings = Get-UserSettings -SolutionRootPath $solutionRootPath

            # Assert
            $savedSettings | Should Not Be $null
        }
    
        It "should read user settings from the default settings path" {
            # Arrange
            $settings = @{
                webrootOutputPath  = "$TestDrive\www"
                dataOutputPath     = "$TestDrive\data"
                buildConfiguration = "Debug"
            }
            $solutionRootPath = $TestDrive
            Set-UserSettings -Settings $settings -SolutionRootPath $solutionRootPath

            # Act
            $savedSettings = Get-UserSettings -SolutionRootPath $solutionRootPath

            # Assert
            $savedSettings.webrootOutputPath | Should Be $settings.webrootOutputPath
            $savedSettings.dataOutputPath | Should Be $settings.dataOutputPath
            $savedSettings.buildConfiguration | Should Be $settings.buildConfiguration
        }
    }

    Describe "Merge-ParametersAndUserSettings" {
        It "should use saved user settings as fallback values when input is null or empty" {
            # Arrange
            $settings = @{
                webrootOutputPath  = "$TestDrive\www"
                dataOutputPath     = "$TestDrive\data"
                buildConfiguration = "Debug"
            }

            # Act
            $mergedSettings = Merge-ParametersAndUserSettings -Settings $settings -WebrootOutputPath $null -DataOutputPath "" -BuildConfiguration " "

            # Assert
            $mergedSettings.webrootOutputPath | Should Be $settings.webrootOutputPath
            $mergedSettings.dataOutputPath | Should Be $settings.dataOutputPath
            $mergedSettings.buildConfiguration | Should Be $settings.buildConfiguration
        }

        It "should use function parameters when they're not null or empty" {
            # Arrange
            $settings = @{
                webrootOutputPath  = "$TestDrive\www"
                dataOutputPath     = "$TestDrive\data"
                buildConfiguration = "Debug"
            }

            # Act
            $mergedSettings = Merge-ParametersAndUserSettings -Settings $settings -WebrootOutputPath "1" -DataOutputPath "2" -BuildConfiguration "3"

            # Assert
            $mergedSettings.webrootOutputPath | Should Be "1"
            $mergedSettings.dataOutputPath | Should Be "2"
            $mergedSettings.buildConfiguration | Should Be "3"
        }
    }
}
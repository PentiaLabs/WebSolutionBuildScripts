Describe "module member exports" {
    $moduleDefinitionFiles = Get-ChildItem -Path "$PSScriptRoot" -Include "*.psd1" -Recurse

    foreach ($moduleDefinitionFile in $moduleDefinitionFiles) {

        Describe "'$($moduleDefinitionFile.Name)' member export" {

            Function Get-ExportedCommandsFromDefinition {
                Param(
                    [Parameter(Mandatory = $True)]
                    [String]$ModuleDefinitionFile
                )
                $content = (Get-Content $ModuleDefinitionFile | Out-String)
                $moduleFromDefinition = (Invoke-Expression $content)
                $exportedCommandsFromDefinition = $moduleFromDefinition.FunctionsToExport
                $exportedCommandsFromDefinition
            }

            Function Get-ExportedCommandsFromScript {
                Param(
                    [Parameter(Mandatory = $True)]
                    [String]$ModuleDefinitionFile
                )
                $moduleScriptFilePath = "$ModuleDefinitionFile".Replace("psd1", "psm1")      
                $moduleScriptFileContent = Get-Content $moduleScriptFilePath -Raw 

                if ($moduleScriptFileContent -like "*-Alias*") {
                    $exportModuleMemberRegex = [Regex]"(?mi)^Export-ModuleMember -Function (.*) -Alias (.*)$"
                }
                else {
                    $exportModuleMemberRegex = [Regex]"(?mi)^Export-ModuleMember -Function (.*)$"
                }
                
                $exportedCommandsFromScriptMatches = $exportModuleMemberRegex.Matches($moduleScriptFileContent)
                $exportedCommandsFromScript = $exportedCommandsFromScriptMatches[0].Groups[1].Value.Split(",") | ForEach-Object { $_.Trim() }
                $exportedCommandsFromScript
            }

            It "should export the same members from the .psm1 as from the .psd1 file" {
                # Arrange
                $exportedCommandsFromDefinition = Get-ExportedCommandsFromDefinition -ModuleDefinitionFile $moduleDefinitionFile
                $exportedCommandsFromScript = Get-ExportedCommandsFromScript -ModuleDefinitionFile $moduleDefinitionFile

                # Act
                $missingExports = $exportedCommandsFromDefinition | Where-Object { $exportedCommandsFromScript -notcontains $_ }

                # Assert
                $missingExports | Should Be $Null
            }

            It "should export the same members from the .psd1 as from the .psm1 file" {
                # Arrange
                $exportedCommandsFromDefinition = Get-ExportedCommandsFromDefinition -ModuleDefinitionFile $moduleDefinitionFile
                $exportedCommandsFromScript = Get-ExportedCommandsFromScript -ModuleDefinitionFile $moduleDefinitionFile

                # Act            
                $missingExports = $exportedCommandsFromScript | Where-Object { $exportedCommandsFromDefinition -notcontains $_ }

                # Assert
                $missingExports | Should Be $Null
            }
        }

    }
}
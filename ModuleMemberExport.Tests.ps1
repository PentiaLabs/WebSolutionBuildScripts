Describe "module member exports" {
    $moduleDefinitionFiles = Get-ChildItem -Path "$PSScriptRoot" -Include "*.psd1" -Recurse

    foreach ($moduleDefinitionFile in $moduleDefinitionFiles) {

        Describe "'$($moduleDefinitionFile.Name)' member export" {

            function Get-ExportedCommandsFromDefinition {
                param (
                    [Parameter(Mandatory = $true)]
                    [string]$ModuleDefinitionFile
                )
                $content = (Get-Content $ModuleDefinitionFile | Out-String)
                $moduleFromDefinition = (Invoke-Expression $content)
                $exportedCommandsFromDefinition = $moduleFromDefinition.functionsToExport
                $exportedCommandsFromDefinition
            }

            function Get-ExportedCommandsFromScript {
                param (
                    [Parameter(Mandatory = $true)]
                    [string]$ModuleDefinitionFile
                )
                $moduleScriptFilePath = "$ModuleDefinitionFile".Replace("psd1", "psm1")      
                $moduleScriptFileContent = Get-Content $moduleScriptFilePath -Raw 

                if ($moduleScriptFileContent -like "*-Alias*") {
                    $exportModuleMemberRegex = [regex]"(?mi)^Export-ModuleMember -Function (.*) -Alias (.*)$"
                }
                else {
                    $exportModuleMemberRegex = [regex]"(?mi)^Export-ModuleMember -Function (.*)$"
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
                $missingExports | Should Be $null
            }

            It "should export the same members from the .psd1 as from the .psm1 file" {
                # Arrange
                $exportedCommandsFromDefinition = Get-ExportedCommandsFromDefinition -ModuleDefinitionFile $moduleDefinitionFile
                $exportedCommandsFromScript = Get-ExportedCommandsFromScript -ModuleDefinitionFile $moduleDefinitionFile

                # Act            
                $missingExports = $exportedCommandsFromScript | Where-Object { $exportedCommandsFromDefinition -notcontains $_ }

                # Assert
                $missingExports | Should Be $null
            }
        }

    }
}
$scriptsModules = Get-ChildItem "$PSScriptRoot" -Include "*.psm1" -Recurse | Where-Object { $_.FullName -notmatch "TestContent" }

Describe "all scripts and modules conform to PowerShell best pratices" {
    Context "checking analysis prerequisites" {
        It "should have files to test" {
            # Assert
            $scriptsModules.Count | Should BeGreaterThan 0
        }

        It "should have the 'Invoke-ScriptAnalyzer' Cmdlet available" {
            # Arrange
            $invocation = { Get-Command "Invoke-ScriptAnalyzer" -ErrorAction Stop }

            # Assert
            $invocation | Should Not Throw
        }
    }

    $scriptAnalyzerRules = Get-ScriptAnalyzerRule | Where-Object -Property RuleName -NE PSUseSingularNouns
    forEach ($scriptModule in $scriptsModules) {

        Describe "module '$($scriptModule.Name)' ($($scriptModule.FullName))" {
            forEach ($scriptAnalyzerRule in $scriptAnalyzerRules) {
                It "conforms to best practice '$scriptAnalyzerRule'" {
                    # Act
                    $ruleViolations = Invoke-ScriptAnalyzer -Path $scriptModule.FullName -IncludeRule $scriptAnalyzerRule

                    # Assert
                    $ruleViolations | Where-Object RuleName -EQ $scriptAnalyzerRule | Out-Default
                    $ruleViolations.Count | Should Be 0
                }
            }
        }

    }
}

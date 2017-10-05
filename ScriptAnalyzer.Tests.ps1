$scriptsModules = Get-ChildItem "$PSScriptRoot" -Include "*.psm1" -Exclude "*.Tests.ps1" -Recurse

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
        switch -wildCard ($scriptModule) { 
            "*.psm1" { $typeTesting = "module" } 
            "*.ps1" { $typeTesting = "script" } 
        }

        Describe "$typeTesting '$($scriptModule.Name)'" {
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

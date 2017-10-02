$scriptsModules = Get-ChildItem $PSScriptRoot -Include *.psm1 -Exclude *.tests.ps1 -Recurse

Describe "General - Testing all scripts and modules against the Script Analyzer Rules" {
	Context "Checking that files to test exist and the 'Invoke-ScriptAnalyzer' cmdLet is available" {
		It "should have files to test." {
			$scriptsModules.count | Should Not Be 0
		}
		It "should have the 'Invoke-ScriptAnalyzer' cmdLet available." {
			{ Get-Command Invoke-ScriptAnalyzer -ErrorAction Stop } | Should Not Throw
		}
	}

	$scriptAnalyzerRules = Get-ScriptAnalyzerRule | Where-Object -Property RuleName -NE PSUseSingularNouns
	
	forEach ($scriptModule in $scriptsModules) {
		switch -wildCard ($scriptModule) { 
			'*.psm1' { $typeTesting = 'Module' } 
			'*.ps1' { $typeTesting = 'Script' } 
		}

		Context "Checking $typeTesting - $($scriptModule) - conforms to Script Analyzer Rules" {
			forEach ($scriptAnalyzerRule in $scriptAnalyzerRules) {
				It "Script Analyzer Rule $scriptAnalyzerRule" {
					(Invoke-ScriptAnalyzer -Path $scriptModule -IncludeRule $scriptAnalyzerRule).count | Should Be 0
				}
			}
		}

	}

	
}

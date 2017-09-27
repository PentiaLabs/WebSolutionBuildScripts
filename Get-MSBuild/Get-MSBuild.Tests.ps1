# Requires https://github.com/pester/Pester: Install-Module Pester -Force -SkipPublisherCheck
#Requires -Modules Pester
Import-Module "$PSScriptRoot\Get-MSBuild.psm1" -Force

InModuleScope "Get-MSBuild" {
	
	Describe "Get-MSBuild" {
		It "Should throw an exception when MSBuild does not exist" {
			# Arrange
			Mock Invoke-hMSBuildBat { return "C:\notvalid"} -ModuleName Get-MSBuild
	
			# Act
			$invocation = { Get-MSBuild }
	
			# Assert
			$invocation | Should throw "Didn't find MSBuild.exe."
		}
	}
	
	Describe "Get-MSBuild" {
		It "Should return the path to MSBuild.exe" {
			# Act
			$msbuildPath = Get-MSBuild
	
			# Assert
			$msbuildPath | Should Not Be $null
			$msbuildPath | Should BeOfType System.String
			$msbuildPath | Should BeLike "*\MSbuild.exe"
			$msbuildPath | Should Exist
		}
	}
}
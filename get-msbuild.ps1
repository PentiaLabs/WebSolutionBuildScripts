Import-Module VSSetup
Function get-msbuild {
	[CmdletBinding()]
	Param()
	Get-VSSetupInstance | get-childitem -Path { $_.InstallationPath }  -Filter msbuild.exe -Recurse | Select-Object -First 1
}
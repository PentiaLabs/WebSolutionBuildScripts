Import-Module VSSetup

<#
.SYNOPSIS
Gets the latest MSBuild executable installed with Visual Studio 2017 or later.

.EXAMPLE
Get-MSBuild

.NOTES
Requires the "VSSetup" module to be installed.
#>
Function Get-MSBuild {
	$visualStudioInstallationPath = Get-VSSetupInstance | Select-Object $_ -ExpandProperty "InstallationPath"
	Write-Verbose "Searching for MSBuild.exe in '$visualStudioInstallationPath'."
	$msBuildExecutable = Get-ChildItem -Path $visualStudioInstallationPath -Filter "msbuild.exe" -Recurse | Select-Object -First 1
	if($msBuildExecutable -eq $null) {
		Throw "Didn't find MSBuild.exe in '$visualStudioInstallationPath'."
	}
	return $msBuildExecutable
}
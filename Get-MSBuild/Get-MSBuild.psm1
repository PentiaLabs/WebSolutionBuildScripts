<#
.SYNOPSIS
Gets the latest MSBuild executable installed with Visual Studio 2017 or later.

.EXAMPLE
Get-MSBuild

.NOTES
Requires the "VSSetup" module to be installed.
#>
Function Get-MSBuild {
	Write-Verbose "Searching for MSBuild.exe."
	$msBuildExecutable = . "$PSScriptRoot\bin\hMSBuild.bat" "-only-path"
	if($msBuildExecutable -eq $Null -or !(Test-Path $msBuildExecutable)) {
		Throw "Didn't find MSBuild.exe."
	}
	Write-Verbose "Found MSBuild.exe at '$msBuildExecutable'."
	$msBuildExecutable
}

Export-ModuleMember -Function Get-MSBuild

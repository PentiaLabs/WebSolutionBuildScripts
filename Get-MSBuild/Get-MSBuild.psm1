<#
.SYNOPSIS
Gets the latest MSBuild executable installed with Visual Studio 2017 or later.

.EXAMPLE
Get-MSBuild

.NOTES
Requires the "VSSetup" module to be installed.
#>
Function Get-MSBuild {
    [CmdletBinding()]
	[OutputType([string])]
	Param()
	
	Write-Verbose "Searching for MSBuild.exe."
	$msBuildExecutable = Invoke-hMSBuildBat
	if($Null -eq $msBuildExecutable -or !(Test-Path $msBuildExecutable)) {
		Throw "Didn't find MSBuild.exe."
	}
	Write-Verbose "Found MSBuild.exe at '$msBuildExecutable'."
	$msBuildExecutable
}

Function Invoke-hMSBuildBat {
	. "$PSScriptRoot\lib\hMSBuild.bat" "-only-path"
}

Export-ModuleMember -Function Get-MSBuild

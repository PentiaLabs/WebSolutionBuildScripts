<#
.SYNOPSIS
Gets the path to highest version of MSBuild.exe installed on the system.

.EXAMPLE
Get-MSBuild
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

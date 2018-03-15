<#
.SYNOPSIS
Gets the path to highest version of MSBuild.exe installed on the system.

.EXAMPLE
Get-MSBuild
#>
function Get-MSBuild {
    [CmdletBinding()]
	[OutputType([string])]
	param ()
	
	Write-Verbose "Searching for MSBuild.exe."
	$msBuildExecutable = Invoke-hMSBuildBat
	if ($null -eq $msBuildExecutable -or !(Test-Path $msBuildExecutable)) {
		throw "Didn't find MSBuild.exe."
	}
	Write-Verbose "Found MSBuild.exe at '$msBuildExecutable'."
	$msBuildExecutable
}

function Invoke-hMSBuildBat {
	. "$PSScriptRoot\lib\hMSBuild.bat" "-only-path"
}

Export-ModuleMember -Function Get-MSBuild

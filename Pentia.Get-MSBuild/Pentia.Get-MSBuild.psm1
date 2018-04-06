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
    $visualStudioOrBuildToolsPath = VSSetup\Get-VSSetupInstance | Select-Object -ExpandProperty "InstallationPath"
    if ([string]::IsNullOrWhiteSpace($visualStudioOrBuildToolsPath)) {
        $msBuildExecutable = Invoke-hMSBuildBat
    }
    else {
        $msBuildExecutable = Get-ChildItem -Path $visualStudioOrBuildToolsPath -Recurse -Include "MSBuild.exe" -File | Select-Object -First 1
    }
    if ($null -eq $msBuildExecutable -or !(Test-Path $msBuildExecutable)) {
        throw "Didn't find MSBuild.exe."
    }
    Write-Verbose "Found MSBuild.exe at '$msBuildExecutable'."
    "$msBuildExecutable"
}

function Invoke-hMSBuildBat {
    . "$PSScriptRoot\lib\hMSBuild.bat" "-only-path"
}

Export-ModuleMember -Function Get-MSBuild

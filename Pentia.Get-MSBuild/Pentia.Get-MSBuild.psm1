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

    $msBuildExecutable = Invoke-VSWhereExe
    if ([string]::IsNullOrEmpty($msBuildExecutable)) {
        $msBuildExecutable = Invoke-hMSBuildBat
    }
    if ([string]::IsNullOrEmpty($msBuildExecutable) -or !(Test-Path -Path $msBuildExecutable -PathType Leaf)) {
        throw "Didn't find MSBuild.exe."
    }
    $msBuildExecutable
}

function Invoke-VSWhereExe {
    [CmdletBinding()]
    [OutputType([string])]
    param ()

    $vswhereExeFilePath = [IO.Path]::Combine(${env:ProgramFiles(x86)}, "Microsoft Visual Studio", "Installer", "vswhere.exe")
    if (!(Test-Path -Path $vswhereExeFilePath -PathType Leaf)) {
        Write-Verbose "vswhere.exe not found in '$vswhereExeFilePath'. vswhere.exe is installed with VS2017 Update 2 and later versions."
        return $null
    }

    Write-Verbose "Searching for MSBuild.exe using '$vswhereExeFilePath'."
    $vswhereResult = & "$vswhereExeFilePath" "-latest" "-requires" "Microsoft.Component.MSBuild" "-find" "MSBuild\Current\Bin\MSBuild.exe"
    if ($LASTEXITCODE -ne 0) {
        Write-Verbose "Failed to search for MSBuild.exe using '$vswhereExeFilePath'. This is usually due to an outdated vswhere.exe. Error message: $vswhereResult"
        return $null
    }
    if (![string]::IsNullOrEmpty($vswhereResult) -and (Test-Path -Path $vswhereResult -PathType Leaf)) {
        Write-Verbose "Found MSBuild.exe at '$vswhereResult' using '$vswhereExeFilePath'."
        return $vswhereResult
    }
    $null
}

function Invoke-hMSBuildBat {
    [CmdletBinding()]
    [OutputType([string])]
    param ()
    $hMSBuildBatFilePath = [IO.Path]::Combine($PSScriptRoot, "lib", "hMSBuild.bat")
    Write-Verbose "Searching for MSBuild.exe using '$hMSBuildBatFilePath'."
    $hMSBuildResult = & "$hMSBuildBatFilePath" "-only-path"
    if ($LASTEXITCODE -ne 0) {
        Write-Verbose "Failed to search for MSBuild.exe using '$hMSBuildBatFilePath'. Error message: $hMSBuildResult"
        return $null
    }
    if (![string]::IsNullOrEmpty($hMSBuildResult) -and (Test-Path -Path $hMSBuildResult -PathType Leaf)) {
        Write-Verbose "Found MSBuild.exe at '$hMSBuildResult' using '$hMSBuildBatFilePath'."
        return $hMSBuildResult
    }
    $null
}

Export-ModuleMember -Function Get-MSBuild

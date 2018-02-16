<#
.SYNOPSIS
Downloads the latest nuget.exe from the web and saves it to "<current directory>\.pentia\nuget.exe".
#>
Function Install-NuGetExe {
    [CmdletBinding()]
    Param()
    
    If (Test-NuGetInstall) {
        Write-Verbose "nuget.exe is already installed."
        return
    }

    $saveToPath = Get-NuGetPath
    Write-Verbose "Downloading nuget.exe to '$saveToPath'"
    $sourceNugetExe = "https://dist.nuget.org/win-x86-commandline/latest/nuget.exe"
    $directoryPath = Split-Path -Path $saveToPath -Parent
    New-Item -ItemType Directory -Force -Path $directoryPath | Out-Null
    Invoke-WebRequest $sourceNugetExe -OutFile $saveToPath
}

Function Test-NuGetInstall {
    Get-NuGetPath | Test-Path
}

Function Get-NuGetPath {
    $localNuGetExePath = [System.IO.Path]::Combine("$PWD", ".pentia", "nuget.exe")
    $globalNuGetExePath = Get-GlobalNuGetPath
    If ([System.String]::IsNullOrWhiteSpace($globalNuGetExePath)) {
        return $localNuGetExePath
    }
    $globalNuGetExePath
}

Function Get-GlobalNuGetPath {
    $latestGlobalNuGetExePath = Get-Command "nuget.exe" -ErrorAction SilentlyContinue | Sort-Object -Property "Version" -Descending | Select-Object -ExpandProperty "Source" -First 1
    $latestGlobalNuGetExePath
}

<#
.SYNOPSIS
A thin wrapper for "NuGet.exe restore [...]". See https://docs.microsoft.com/en-us/nuget/tools/cli-ref-restore.

.PARAMETER NuGetExePath
Path to NuGet.exe. Defaults to "<current directory>\.pentia\nuget.exe".

.PARAMETER SolutionDirectory
Specifies the solution folder. Not valid when restoring packages for a solution.

.PARAMETER OutputDirectory
Specifies the folder in which packages are installed. If no folder is specified, the current folder is used.

.PARAMETER ConfigFile
The NuGet configuration file to apply. If not specified, %AppData%\NuGet\NuGet.Config is used.

.PARAMETER NoCache
Prevents NuGet from using packages from local machine caches.
#>
Function Restore-NuGetPackage {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $False)]
        [string]$NuGetExePath = (Get-NuGetPath),

        [Parameter(Mandatory = $False)]
        [string]$SolutionDirectory,

        [Parameter(Mandatory = $False)]
        [string]$OutputDirectory,

        [Parameter(Mandatory = $False)]
        [string]$ConfigFile,

        [switch]$NoCache
    )
    $builder = New-Object OptionBuilder
    $builder.Command = "restore"
    $builder.SolutionDirectory = $SolutionDirectory
    $builder.OutputDirectory = $OutputDirectory
    $builder.ConfigFile = $ConfigFile
    $builder.NoCache = $NoCache
    $options = $builder.Build()
    & "$NuGetExePath" $options
    If ($LASTEXITCODE -ne 0) {
        Throw "NuGet command failed."
    }
}

<#
.SYNOPSIS
A thin wrapper for "NuGet.exe install [...]". See https://docs.microsoft.com/en-us/nuget/tools/cli-ref-install.

.PARAMETER NuGetExePath
Path to NuGet.exe. Defaults to "<current directory>\.pentia\nuget.exe".

.PARAMETER PackageId
The package to install. Can't be used with "PackageConfigFile".

.PARAMETER PackageVersion
The package version to install. Defaults to latest version.

.PARAMETER PackageConfigFile
The package.config file specifying which packages to install. Can't be used with "PackageId" and "PackageVersion".

.PARAMETER SolutionDirectory
Specifies the solution folder. Not valid when restoring packages for a solution.

.PARAMETER OutputDirectory
Specifies the folder in which packages are installed. If no folder is specified, the current folder is used.

.PARAMETER ConfigFile
The NuGet configuration file to apply. If not specified, %AppData%\NuGet\NuGet.Config is used.

.PARAMETER NoCache
Prevents NuGet from using packages from local machine caches.
#>
Function Install-NuGetPackage {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $False)]
        [string]$NuGetExePath = (Get-NuGetPath),

        [Parameter(ParameterSetName = "InstallByPackageId", Mandatory = $True)]
        [string]$PackageId,

        [Parameter(ParameterSetName = "InstallByPackageId", Mandatory = $False)]
        [string]$PackageVersion,

        [Parameter(ParameterSetName = "InstallByPackageConfig", Mandatory = $True)]
        [string]$PackageConfigFile,

        [Parameter(Mandatory = $False)]
        [string]$SolutionDirectory,

        [Parameter(Mandatory = $False)]
        [string]$OutputDirectory,

        [Parameter(Mandatory = $False)]
        [string]$ConfigFile,

        [switch]$NoCache
    )
    $builder = New-Object InstallOptionBuilder
    $builder.Command = "install"
    $builder.PackageId = $PackageId
    $builder.PackageVersion = $PackageVersion
    $builder.PackageConfigFile = $PackageConfigFile
    $builder.SolutionDirectory = $SolutionDirectory
    $builder.OutputDirectory = $OutputDirectory
    $builder.ConfigFile = $ConfigFile
    $builder.NoCache = $NoCache
    $options = $builder.Build()
    & "$NuGetExePath" $options
    If ($LASTEXITCODE -ne 0) {
        Throw "NuGet command failed."
    }
}

Class OptionBuilder {
    [string]$Command
    [string]$SolutionDirectory
    [string]$OutputDirectory
    [string]$ConfigFile
    [bool]$NoCache
    Hidden [System.Collections.ArrayList]$Options

    OptionBuilder () {
        $this.Options = @()
    }

    [System.Collections.ArrayList] Build() {
        $this.AddParameter($this.Command)
        $this.AddParameter("-SolutionDirectory", $this.SolutionDirectory)
        $this.AddParameter("-OutputDirectory", $this.OutputDirectory)
        $this.AddParameter("-ConfigFile", $this.ConfigFile)
        If ($this.NoCache) {
            $this.AddParameter("-NoCache")
        }
        return $this.Options
    }

    Hidden [void] AddParameter([string]$ParameterName) {
        $this.Options.Add($ParameterName)
    }

    Hidden [void] AddParameter([string]$ParameterName, [string]$ParameterValue) {
        If (-not [System.String]::IsNullOrWhiteSpace($ParameterValue)) {
            $this.Options.Add($ParameterName)
            $this.Options.Add($ParameterValue)
        }
    }
}

Class InstallOptionBuilder : OptionBuilder {
    [string]$PackageId
    [string]$PackageVersion
    [string]$PackageConfigFile

    [System.Collections.ArrayList] Build() {
        ([OptionBuilder]$this).Build()
        $this.InsertParameter(1, $this.PackageId)
        $this.AddParameter("-Version", $this.PackageVersion)
        $this.InsertParameter(1, $this.PackageConfigFile)
        return $this.Options
    }

    Hidden [void] InsertParameter([int]$Index, [string]$ParameterValue) {
        If (-not [System.String]::IsNullOrWhiteSpace($ParameterValue)) {
            $this.Options.Insert($Index, $ParameterValue)
        }
    }
}

Export-ModuleMember -Function Install-NuGetExe, Restore-NuGetPackage, Install-NuGetPackage

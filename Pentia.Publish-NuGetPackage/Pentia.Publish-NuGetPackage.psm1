<#
.SYNOPSIS
Downloads the latest nuget.exe from the web and saves it to "<current directory>\.pentia\nuget.exe".
#>
function Install-NuGetExe {
    [CmdletBinding()]
    param ()

    if (Test-NuGetInstall) {
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

function Test-NuGetInstall {
    Get-NuGetPath | Test-Path
}

function Get-NuGetPath {
    $localNuGetExePath = [System.IO.Path]::Combine("$PWD", ".pentia", "nuget.exe")
    $globalNuGetExePath = Get-GlobalNuGetPath
    if ([string]::IsNullOrWhiteSpace($globalNuGetExePath)) {
        return $localNuGetExePath
    }
    $globalNuGetExePath
}

function Get-GlobalNuGetPath {
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
function Restore-NuGetPackage {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$NuGetExePath = (Get-NuGetPath),

        [Parameter(Mandatory = $false)]
        [string]$SolutionDirectory,

        [Parameter(Mandatory = $false)]
        [string]$OutputDirectory,

        [Parameter(Mandatory = $false)]
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
    if ($LASTEXITCODE -ne 0) {
        throw "NuGet command failed."
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
function Install-NuGetPackage {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$NuGetExePath = (Get-NuGetPath),

        [Parameter(ParameterSetName = "InstallByPackageId", Mandatory = $true)]
        [string]$PackageId,

        [Parameter(ParameterSetName = "InstallByPackageId", Mandatory = $false)]
        [string]$PackageVersion,

        [Parameter(ParameterSetName = "InstallByPackageConfig", Mandatory = $true)]
        [string]$PackageConfigFile,

        [Parameter(Mandatory = $false)]
        [string]$SolutionDirectory,

        [Parameter(Mandatory = $false)]
        [string]$OutputDirectory,

        [Parameter(Mandatory = $false)]
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
    if ($LASTEXITCODE -ne 0) {
        throw "NuGet command failed."
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
        if ($this.NoCache) {
            $this.AddParameter("-NoCache")
        }
        return $this.Options
    }

    Hidden [void] AddParameter([string]$ParameterName) {
        $this.Options.Add($ParameterName)
    }

    Hidden [void] AddParameter([string]$ParameterName, [string]$ParameterValue) {
        if (-not [string]::IsNullOrWhiteSpace($ParameterValue)) {
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
        if (-not [string]::IsNullOrWhiteSpace($ParameterValue)) {
            $this.Options.Insert($Index, $ParameterValue)
        }
    }
}

<#
.SYNOPSIS
Publishes the contents of a runtime dependency package to a website, using NuGet.

.DESCRIPTION
Publishes the contents of a runtime dependency package to a website, using NuGet.

Packages are expected to be NuGet-packages and contain any of the following folders:

- <package>/Webroot
- <package>/Data

All of the above are optional.

The following steps are performed during package publishing:

1. Check if the required package is cached locally.
1.1 If the package isn't found locally, it's installed from a registered package source, or from the $PackageSource parameter.
2. Copy the contents of the "<package>\Webroot"-folder to the "<WebrootOutputPath>".
3. Copy the contents of the "<package>\Data"-folder to the "<DataOutputPath>".

.PARAMETER PackageName
The name of the package to publish.

.PARAMETER PackageVersion
The exact version of the package to publish.

.PARAMETER PackageOutputPath
The location of the installed NuGet packages (e.g. "<solution root>/.pentia/runtime-dependencies/").

.PARAMETER WebrootOutputPath
The path where the contents of "<package>\Webroot" will be copied to.

.PARAMETER DataOutputPath
The path where the contents of "<package>\Data" will be copied to.
#>
function Publish-NuGetPackage {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$PackageName,

        [Parameter(Mandatory = $true)]
        [string]$PackageVersion,

        [Parameter(Mandatory = $true)]
        [string]$PackageOutputPath,

        [Parameter(Mandatory = $true)]
        [string]$WebrootOutputPath,

        [Parameter(Mandatory = $true)]
        [string]$DataOutputPath
    )
    $packagePath = [System.IO.Path]::Combine($PackageOutputPath, "$PackageName.$PackageVersion")
    $packageWebrootPath = [System.IO.Path]::Combine($PackagePath, "webroot")
    Copy-PackageFolder -SourceFriendlyName "webroot" -Source $packageWebrootPath -Target $WebrootOutputPath
    $packageDataPath = [System.IO.Path]::Combine($PackagePath, "data")
    Copy-PackageFolder -SourceFriendlyName "data" -Source $packageDataPath -Target $DataOutputPath
}

function Copy-PackageFolder {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$SourceFriendlyName,

        [Parameter(Mandatory = $true)]
        [string]$Source,

        [Parameter(Mandatory = $true)]
        [string]$Target
    )

    Write-Verbose "Checking if package has a $SourceFriendlyName folder '$Source'."
    if (Test-Path -Path $Source -PathType Container) {
        Write-Verbose "Copying $SourceFriendlyName files from '$Source' to '$Target'."
        robocopy "$Source" "$Target" *.* /E /MT 64 /NFL /NP /NDL /NJH | Write-Verbose
    }
    else {
        Write-Verbose "No $SourceFriendlyName folder found."
    }
}

Export-ModuleMember -Function Install-NuGetExe, Restore-NuGetPackage, Install-NuGetPackage, Publish-NuGetPackage

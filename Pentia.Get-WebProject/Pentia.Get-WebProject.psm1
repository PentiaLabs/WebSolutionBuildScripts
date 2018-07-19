<#
.SYNOPSIS
Gets the paths to web project files in the subdirectories of the solution root path.

.PARAMETER SolutionRootPath
The absolute or relative solution root path.

.PARAMETER ExcludeFilter
Specifies which folders do exclude in the search. Defaults to "node_modules", "bower_components", "obj" and "bin".

.EXAMPLE
Get-WebProject -SolutionRootPath "C:\Path\To\MySolution"
Get all web projects in "C:\Path\To\MySolution" and it's subfolders.

#>
function Get-WebProject {
    [CmdletBinding()]
    [OutputType([object[]])]
    param (
        [Parameter(Mandatory = $false)]
        [string]$SolutionRootPath,

        [Parameter(Mandatory = $false)]
        [string[]]$ExcludeFilter = @("node_modules", "bower_components", "obj", "bin")
    )

    if ([string]::IsNullOrEmpty($SolutionRootPath)) {
        Write-Verbose "`$SolutionRootPath is null or empty. Using current working directory '$PWD'."
        $SolutionRootPath = $PWD;
    }

    Write-Verbose "Searching for web projects in '$SolutionRootPath', excluding '$ExcludeFilter'."
    $projects = Find-Project -SolutionRootPath $SolutionRootPath -ExcludeFilter $ExcludeFilter | Where-Object { Test-WebProject $_ }
    if ($projects -is [object[]]) {
        return $projects
    }
    if ($projects -is [object]) {
        return @($projects)
    }
    return , @()
}

function Find-Project {
    [CmdletBinding()]
    [OutputType([string[]])]
    param (
        [Parameter(Mandatory = $true)]
        [string]$SolutionRootPath,

        [Parameter(Mandatory = $true)]
        [string[]]$ExcludeFilter
    )
    $projectFilePaths = Get-ChildItem -Recurse -Path "$SolutionRootPath" -Include "*.csproj"
    $includedProjects = $projectFilePaths | Where-Object {
        $pathParts = $_.FullName.Split([System.IO.Path]::DirectorySeparatorChar, [System.StringSplitOptions]::RemoveEmptyEntries)
        $matchedFilters = $ExcludeFilter | Where-Object { $pathParts -contains $_ }
        $matchedFilters.Count -lt 1
    }
    $includedProjects
}

function Test-WebProject {
    [CmdletBinding()]
    [OutputType([bool])]
    param (
        [Parameter(Mandatory = $true)]
        [string]$ProjectFilePath
    )

    if (!(Test-Path $ProjectFilePath -PathType Leaf)) {
        throw "File '$ProjectFilePath' not found."
    }
    # Retrieved from https://www.mztools.com/articles/2008/MZ2008017.aspx
    $webApplicationProjectTypeGuid = "{349C5851-65DF-11DA-9384-00065B846F21}"
    $projectFileContent = Get-Content $ProjectFilePath | Out-String
    $projectFileContent.ToLowerInvariant().Contains($webApplicationProjectTypeGuid.ToLowerInvariant())
}

Export-ModuleMember -Function Get-WebProject

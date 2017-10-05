<#
.SYNOPSIS
Gets the paths to web project files in the subdirectories of the solution root path, and allows filtering based on Helix solution layer.

.PARAMETER SolutionRootPath
The absolute or relative solution root path.

.PARAMETER HelixLayer
The Helix layer in which to search for web projects. Defaults to $Null, which includes all layers.

.PARAMETER IncludeFilter
Specifies which files do include in the search. Defaults to "*.csproj".

.PARAMETER ExcludeFilter
Specifies which files do exclude in the search. Defaults to "node_modules", "bower_components".

.EXAMPLE
Get-SitecoreHelixProject -SolutionRootPath "C:\Path\To\MySolution" -HelixLayer Foundation
Get all web projects in the "Foundation" layer.

#>
Function Get-SitecoreHelixProject {
    [CmdletBinding()]
    Param (
        [Parameter(Position = 0, Mandatory = $False)]
        [string]$SolutionRootPath,
		
        [Parameter(Position = 1, Mandatory = $False)]
        [ValidateSet('Project', 'Feature', 'Foundation')]
        [string]$HelixLayer = $Null,
		
        [Parameter(Position = 2, Mandatory = $False)]
        [string[]]$IncludeFilter = @("*.csproj"),
		
        [Parameter(Position = 3, Mandatory = $False)]
        [string[]]$ExcludeFilter = @("node_modules", "bower_components", "obj", "bin")
    )
	
    if ([string]::IsNullOrEmpty($SolutionRootPath)) {
        Write-Verbose "`$SolutionRootPath is null or empty. Using current working directory '$PWD'."
        $SolutionRootPath = $PWD;
    }
	
    if ([string]::IsNullOrEmpty($HelixLayer)) {
        Write-Verbose "Searching for projects matching '$IncludeFilter' in all layers ('$SolutionRootPath'), excluding '$ExcludeFilter'."
    }
    else {
        $SolutionRootPath = [System.IO.Path]::Combine($SolutionRootPath, "src", $HelixLayer)
        Write-Verbose "Searching for projects matching '$IncludeFilter' in layer '$HelixLayer' ('$SolutionRootPath'), excluding '$ExcludeFilter'."
    }

    $projectFilePaths = Get-ChildItem -Path "$SolutionRootPath" -Directory -Recurse | Where-Object { -not ($ExcludeFilter -contains $_.Name) } | Get-ChildItem -Include $IncludeFilter -File | Select-Object -ExpandProperty "FullName"
    $projectFilePaths | Where-Object { Test-WebProject $_ }
}

Function Test-WebProject {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $True)]
        [string]$ProjectFilePath
    )

    If (!(Test-Path $ProjectFilePath -PathType Leaf)) {
        Throw "File '$ProjectFilePath' not found."
    }
    # Retrieved from https://www.mztools.com/articles/2008/MZ2008017.aspx
    $webApplicationProjectTypeGuid = "{349C5851-65DF-11DA-9384-00065B846F21}"
    $projectFileContent = Get-Content $ProjectFilePath | Out-String
    $projectFileContent.ToLowerInvariant().Contains($webApplicationProjectTypeGuid.ToLowerInvariant())
}

Export-ModuleMember -Function Get-SitecoreHelixProject

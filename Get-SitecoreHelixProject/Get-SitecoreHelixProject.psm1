<#
.SYNOPSIS
Gets the paths to web project files in the subdirectories of the solution root path, and allows filtering based on Helix solution layer.

.PARAMETER SolutionRootPath
The absolute or relative solution root path.

.PARAMETER HelixLayer
The Helix layer in which to search for web projects. Defaults to $Null, which includes all layers.

.PARAMETER ExcludeFilter
Specifies which folders do exclude in the search. Defaults to "node_modules", "bower_components", "obj" and "bin".

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
        [string[]]$ExcludeFilter = @("node_modules", "bower_components", "obj", "bin")
    )
	
    if ([string]::IsNullOrEmpty($SolutionRootPath)) {
        Write-Verbose "`$SolutionRootPath is null or empty. Using current working directory '$PWD'."
        $SolutionRootPath = $PWD;
    }
	
    if ([string]::IsNullOrEmpty($HelixLayer)) {
        Write-Verbose "Searching for projects in all layers ('$SolutionRootPath'), excluding '$ExcludeFilter'."
    }
    else {
        $SolutionRootPath = [System.IO.Path]::Combine($SolutionRootPath, "src", $HelixLayer)
        Write-Verbose "Searching for projects in layer '$HelixLayer' ('$SolutionRootPath'), excluding '$ExcludeFilter'."
    }

    Find-Project -SolutionRootPath $SolutionRootPath -ExcludeFilter $ExcludeFilter | Where-Object { Test-WebProject $_ }
}

Function Find-Project {
    [CmdletBinding()]
    [OutputType([System.String[]])]
    Param (
        [Parameter(Mandatory = $True)]
        [string]$SolutionRootPath,
		
        [Parameter(Mandatory = $True)]
        [string[]]$ExcludeFilter
    )
    Push-Location $SolutionRootPath
    # Note that we can't check the $LASTEXITCODE because it's != 0 both when 
    # an error occurs and when no files are found (which we don't consider an error).
    $projectFilePaths = (cmd.exe /c "dir /b /s *.csproj" | Out-String).Split([System.Environment]::NewLine, [System.StringSplitOptions]::RemoveEmptyEntries)
    Pop-Location
    $includedProjects = $projectFilePaths | Where-Object { 
        $pathParts = $_.Split([System.IO.Path]::DirectorySeparatorChar, [System.StringSplitOptions]::RemoveEmptyEntries)
        $matchedFilters = $ExcludeFilter | Where-Object { $pathParts -contains $_ }
        $matchedFilters.Count -lt 1
    }
    $includedProjects
}

Function Test-WebProject {
    [CmdletBinding()]
    [OutputType([System.Boolean])]
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

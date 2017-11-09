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
Function Get-WebProject {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $False)]
        [string]$SolutionRootPath,
		
        [Parameter(Mandatory = $False)]
        [string[]]$ExcludeFilter = @("node_modules", "bower_components", "obj", "bin")
    )
	
    if ([string]::IsNullOrEmpty($SolutionRootPath)) {
        Write-Verbose "`$SolutionRootPath is null or empty. Using current working directory '$PWD'."
        $SolutionRootPath = $PWD;
    }
	
    Write-Verbose "Searching for web projects in '$SolutionRootPath', excluding '$ExcludeFilter'."
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

Export-ModuleMember -Function Get-WebProject

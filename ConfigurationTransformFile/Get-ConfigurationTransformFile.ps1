. "$PSScriptRoot\Test-ConfigurationTransformFile.ps1"

<#
.SYNOPSIS
Gets all .config-files in the specified directory.

.DESCRIPTION
Gets all .config-files in the specified directory, exluding files found in "obj" and "bin".

.PARAMETER SolutionRootPath
The absolute or relative solution root path to search through.

.EXAMPLE
Get-ConfigurationTransformFile -SolutionRootPath "C:\Path\To\MySolution"
Returns all .config-files found in the "C:\Path\To\MySolution", recursively.
#>
Function Get-ConfigurationTransformFile {
	[CmdletBinding()]
	Param (
		[Parameter(Position = 0, Mandatory = $True)]
		[string]$SolutionRootPath,
		[Parameter(Position = 1, Mandatory = $False)]
		[string]$BuildConfiguration
	)
	
	if($(Test-Path $SolutionRootPath) -eq $False)
	{
		Throw "Path '$SolutionRootPath' not found."
	}

	$ConfigurationFiles = Get-ChildItem "*.config" -Path "$SolutionRootPath" -Recurse -File 
	$ConfigurationFilesNotInBinAndObj = $ConfigurationFiles | Where-Object { $_.FullName -NotLike "*\obj*" -and $_.FullName -notlike "*\bin*" }
	$ConfigurationTransformFiles = $ConfigurationFilesNotInBinAndObj | Where-Object { $(Test-ConfigurationTransformFile -AbsoluteFilePath $_.FullName 	)}

    if ([string]::IsNullOrEmpty($BuildConfiguration) -eq $False) {
		$ConfigurationTransformFiles = $ConfigurationTransformFiles | Where-Object { $_.Name.Split(".")[-2].ToLower() -eq $BuildConfiguration.ToLower() }
    }

	$ConfigurationTransformFiles | Select-Object -ExpandProperty FullName
}


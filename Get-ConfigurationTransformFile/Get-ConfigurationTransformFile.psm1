<#
.SYNOPSIS
Gets all XDT-files in the subdirectories of the specified directory.

.DESCRIPTION
Gets all XDT-files in the specified directory, exluding files in system folders like "bin" and "node_modules".

.PARAMETER SolutionRootPath
The absolute or relative solution root path to search through.

.PARAMETER BuildConfigurations
Specifies which build configuration's files will be retrieved. E.g. "Debug" will return files like "Settings.Debug.config".

.PARAMETER ExcludeFilter
Specifies which folders do exclude in the search. Defaults to "node_modules", "bower_components", "obj" and "bin".

.EXAMPLE
Get-ConfigurationTransformFile -SolutionRootPath "C:\Path\To\MySolution" -BuildConfigurations "Debug"
Returns all XDT-files found in the "C:\Path\To\MySolution", recursively, for the "Debug" configuration.
#>
function Get-ConfigurationTransformFile {
    [CmdletBinding()]
    [OutputType([System.String[]])]
    param (
        [Parameter(Mandatory = $true)]
        [string]$SolutionRootPath,

        [Parameter(Mandatory = $false)]
        [string[]]$BuildConfigurations,
		
        [Parameter(Mandatory = $false)]
        [string[]]$ExcludeFilter = @("node_modules", "bower_components", "obj", "bin")
    )
	
    if (-not (Test-Path $SolutionRootPath)) {
        throw "Path '$SolutionRootPath' not found."
    }

    $configurationFiles = Find-ConfigurationFile -SolutionRootPath $SolutionRootPath -ExcludeFilter $ExcludeFilter
    $configurationFiles | Where-Object { 
        Test-BuildConfiguration -BuildConfigurations $BuildConfigurations -FileName $_.Name } | Where-Object { 
        Test-ConfigurationTransformFile -AbsoluteFilePath $_.FullName } | Select-Object -ExpandProperty "FullName"
}

function Find-ConfigurationFile {
    [CmdletBinding()]
    [OutputType([System.String[]])]
    param (
        [Parameter(Mandatory = $true)]
        [string]$SolutionRootPath,
		
        [Parameter(Mandatory = $true)]
        [string[]]$ExcludeFilter
    )
    $configurationFilePaths = Get-ChildItem -Recurse -Path $SolutionRootPath -Include "*.config"
    $includedConfigurations = $configurationFilePaths | Where-Object { 
        $pathParts = $_.FullName.Split([System.IO.Path]::DirectorySeparatorChar, [System.StringSplitOptions]::RemoveEmptyEntries)
        $matchedFilters = $ExcludeFilter | Where-Object { $pathParts -contains $_ }
        $matchedFilters.Count -lt 1
    }
    $includedConfigurations | Get-Item
}

function Test-BuildConfiguration {
    [CmdletBinding()]
    [OutputType([bool])]
    param (
        [Parameter(Mandatory = $false)]
        [string[]]$BuildConfigurations,
        [Parameter(Mandatory = $true)]
        [string]$FileName
    )
    if ($BuildConfigurations.Count -lt 1) {
        return $true
    }
    # "Solr.Default.Index.Debug.config" -> "Debug"
    $buildConfigurationExtension = $FileName.Split(".")[-2]
    $BuildConfigurations -contains $buildConfigurationExtension
}

<#
.SYNOPSIS
Check whether or not a given XML file is a configuration transform file, based on the value of the XDT-attribute.

.PARAMETER AbsoluteFilePath
The absolute path to the configuration file to check.

.EXAMPLE
Test-ConfigurationTransformFile -AbsoluteFilePath "C:\Path\To\MyConfiguration.Prod.config"
#>
function Test-ConfigurationTransformFile {
    [CmdletBinding()]
    [OutputType([bool])]
    param (
        [Parameter(Position = 0)]
        [string]$AbsoluteFilePath
    )
    if ([string]::IsNullOrWhiteSpace($AbsoluteFilePath)) {
        return $false
    }
    if (-not (Test-Path $AbsoluteFilePath)) {
        return $false
    }
    try {
        $xmlDocument = New-Object System.Xml.XmlDocument
        $xmlDocument.Load($AbsoluteFilePath)
        $xmlDocument.DocumentElement.xdt -eq "http://schemas.microsoft.com/XML-Document-Transform"        
    }
    catch {
        $message = "Error reading XML file '$AbsoluteFilePath': $($_.Exception.Message)"
        $innerException = $_.Exception
        $exception = New-Object "System.InvalidOperationException" -ArgumentList $message, $innerException
        throw $exception
    }
}

Export-ModuleMember -Function Get-ConfigurationTransformFile
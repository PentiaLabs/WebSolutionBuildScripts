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
Function Get-ConfigurationTransformFile {
    [CmdletBinding()]
    [OutputType([System.String[]])]
    Param (
        [Parameter(Mandatory = $True)]
        [string]$SolutionRootPath,

        [Parameter(Mandatory = $False)]
        [string[]]$BuildConfigurations,
		
        [Parameter(Mandatory = $False)]
        [string[]]$ExcludeFilter = @("node_modules", "bower_components", "obj", "bin")
    )
	
    If (-not (Test-Path $SolutionRootPath)) {
        Throw "Path '$SolutionRootPath' not found."
    }

    $configurationFiles = Find-ConfigurationFile -SolutionRootPath $SolutionRootPath -ExcludeFilter $ExcludeFilter
    $configurationFiles | Where-Object { 
        Test-BuildConfiguration -BuildConfigurations $BuildConfigurations -FileName $_.Name } | Where-Object { 
        Test-ConfigurationTransformFile -AbsoluteFilePath $_.FullName } | Select-Object -ExpandProperty "FullName"
}

Function Find-ConfigurationFile {
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
    $configurationFilePaths = (cmd.exe /c "dir /b /s *.config" | Out-String).Split([System.Environment]::NewLine, [System.StringSplitOptions]::RemoveEmptyEntries)
    Pop-Location
    $includedConfigurations = $configurationFilePaths | Where-Object { 
        $pathParts = $_.Split([System.IO.Path]::DirectorySeparatorChar, [System.StringSplitOptions]::RemoveEmptyEntries)
        $matchedFilters = $ExcludeFilter | Where-Object { $pathParts -contains $_ }
        $matchedFilters.Count -lt 1
    }
    $includedConfigurations | Get-Item
}

Function Test-BuildConfiguration {
    [CmdletBinding()]
    [OutputType([bool])]
    Param (
        [Parameter(Mandatory = $False)]
        [string[]]$BuildConfigurations,
        [Parameter(Mandatory = $True)]
        [string]$FileName
    )
    If ($BuildConfigurations.Count -lt 1) {
        return $True
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
Function Test-ConfigurationTransformFile {
    [CmdletBinding()]
    [OutputType([bool])]
    Param (
        [Parameter(Position = 0)]
        [string]$AbsoluteFilePath
    )
    If ([System.String]::IsNullOrWhiteSpace($AbsoluteFilePath)) {
        return $False
    }
    If (-not (Test-Path $AbsoluteFilePath)) {
        return $False
    }
    Try {
        $xmlDocument = New-Object System.Xml.XmlDocument
        $xmlDocument.Load($AbsoluteFilePath)
        $xmlDocument.DocumentElement.xdt -eq "http://schemas.microsoft.com/XML-Document-Transform"        
    }
    Catch {
        $message = "Error reading XML file '$AbsoluteFilePath': $($_.Exception.Message)"
        $innerException = $_.Exception
        $exception = New-Object "System.InvalidOperationException" -ArgumentList $message, $innerException
        Throw $exception
    }
}

Export-ModuleMember -Function Get-ConfigurationTransformFile
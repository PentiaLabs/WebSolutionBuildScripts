<#
.SYNOPSIS
Gets all XDT-files in the subdirectories of the specified directory.

.DESCRIPTION
Gets all XDT-files in the specified directory, exluding files found in "obj" and "bin".

.PARAMETER SolutionRootPath
The absolute or relative solution root path to search through.

.EXAMPLE
Get-ConfigurationTransformFile -SolutionRootPath "C:\Path\To\MySolution"
Returns all XDT-files found in the "C:\Path\To\MySolution", recursively.
#>
Function Get-ConfigurationTransformFile {
    [CmdletBinding()]
    [OutputType([System.String[]])]
    Param (
        [Parameter(Position = 0, Mandatory = $True)]
        [string]$SolutionRootPath,

        [Parameter(Position = 1, Mandatory = $False)]
        [string[]]$BuildConfigurations,
		
        [Parameter(Position = 2, Mandatory = $False)]
        [string[]]$IncludeFilter = @("*.config"),
		
        [Parameter(Position = 3, Mandatory = $False)]
        [string[]]$ExcludeFilter = @("node_modules", "bower_components", "obj", "bin")
    )
	
    If (-not (Test-Path $SolutionRootPath)) {
        Throw "Path '$SolutionRootPath' not found."
    }

    $configurationFiles = Get-ChildItem -Path $SolutionRootPath -Directory -Recurse | Where-Object { -not ($ExcludeFilter -contains $_.Name) } | Get-ChildItem -Include $IncludeFilter -File
    $configurationFiles | Where-Object { Test-BuildConfiguration -BuildConfigurations $BuildConfigurations -FileName $_.Name } | Where-Object { Test-ConfigurationTransformFile -AbsoluteFilePath $_.FullName } | Select-Object -ExpandProperty "FullName"
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
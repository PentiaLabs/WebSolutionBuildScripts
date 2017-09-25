<#
.SYNOPSIS
Gets all XDT-files in the specified directory.

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
    Param (
        [Parameter(Position = 0, Mandatory = $True)]
        [string]$SolutionRootPath,
        [Parameter(Position = 1, Mandatory = $False)]
        [string[]]$BuildConfigurations
    )
	
    If ($(Test-Path $SolutionRootPath) -eq $False) {
        Throw "Path '$SolutionRootPath' not found."
    }

    $ConfigurationFiles = Get-ChildItem "*.config" -Path "$SolutionRootPath" -Recurse -File 
    $ConfigurationFilesNotInBinAndObj = $ConfigurationFiles | Where-Object { $_.FullName -NotLike "*\obj*" -and $_.FullName -notlike "*\bin*" }
    $ConfigurationTransformFiles = $ConfigurationFilesNotInBinAndObj | Where-Object { Test-ConfigurationTransformFile -AbsoluteFilePath $_.FullName }

    If ($BuildConfigurations.Count -gt 0) {
        $ConfigurationTransformFiles = $ConfigurationTransformFiles | Where-Object { 
            # "Web.Debug.config" -> "Debug"
            $buildConfigurationExtension = $_.Name.Split(".")[-2]
            $BuildConfigurations -contains $buildConfigurationExtension
        }
    }

    $ConfigurationTransformFiles | Select-Object -ExpandProperty "FullName"
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
    Param (
        [Parameter(Position = 0)]
        [string]$AbsoluteFilePath
    )

    Try {
        $xmlDocument = New-Object System.Xml.XmlDocument
        $xmlDocument.Load($AbsoluteFilePath)
        $xmlDocument.DocumentElement.xdt -eq "http://schemas.microsoft.com/XML-Document-Transform"        
    }
    Catch {
        Write-Error -Message "Error reading XML file '$AbsoluteFilePath': $($_.Exception.Message)" -Exception $_.Exception
    }
}

Export-ModuleMember -Function Get-ConfigurationTransformFile
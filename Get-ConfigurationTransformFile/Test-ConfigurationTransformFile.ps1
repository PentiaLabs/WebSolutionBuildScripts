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
    Param (
        [Parameter(Position = 0)]
        [string]$AbsoluteFilePath
    )

    $xmlDocument = New-Object System.Xml.XmlDocument
    $xmlDocument.Load($AbsoluteFilePath)
    $xmlDocument.DocumentElement.xdt -eq "http://schemas.microsoft.com/XML-Document-Transform"
}
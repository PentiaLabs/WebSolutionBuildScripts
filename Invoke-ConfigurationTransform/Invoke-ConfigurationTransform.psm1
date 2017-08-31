<#
.SYNOPSIS
Determines the location of a configuration file in a target directory based on the location of a XDT file in a source directory, relative to the "App_Config" directory.

.DESCRIPTION
The location of the "configuration base file" is determined based on the location of the transform file relative to the "App_Config" directory.

E.g.:
Given the following project folder structure:
    
    "C:\MySolution\src\Foundation\MyProject\App_Config\MyConfig.Debug.config"

... and given the webroot "C:\MyWebsite\www"
... the XDT file "MyConfig.Debug.config" would match the following configuration file:

    "C:\MyWebsite\www\App_Config\MyConfig.config"

.PARAMETER ConfigurationTransformFilePath
E.g. "C:\MySite\App_Config\Sitecore\Include\Web.Debug.config".

.PARAMETER WebrootDirectory
E.g. "D:\websites\AAB.Intranet\www".
#>
Function Get-PathOfFileToTransform {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $True)]
        [string]$ConfigurationTransformFilePath,
        [Parameter(Mandatory = $True)]
        [string]$WebrootDirectory
    )
    $relativeConfigurationDirectory = Get-RelativeConfigurationDirectory $ConfigurationTransformFilePath
    $nameOfFileToTransform = Get-NameOfFileToTransform $ConfigurationTransformFilePath
    $pathOfFileToTransform = [System.IO.Path]::Combine($WebrootDirectory, $relativeConfigurationDirectory, $nameOfFileToTransform)
    $pathOfFileToTransform
}

Function Get-RelativeConfigurationDirectory {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $True)]
        [string]$ConfigurationTransformFilePath
    )
    # "C:\MySite\App_Config\Sitecore\Include\Pentia\Sites.Debug.Config" -> "C:\MySite\App_Config\Sitecore\Include\Pentia"
    $directoryName = [System.IO.Path]::GetDirectoryName($ConfigurationTransformFilePath)
    $configurationDirectoryName = "App_Config"
    $configurationDirectoryIndex = $DirectoryName.IndexOf($configurationDirectoryName, [System.StringComparison]::InvariantCultureIgnoreCase)
    If ($configurationDirectoryIndex -lt 0) {
        Throw "Can't determine relative configuration directory. '$configurationDirectoryName' not found in path '$ConfigurationTransformFilePath'."
    }
    # "C:\MySite\App_Config\Sitecore\Include\Pentia" -> "App_Config\Sitecore\Include\Pentia"
    $directoryName.Substring($configurationDirectoryIndex)
}

Function Get-NameOfFileToTransform {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $True)]
        [string]$ConfigurationTransformFilePath
    )
    # "C:\MySite\App_Config\Sitecore\Include\Web.Debug.Config" -> "Web.Debug.Config"
    $fileName = [System.IO.Path]::GetFileName($ConfigurationTransformFilePath)
    $fileNamePartSeparator = "."
    # ["Web", "Debug", "config"]
    [System.Collections.ArrayList]$fileNameParts = $fileName.Split($fileNamePartSeparator)
    $buildConfigurationIndex = $fileNameParts.Count - 2
    If ($buildConfigurationIndex -lt 1) {
        Throw "Can't determine file to transform based on file name '$fileName'. The file name must follow the convention 'my.file.name.<BuildConfiguration>.config', e.g. 'Solr.Index.Debug.config'."
    }
    # ["Web", "Debug", "config"] -> ["Web", "config"]
    $fileNameParts.RemoveAt($buildConfigurationIndex)
    # ["Web", "config"] -> "Web.config"
    [string]::Join($fileNamePartSeparator, $fileNameParts.ToArray())
}

Function Invoke-ConfigurationTransform {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $True)]
        [string]$XmlFilePath,        
        [Parameter(Mandatory = $True)]
        [string]$XdtFilePath
    )
    If (!(Test-Path -Path $XmlFilePath -PathType Leaf)) {
        Throw "File '$XmlFilePath' not found."
    }
    If (!(Test-Path -Path $XdtFilePath -PathType Leaf)) {
        Throw "File '$XdtFilePath' not found."
    }

    Add-Type -LiteralPath "$PSScriptRoot\Microsoft.Web.XmlTransform.dll"

    $xmlDocument = New-Object Microsoft.Web.XmlTransform.XmlTransformableDocument
    $xmlDocument.PreserveWhitespace = $True
    $xmlDocument.Load($XmlFilePath)

    $transformation = New-Object Microsoft.Web.XmlTransform.XmlTransformation($XdtFilePath)
    If ($transformation.Apply($xmlDocument) -eq $False) {
        Throw "Transformation of document '$XmlFilePath' failed using transform file '$XdtFilePath'."
    }
    $stringWriter = New-Object -TypeName "System.IO.StringWriter"
    $xmlTextWriter = [System.Xml.XmlWriter]::Create($stringWriter)
    $xmlDocument.WriteTo($xmlTextWriter)
    $xmlTextWriter.Flush()
    $transformedXml = $stringWriter.GetStringBuilder().ToString()
    $xmlTextWriter.Dispose()
    $stringWriter.Dispose()
    
    $transformedXml.Trim()
}

Export-ModuleMember -Function Get-PathOfFileToTransform, Invoke-ConfigurationTransform

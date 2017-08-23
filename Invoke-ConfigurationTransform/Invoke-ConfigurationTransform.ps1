<#
.SYNOPSIS
Creates a "transformed" configuration file using a "configuration base file" and an transform file (XDT).

.DESCRIPTION
Creates a "transformed" configuration file using a "configuration base file" and an transform file (XDT).

The location of the "configuration base file" is determined based on the location of the transform file relative to the "App_Config" directory.

E.g.:
Given the following project folder structure:
    
    "C:\MySolution\src\Foundation\MyProject\App_Config\MyConfig.Debug.config"

... and given the webroot "C:\MyWebsite\www"
... the transform "MyConfig.Debug.config" would be applied to the following configuration file:

    "C:\MyWebsite\www\App_Config\MyConfig.config"

.PARAMETER ConfigurationTransformFilePath
E.g. "C:\MySite\App_Config\Sitecore\Include\Web.Debug.config".

.PARAMETER WebrootDirectory
E.g. "D:\websites\AAB.Intranet\www".

.EXAMPLE
Invoke-ConfigurationTransform -ConfigurationTransformFilePath "D:\Projects\AAB.Intranet\src\Project\Environment\App_Config\Include\dataFolder.Debug.config" -WebrootDirectory "D:\websites\AAB.Intranet\www" -Verbose
This modifies the file "D:\websites\AAB.Intranet\www\App_Config\Include\dataFolder.config" using the transformations found in "dataFolder.Debug.config" and outputs verbose log messages.
#>
Function Invoke-ConfigurationTransform {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $True, ValueFromPipeline)]
        [string]$ConfigurationTransformFilePath,
        [Parameter(Mandatory = $True)]
        [string]$WebrootDirectory
    )

    Process {
        If (!(Test-Path -Path $ConfigurationTransformFilePath -PathType Leaf)) {
            Throw "File '$ConfigurationTransformFilePath' not found."
        }
        If (!(Test-Path -Path $WebrootDirectory -PathType Container)) {
            Throw "Directory '$WebrootDirectory' not found."
        }
        $NameOfFileToTransform = Get-FileToTransform $ConfigurationTransformFilePath
        $RelativeConfigurationDirectory = Get-RelativeConfigurationDirectory $ConfigurationTransformFilePath
        $PathOfFileToTransform = [System.IO.Path]::Combine($WebrootDirectory, $RelativeConfigurationDirectory, $NameOfFileToTransform)
        Write-Verbose "Transforming '$ConfigurationTransformFilePath' to '$PathOfFileToTransform'."        
        $TransformedXmlDocument = TransformXmlDocument -XmlFilePath $PathOfFileToTransform -XdtFilePath $ConfigurationTransformFilePath
        $TransformedXmlDocument | Out-File -FilePath $PathOfFileToTransform -Encoding utf8 -Force
    }
}


Function Get-FileToTransform {
    Param (
        [Parameter(Mandatory = $True)]
        [string]$ConfigurationTransformFilePath
    )
    # "C:\MySite\App_Config\Sitecore\Include\Web.Debug.Config" -> "Web.Debug.Config"
    $FileName = [System.IO.Path]::GetFileName($ConfigurationTransformFilePath)
    $FileNamePartSeparator = "."
    # ["Web", "Debug", "config"]
    [System.Collections.ArrayList]$FileNameParts = $FileName.Split($FileNamePartSeparator)
    $BuildConfigurationIndex = $FileNameParts.Count - 2
    If($BuildConfigurationIndex -lt 1) {
        Throw "Can't determine file to transform based on file name '$FileName'. The file name must follow the convention 'my.file.name.<BuildConfiguration>.config', e.g. 'Solr.Index.Debug.config'."
    }
    # ["Web", "Debug", "config"] -> ["Web", "config"]
    $FileNameParts.RemoveAt($BuildConfigurationIndex)
    # ["Web", "config"] -> "Web.config"
    [string]::Join($FileNamePartSeparator, $FileNameParts.ToArray())
}

Function Get-RelativeConfigurationDirectory {
    Param (
        [Parameter(Mandatory = $True)]
        [string]$ConfigurationTransformFilePath
    )
    # "C:\MySite\App_Config\Sitecore\Include\Pentia\Sites.Debug.Config" -> "C:\MySite\App_Config\Sitecore\Include\Pentia"
    $DirectoryName = [System.IO.Path]::GetDirectoryName($ConfigurationTransformFilePath)
    $ConfigurationDirectoryName = "App_Config"
    $ConfigurationDirectoryIndex = $DirectoryName.IndexOf($ConfigurationDirectoryName, [System.StringComparison]::InvariantCultureIgnoreCase)
    If($ConfigurationDirectoryIndex -lt 0) {
        Throw "Can't determine relative configuration directory. '$ConfigurationDirectoryName' not found in path '$ConfigurationTransformFilePath'."
    }
    # "C:\MySite\App_Config\Sitecore\Include\Pentia" -> "App_Config\Sitecore\Include\Pentia"
    $DirectoryName.Substring($ConfigurationDirectoryIndex)
}

Function TransformXmlDocument {
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

    $XmlDocument = New-Object Microsoft.Web.XmlTransform.XmlTransformableDocument
    $XmlDocument.PreserveWhitespace = $True
    $XmlDocument.Load($XmlFilePath)

    $Transformation = New-Object Microsoft.Web.XmlTransform.XmlTransformation($XdtFilePath)
    If ($Transformation.Apply($XmlDocument) -eq $False)
    {
        Throw "Transformation of document '$XmlFilePath' failed using transform file '$XdtFilePath'."
    }
    $StringWriter = New-Object -TypeName "System.IO.StringWriter"
    $XmlTextWriter = [System.Xml.XmlWriter]::Create($stringWriter)
    $XmlDocument.WriteTo($XmlTextWriter)
    $XmlTextWriter.Flush()
    $TransformedXml = $StringWriter.GetStringBuilder().ToString()
    $XmlTextWriter.Dispose()
    $StringWriter.Dispose()
    
    $TransformedXml.Trim()
}

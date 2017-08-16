. "$PSScriptRoot\..\Shared\Get-MSBuild.ps1"

<#
.SYNOPSIS
Short description

.DESCRIPTION
Given the following file and folder structure:
    /src/Foundation/MyProject/App_Config/MyProject/MyConfig.Debug.config
    ... the transform "MyConfig.Debug.config" is applied to the file "/webroot/App_Config/MyProject/MyProject.config" when $BuildConfiguration is "Debug".

.PARAMETER ConfigurationTransformFilePath
Parameter description

.PARAMETER BuildConfiguration
Parameter description

.PARAMETER TransformDirectory
Parameter description

.PARAMETER MSBuildExecutablePath
Parameter description

.EXAMPLE
An example

.NOTES
General notes
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
        $NameOfFileToTransform = Get-FileToTransform $ConfigurationTransformFilePath
        $RelativeConfigurationDirectory = Get-RelativeConfigurationDirectory $ConfigurationTransformFilePath
        $PathOfFileToTransform = [System.IO.Path]::Combine($WebrootDirectory, $RelativeConfigurationDirectory, $NameOfFileToTransform)

        Write-Verbose "Transforming '$ConfigurationTransformFilePath' to '$PathOfFileToTransform'."
        
        TransformXmlDocument -XmlFilePath $PathOfFileToTransform -XdtFilePath $ConfigurationTransformFilePath
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
        [string]$XmlFilePath
    )
    Param (
        [Parameter(Mandatory = $True)]
        [string]$XdtFilePath
    )
    If (!(Test-Path -Path $XmlFilePath -PathType Leaf)) {
        Throw "File not found. $XmlFilePath"
    }
    If (!(Test-Path -Path $XdtFilePath -PathType Leaf)) {
        Throw "File not found. $XdtFilePath"
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
    $XmlDocument.Save($XmlFilePath);
}

Invoke-ConfigurationTransform -ConfigurationTransformFilePath D:\Projects\AAB.Intranet\src\Project\Environment\App_Config\Include\dataFolder.Debug.config -WebrootDirectory D:\websites\AAB.Intranet -Verbose
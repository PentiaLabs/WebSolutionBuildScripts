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
        [Parameter(Position = 0, Mandatory = $True, ValueFromPipeline)]
        [string]$ConfigurationTransformFilePath,
        [Parameter(Position = 2, Mandatory = $True)]
        [string]$WebrootDirectory
    )

    Process {
        $NameOfFileToTransform = Get-FileToTransform $ConfigurationTransformFilePath
        $RelativeConfigurationDirectory = Get-RelativeConfigurationDirectory $ConfigurationTransformFilePath
        $PathOfFileToTransform = [System.IO.Path]::Combine($WebrootDirectory, $RelativeConfigurationDirectory, $NameOfFileToTransform)

        Write-Verbose "Transforming '$ConfigurationTransformFilePath' to '$PathOfFileToTransform'."
        
        XmlDocTransform -xml $PathOfFileToTransform -xdt $ConfigurationTransformFileName
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

Function XmlDocTransform($xml, $xdt)
{
    if (!$xml -or !(Test-Path -path $xml -PathType Leaf)) {
        throw "File not found. $xml";
    }
    if (!$xdt -or !(Test-Path -path $xdt -PathType Leaf)) {
        throw "File not found. $xdt";
    }

    Add-Type -LiteralPath "$PSScriptRoot\Microsoft.Web.XmlTransform.dll"

    $xmldoc = New-Object Microsoft.Web.XmlTransform.XmlTransformableDocument;
    $xmldoc.PreserveWhitespace = $true
    $xmldoc.Load($xml);

    $transf = New-Object Microsoft.Web.XmlTransform.XmlTransformation($xdt);
    if ($transf.Apply($xmldoc) -eq $false)
    {
        throw "Transformation failed."
    }
    $xmldoc.Save($xml);
}

Invoke-ConfigurationTransform -ConfigurationTransformFilePath D:\Projects\AAB.Intranet\src\Project\Environment\App_Config\Include\dataFolder.Debug.config -WebrootDirectory D:\websites\AAB.Intranet -Verbose
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
        $FileToTransform = Get-FileToTransform -ConfigurationTransformFilePath $ConfigurationTransformFilePath
        $FileToTransform = [System.IO.Path]::Combine($WebrootDirectory, $FileToTransform)

        Write-Verbose "Transforming '$ConfigurationTransformFilePath' to '$FileToTransform'."
        
        XmlDocTransform -xml $FileToTransform -xdt $ConfigurationTransformFileName
    }
}

Function Get-FileToTransform {
    Param (
        [Parameter(Mandatory = $True)]
        [string]$ConfigurationTransformFilePath
    )

    #TODO Add handling of App_Config 

    $BuildConfiguration = $ConfigurationTransformFilePath.Split(".") | Select-Object -Last 2 | Select-Object -First 1 

    $BuildConfigurationLenght = $BuildConfiguration.Length
    
    $ConfigurationTransformFileName = Get-Item $ConfigurationTransformFilePath | Select-Object -ExpandProperty Name

    $IndexOfBuildConfiguration = $ConfigurationTransformFileName.LastIndexOf($BuildConfiguration)

    return $ConfigurationTransformFileName.Remove($IndexOfBuildConfiguration, $BuildConfigurationLenght+1)
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
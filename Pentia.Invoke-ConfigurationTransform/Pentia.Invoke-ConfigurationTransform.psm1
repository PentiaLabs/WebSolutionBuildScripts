<#
.SYNOPSIS
Determines the location of a configuration file in a target directory based 
on the location of a XDT file in a source directory.

.DESCRIPTION
The location of the "configuration target file" is determined based on:
EITHER the location of the transform file relative to the "App_Config" directory,
OR in case of files named "Web.config", "Web.Feature.MyProject.config" etc., defaults to "<WebrootOutputPath>\Web.config".

E.g.:
Given the following project folder structure:
    
    "C:\MySolution\src\Foundation\MyProject\App_Config\MyConfig.Debug.config"
    "C:\MySolution\src\Foundation\MyProject\Web.MyProject.Debug.config"

... and given the webroot "C:\MyWebsite\www"
... the XDT file "MyConfig.Debug.config" would match the configuration file:

    "C:\MyWebsite\www\App_Config\MyConfig.config"

... and the XDT file "Web.MyProject.Debug.config" would match the configuration file:

    "C:\MyWebsite\www\Web.config"

.PARAMETER SolutionRootPath
E.g. "C:\MySolution\".

.PARAMETER ConfigurationTransformFilePath
E.g. "C:\MySolution\src\Foundation\Code\App_Config\Sitecore\Include\MyConfig.Debug.config".

.PARAMETER WebrootOutputPath
E.g. "D:\websites\MySolution\www".
#>
function Get-PathOfFileToTransform {
    [CmdletBinding()]
    [OutputType([string])]    
    param (
        [Parameter(Mandatory = $true)]
        [string]$ConfigurationTransformFilePath,
        [Parameter(Mandatory = $true)]
        [string]$WebrootOutputPath
    )
    $nameOfFileToTransform = Get-NameOfFileToTransform -ConfigurationTransformFilePath $ConfigurationTransformFilePath
    if ($nameOfFileToTransform -eq "Web.config") {
        Write-Verbose "Using path of the main 'Web.config' file."
        $pathOfFileToTransform = [System.IO.Path]::Combine($WebrootOutputPath, "Web.config")
    }
    elseif ($nameOfFileToTransform -imatch "Web\..*\.config") {
        Write-Verbose "Using path of the main 'Web.config' file, by convention."
        $pathOfFileToTransform = [System.IO.Path]::Combine($WebrootOutputPath, "Web.config")
    }
    else {
        Write-Verbose "Resolving path to the matching configuration file in 'App_Config'."        
        $relativeConfigurationDirectory = Get-RelativeConfigurationDirectory -ConfigurationTransformFilePath $ConfigurationTransformFilePath
        $pathOfFileToTransform = [System.IO.Path]::Combine($WebrootOutputPath, $relativeConfigurationDirectory, $nameOfFileToTransform)    
    }
    Write-Verbose "Found matching configuration file '$pathOfFileToTransform' for configuration transform '$ConfigurationTransformFilePath'."
    $pathOfFileToTransform
}

function Get-RelativeConfigurationDirectory {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$ConfigurationTransformFilePath
    )
    # "C:\MySite\App_Config\Sitecore\Include\Pentia\Sites.Debug.Config" -> "C:\MySite\App_Config\Sitecore\Include\Pentia"
    $directoryName = [System.IO.Path]::GetDirectoryName($ConfigurationTransformFilePath)
    $configurationDirectoryName = "App_Config"
    $configurationDirectoryIndex = $DirectoryName.IndexOf($configurationDirectoryName, [System.StringComparison]::InvariantCultureIgnoreCase)
    if ($configurationDirectoryIndex -lt 0) {
        throw "Can't determine relative configuration directory. '$configurationDirectoryName' not found in path '$ConfigurationTransformFilePath'."
    }
    # "C:\MySite\App_Config\Sitecore\Include\Pentia" -> "App_Config\Sitecore\Include\Pentia"
    $directoryName.Substring($configurationDirectoryIndex)
}

function Get-NameOfFileToTransform {
    [CmdletBinding()]
    [OutputType([string])]        
    param (
        [Parameter(Mandatory = $true)]
        [string]$ConfigurationTransformFilePath
    )
    # "C:\MySite\App_Config\Sitecore\Include\MyConfig.Debug.Config" -> "MyConfig.Debug.Config"
    $fileName = [System.IO.Path]::GetFileName($ConfigurationTransformFilePath)
    $fileNamePartSeparator = "."
    # ["MyConfig", "Debug", "config"]
    [System.Collections.ArrayList]$fileNameParts = $fileName.Split($fileNamePartSeparator)
    $buildConfigurationIndex = $fileNameParts.Count - 2
    if ($buildConfigurationIndex -lt 1) {
        throw "Can't determine file to transform based on file name '$fileName'. The file name must follow the convention 'my.file.name.<BuildConfiguration>.config', e.g. 'Solr.Index.Debug.config'."
    }
    # ["MyConfig", "Debug", "config"] -> ["MyConfig", "config"]
    $fileNameParts.RemoveAt($buildConfigurationIndex)
    # ["MyConfig", "config"] -> "MyConfig.config"
    [string]::Join($fileNamePartSeparator, $fileNameParts.ToArray())
}

<#
.SYNOPSIS
Applies a configuration transform to a configuration file, and returns the result.

.PARAMETER XmlFilePath
The path to the configuration file.

.PARAMETER XdtFilePath
The path to the configuration transform file.

.EXAMPLE
Invoke-ConfigurationTransform -XmlFilePath "C:\Solution\src\Web.config" -XdtFilePath "C:\Solution\src\Web.Debug.config" | Set-Content "C:\Website\Web.config"
Note the call to "Set-Content", to use the resulting output for something meaningful.
#>
function Invoke-ConfigurationTransform {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$XmlFilePath,        
        [Parameter(Mandatory = $true)]
        [string]$XdtFilePath
    )
    if (!(Test-Path -Path $XmlFilePath -PathType Leaf)) {
        throw "File '$XmlFilePath' not found."
    }
    if (!(Test-Path -Path $XdtFilePath -PathType Leaf)) {
        throw "File '$XdtFilePath' not found."
    }

    if (-not ([System.IO.Path]::IsPathRooted($XmlFilePath))) {
        $XmlFilePath = [System.IO.Path]::Combine($PWD, $XmlFilePath)
    }    
    if (-not ([System.IO.Path]::IsPathRooted($XdtFilePath))) {
        $XdtFilePath = [System.IO.Path]::Combine($PWD, $XdtFilePath)
    }

    Add-Type -LiteralPath "$PSScriptRoot\lib\Microsoft.Web.XmlTransform.dll" -ErrorAction Stop

    $xmlDocument = New-Object Microsoft.Web.XmlTransform.XmlTransformableDocument
    $xmlDocument.PreserveWhitespace = $true
    $xmlDocument.Load($XmlFilePath)

    $transformation = New-Object Microsoft.Web.XmlTransform.XmlTransformation($XdtFilePath)
    $errorMessage = "Transformation of '$XmlFilePath' failed using transform '$XdtFilePath'."
    try {
        if ($transformation.Apply($xmlDocument) -eq $false) {
            $exception = New-Object "System.InvalidOperationException" -ArgumentList $errorMessage
            throw $exception
        }
    }
    catch [Microsoft.Web.XmlTransform.XmlNodeException] {
        $innerException = $_.Exception
        $errorMessage = $errorMessage + " See the inner exception for details."
        $exception = New-Object "System.InvalidOperationException" -ArgumentList $errorMessage, $innerException
        throw $exception
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

<#
.SYNOPSIS
Applies all configuration transforms found under the specified root path, matching a certain build configuration. 
By convention, XDTs ending with ".Always.config" are always applied.

.PARAMETER SolutionOrProjectRootPath
The root path from which to fetch XDT files.

.PARAMETER WebrootOutputPath
The root path in which to search for configuration files.

.PARAMETER BuildConfiguration
The build configuration for which to apply transforms.

.EXAMPLE
Invoke-AllConfigurationTransforms -SolutionOrProjectRootPath "C:\MySolution\src\MyProject" -WebrootOutputPath "C:\Websites\MySolution\www" -BuildConfiguration "Debug"
#>
function Invoke-AllConfigurationTransforms {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$SolutionOrProjectRootPath,

        [Parameter(Mandatory = $true)]
        [string]$WebrootOutputPath,
        
        [Parameter(Mandatory = $true)]
        [string]$BuildConfiguration
    )
    $xdtFiles = @(Get-ConfigurationTransformFile -SolutionRootPath $SolutionOrProjectRootPath -BuildConfigurations "Always", $BuildConfiguration)
    for ($i = 0; $i -lt $xdtFiles.Count; $i++) {
        Write-Progress -Activity "Configuring web solution" -PercentComplete ($i / $xdtFiles.Count * 100) -Status "Applying XML Document Transforms" -CurrentOperation "$xdtFile"
        $xdtFile = $xdtFiles[$i]
        $fileToTransform = Get-PathOfFileToTransform -ConfigurationTransformFilePath $xdtFile -WebrootOutputPath $WebrootOutputPath
        Invoke-ConfigurationTransform -XmlFilePath $fileToTransform -XdtFilePath $xdtFile | Set-Content -Path $fileToTransform -Encoding UTF8
    }
}

Export-ModuleMember -Function Get-PathOfFileToTransform, Invoke-ConfigurationTransform, Invoke-AllConfigurationTransforms

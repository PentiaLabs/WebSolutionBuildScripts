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
Function Get-PathOfFileToTransform {
    [CmdletBinding()]
    [OutputType([System.String])]    
    Param (
        [Parameter(Mandatory = $True)]
        [string]$ConfigurationTransformFilePath,
        [Parameter(Mandatory = $True)]
        [string]$WebrootOutputPath
    )
    $nameOfFileToTransform = Get-NameOfFileToTransform -ConfigurationTransformFilePath $ConfigurationTransformFilePath
    If ($nameOfFileToTransform -imatch "Web\.?.*\.config") {
        Write-Verbose "Using path of the main 'Web.config' file."
        $pathOfFileToTransform = [System.IO.Path]::Combine($WebrootOutputPath, "Web.config")
    }
    Else {
        Write-Verbose "Resolving path to the matching configuration file in 'App_Config'."        
        $relativeConfigurationDirectory = Get-RelativeConfigurationDirectory -ConfigurationTransformFilePath $ConfigurationTransformFilePath
        $pathOfFileToTransform = [System.IO.Path]::Combine($WebrootOutputPath, $relativeConfigurationDirectory, $nameOfFileToTransform)    
    }
    Write-Verbose "Found matching configuration file '$pathOfFileToTransform' for configuration transform '$ConfigurationTransformFilePath'."
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
    [OutputType([System.String])]        
    Param (
        [Parameter(Mandatory = $True)]
        [string]$ConfigurationTransformFilePath
    )
    # "C:\MySite\App_Config\Sitecore\Include\MyConfig.Debug.Config" -> "MyConfig.Debug.Config"
    $fileName = [System.IO.Path]::GetFileName($ConfigurationTransformFilePath)
    $fileNamePartSeparator = "."
    # ["MyConfig", "Debug", "config"]
    [System.Collections.ArrayList]$fileNameParts = $fileName.Split($fileNamePartSeparator)
    $buildConfigurationIndex = $fileNameParts.Count - 2
    If ($buildConfigurationIndex -lt 1) {
        Throw "Can't determine file to transform based on file name '$fileName'. The file name must follow the convention 'my.file.name.<BuildConfiguration>.config', e.g. 'Solr.Index.Debug.config'."
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

    Add-Type -LiteralPath "$PSScriptRoot\lib\Microsoft.Web.XmlTransform.dll" -ErrorAction Stop

    $xmlDocument = New-Object Microsoft.Web.XmlTransform.XmlTransformableDocument
    $xmlDocument.PreserveWhitespace = $True
    $xmlDocument.Load($XmlFilePath)

    $transformation = New-Object Microsoft.Web.XmlTransform.XmlTransformation($XdtFilePath)
    $errorMessage = "Transformation of '$XmlFilePath' failed using transform '$XdtFilePath'."
    Try {
        If ($transformation.Apply($xmlDocument) -eq $False) {
            $exception = New-Object "System.InvalidOperationException" -ArgumentList $errorMessage
            Throw $exception
        }
    }
    Catch [Microsoft.Web.XmlTransform.XmlNodeException] {
        $innerException = $_.Exception
        $errorMessage = $errorMessage + " See the inner exception for details."
        $exception = New-Object "System.InvalidOperationException" -ArgumentList $errorMessage, $innerException
        Throw $exception
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

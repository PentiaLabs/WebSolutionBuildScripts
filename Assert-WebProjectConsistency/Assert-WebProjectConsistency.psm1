<#
.SYNOPSIS
Runs various sanity checks on a web project and it's configuration files.

.DESCRIPTION
Checks for:
- SlowCheetah
- Build actions set for XDT files
- Reserved file names like "Web.config"
- Configuration file encoding

.PARAMETER ProjectFilePath
The absolute path to the .csproj-file.

.PARAMETER BuildConfiguration
The current build configuration.

.EXAMPLE
Assert-WebProjectConsistency -ProjectFilePath "D:\Projects\MySolution\src\MyProject\code\MyProject.csproj" -BuildConfiguration "Staging"
#>
Function Assert-WebProjectConsistency {
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingWriteHost', '', Scope = 'Function')]
    Param(
        [Parameter(Mandatory = $True, ValueFromPipeline = $True)]
        [string]$ProjectFilePath,
        
        [Parameter(Mandatory = $True)]
        [string]$BuildConfiguration
    )
    Process {
        If (-not (Test-Path $ProjectFilePath -PathType Leaf)) {
            Throw "File '$ProjectFilePath' not found."
        }
        
        Write-Verbose "Processing '$ProjectFilePath'..."
        
        Write-Verbose "Checking for SlowCheetah..."
        If (-not (Test-SlowCheetah -ProjectFilePath $ProjectFilePath)) {
            Write-Verbose "SlowCheetah is not installed."
        }
    
        Write-Verbose "Checking for XDT build actions..."
        If (Test-XdtBuildActionContent -ProjectFilePath $ProjectFilePath -BuildConfiguration $BuildConfiguration) {
            Write-Verbose "Build action of XDTs is 'Content'."
        }
    
        Write-Verbose "Checking for reserved file names..."
        If (-not (Test-ReservedFilePath -ProjectFilePath $ProjectFilePath)) {
            Write-Verbose "Reserved file names are not used."
        }
        
        Write-Verbose "Checking for XML declaration..."
        If (Test-XmlDeclaration -Path $ProjectFilePath) {
            Write-Verbose "XML declaration found."
        }
    
        Write-Verbose "Checking for correct file encoding..."
        If (Test-XmlFileEncoding -Path $ProjectFilePath) {
            Write-Verbose "File encoding matches encoding specified in XML declaration."
        }
    }
}

Function Test-SlowCheetah {
    Param(
        [Parameter(Mandatory = $True)]
        [string]$ProjectFilePath
    )
    [xml]$projectFileContents = Get-Content -Path $ProjectFilePath
    If ($projectFileContents.OuterXml -match "SlowCheetah") {
        Write-Warning "Found SlowCheetah references in '$ProjectFilePath'."
        return $True
    }
    return $False
}

Function Test-XdtBuildActionContent {
    Param(
        [Parameter(Mandatory = $True)]
        [string]$ProjectFilePath,

        [Parameter(Mandatory = $True)]
        [string]$BuildConfiguration
    )
    [xml]$projectFileContents = Get-Content -Path $ProjectFilePath
    $valid = $True
    $elements = Get-ElementsWithIncludeAttribute -Xml $ProjectFileContents
    foreach ($element in $elements) {
        $filePath = $element.GetAttribute("Include")
        $appliesToCurrentBuildConfiguration = $filePath.EndsWith(".$BuildConfiguration.config", [System.StringComparison]::InvariantCultureIgnoreCase)
        if (-not $appliesToCurrentBuildConfiguration) {
            continue
        }
        $buildAction = $element.LocalName
        if ($buildAction.Equals("Content")) {
            continue
        }
        Write-Warning "Found potential XDT '$filePath' with build action '$buildAction' in '$ProjectFilePath'."
        $valid = $False
    }
    $valid
}

Function Get-ElementsWithIncludeAttribute {
    Param(
        [Parameter(Mandatory = $True)]
        [xml]$Xml
    )
    return Select-Xml -Xml $Xml -XPath "//*[@Include != '']" | Select-Object -ExpandProperty "Node"
}

Function Test-ReservedFilePath {
    Param(
        [Parameter(Mandatory = $True)]
        [string]$ProjectFilePath
    )
    $reservedFilePaths = @("Web.config")
    [xml]$projectFileContents = Get-Content -Path $ProjectFilePath
    $elements = Get-ElementsWithIncludeAttribute -Xml $projectFileContents
    $containsReservedFileName = $False
    foreach ($element in $elements) {
        $filePath = $element.GetAttribute("Include")
        $buildAction = $element.LocalName
        If ($reservedFilePaths -contains $filePath -and $buildAction -eq "Content") {
            Write-Warning "Found file reference '$filePath' using reserved path '$filePath' with build action '$buildAction' in '$ProjectFilePath'."
            $containsReservedFileName = $True
        }
    }
    $containsReservedFileName
}

Function Test-XmlDeclaration {
    Param(
        [Parameter(Mandatory = $True)]
        [string]$Path
    )
    $measurement = Get-XmlDeclaration $Path | Measure-Object
    If ($measurement.Count -eq 0) {
        Write-Warning "File '$Path' doesn't contain an XML declaration."
        return $False
    }
    $True
}

Function Get-XmlDeclaration {
    Param(
        [Parameter(Mandatory = $True)]
        [string]$Path
    )
    [xml]$xml = Get-Content $Path
    $xml.ChildNodes | Where-Object { $_.NodeType -eq "XmlDeclaration" }
}

Function Test-XmlFileEncoding {
    Param(
        [Parameter(Mandatory = $True)]
        [string]$Path
    )
    $xmlEncoding = Get-XmlDeclaration $Path | Select-Object -ExpandProperty "encoding"
    $normalizedXmlEncoding = $xmlEncoding -replace "\W", "" # "utf-8" -> "utf8"
    $fileEncoding = Get-FileEncoding -Path $Path
    If ($fileEncoding.Equals($normalizedXmlEncoding, [System.StringComparison]::InvariantCultureIgnoreCase)) {
        return $True
    }
    Write-Warning "Found file '$Path' saved as encoding '$fileEncoding', which doesn't match XML declaration encoding '$xmlEncoding'."
    $False
}

# Copied from https://stackoverflow.com/questions/3710374/get-encoding-of-a-file-in-windows
Function Get-FileEncoding {
    Param(
        [Parameter(Mandatory = $True)]
        [string]$Path
    )
    $bytes = [byte[]](Get-Content $Path -Encoding byte -ReadCount 4 -TotalCount 4)

    if (-not $bytes) { return 'utf8' }

    switch -regex ('{0:x2}{1:x2}{2:x2}{3:x2}' -f $bytes[0], $bytes[1], $bytes[2], $bytes[3]) {
        '^efbbbf' { return 'utf8' }
        '^2b2f76' { return 'utf7' }
        '^fffe' { return 'unicode' }
        '^feff' { return 'bigendianunicode' }
        '^0000feff' { return 'utf32' }
        default { return 'ascii' }
    }
}

Export-ModuleMember -Function Assert-WebProjectConsistency

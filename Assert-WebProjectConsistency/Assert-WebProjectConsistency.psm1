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
    Param(
        [Parameter(Mandatory = $True)]
        [string]$ProjectFilePath,
        
        [Parameter(Mandatory = $True)]
        [string]$BuildConfiguration
    )
    If (-not (Test-Path $ProjectFilePath -PathType Leaf)) {
        Throw "File '$ProjectFilePath' not found."
    }

    [xml]$projectFileContents = Get-Content -Path $ProjectFilePath
    If (Test-SlowCheetah -ProjectFileContents $projectFileContents) {
        Write-Error "Found SlowCheetah references in the project '$ProjectFilePath'."
    }
    
    If (Test-XdtBuildActionContent -ProjectFileContents $projectFileContents -BuildConfiguration $BuildConfiguration) {
        Write-Error "Found XDT with incorrect build action in the project '$ProjectFilePath'."
    }

    If (Test-ReservedFileName -ProjectFileContents $projectFileContents) {
        Write-Error "Found content with reserved file name in the project '$ProjectFilePath'."
    }
    
    If (-not (Test-XmlFileEncoding -Path $projectFileContents)) {
        Write-Error "Found files with incorrect encoding in the project '$ProjectFilePath'."
    }
}

Function Test-SlowCheetah {
    Param(
        [Parameter(Mandatory = $True)]
        [xml]$ProjectFileContents
    )
    If ($ProjectFileContents.OuterXml -match "SlowCheetah") {
        Write-Warning "Found SlowCheetah references in the project."
        return $True
    }
    return $False
}

Function Test-XdtBuildActionContent {
    Param(
        [Parameter(Mandatory = $True)]
        [xml]$ProjectFileContents,

        [Parameter(Mandatory = $True)]
        [string]$BuildConfiguration
    )
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
        Write-Warning "Found potential XDT '$filePath' with build action '$buildAction'."
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

Function Test-ReservedFileName {
    Param(
        [Parameter(Mandatory = $True)]
        [xml]$ProjectFileContents
    )
    $reservedFileNames = @("Web.config")
    $elements = Get-ElementsWithIncludeAttribute -Xml $ProjectFileContents
    $containsReservedFileName = $False
    foreach ($element in $elements) {
        $filePath = $element.GetAttribute("Include")
        $fileName = [System.IO.Path]::GetFileName($filePath)
        $buildAction = $element.LocalName
        If ($reservedFileNames -contains $fileName -and $buildAction -eq "Content") {
            Write-Warning "Found file reference '$filePath' using reserved name '$fileName' with build action '$buildAction'."
            $containsReservedFileName = $True
        }
    }
    $containsReservedFileName
}

Function Test-XmlFileEncoding {
    Param(
        [Parameter(Mandatory = $True)]
        $Path
    )
    [xml]$xml = Get-Content $Path
    $xmlEncoding = $xml.ChildNodes | Where-Object { 
        $_.NodeType -eq "XmlDeclaration" 
    } | Select-Object -ExpandProperty "encoding"
    $normalizedXmlEncoding = $xmlEncoding -replace "\W", "" # "utf-8" -> "utf8"
    $fileEncoding = Get-FileEncoding -Path $Path
    If ($normalizedXmlEncoding.Equals($fileEncoding, [System.StringComparison]::InvariantCultureIgnoreCase)) {
        return $True
    }
    Write-Warning "Found file '$Path' saved as encoding '$fileEncoding', which doesn't match XML declaration encoding '$xmlEncoding'."
    $False
}

# Copied from https://stackoverflow.com/questions/3710374/get-encoding-of-a-file-in-windows
Function Get-FileEncoding {
    Param(
        [Parameter(Mandatory = $True)]
        $Path
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

Export-ModuleMember "Assert-WebProjectConsistency"
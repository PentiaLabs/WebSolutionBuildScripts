<#
.SYNOPSIS
Gets all NuGet package references from a well formed NuGet packages.config-file.

.DESCRIPTION
See https://docs.microsoft.com/en-us/nuget/schema/packages-config for the correct file format.
Only the "id" and "version" attributes are used.

.PARAMETER ConfigurationFilePath
The path of the packages.config file.

.EXAMPLE
Get-RuntimeDependencyPackage -ConfigurationFilePath my-solution\runtime-dependencies.config

Contents of "runtime-dependencies.config":
<?xml version="1.0" encoding="utf-8"?>
<packages>
  <package id="jQuery" version="3.1.1" />
  <package id="NLog" version="4.3.10" />
</packages>

Returns:
[{id:"jQuery",version:"3.1.1"},{id:"NLog",version:"4.3.10"}]

#>
Function Get-RuntimeDependencyPackage {
    Param(
        [Parameter(Mandatory = $True)]
        [string]$ConfigurationFilePath
    )

    If (!(Test-Path $ConfigurationFilePath -PathType Leaf)) {
        $message = "File '$ConfigurationFilePath' not found."
        $argumentException = (New-Object "System.ArgumentException" $message, $_.Exception)
        Throw $argumentException
    }

    $configuration = Get-PackageConfiguration -ConfigurationFilePath $ConfigurationFilePath

    If (!($configuration.packages)) {
        Throw "No 'packages' root element found in '$ConfigurationFilePath'. Run 'Get-Help Get-RuntimeDependencyPackage -Full' for expected usage."
    }

    $packages = $configuration.packages.package | Select-Object -Property "id", "version"
    Write-Verbose "Found $($packages.Count) package(s) in '$ConfigurationFilePath'."
    $packages
}

Function Get-PackageConfiguration {
    Param(
        [Parameter(Mandatory = $True)]
        [string]$ConfigurationFilePath
    )

    Try {
        [xml]$configuration = Get-Content -Path $ConfigurationFilePath
    }
    Catch [System.Management.Automation.RuntimeException] {
        If (Test-XmlParseException $_.Exception) {
            $message = "File '$ConfigurationFilePath' isn't valid XML. Run 'Get-Help Get-RuntimeDependencyPackage -Full' for expected usage."
            $argumentException = (New-Object "System.ArgumentException" $message, $_.Exception)
            Throw $argumentException
        }
        Throw $_.Exception
    }

    $configuration
}

Function Test-XmlParseException {
    Param(
        [Parameter(Mandatory = $True)]
        [System.Management.Automation.RuntimeException]$Exception
    )
    $Exception.Message -match "Cannot convert value .* to type ""System\.Xml\.XmlDocument""\."
}

Export-ModuleMember -Function Get-RuntimeDependencyPackage

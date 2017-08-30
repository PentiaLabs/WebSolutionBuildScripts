Import-Module "$PSScriptRoot\Publish-HelixSolution\Get-SitecoreHelixProject.psm1" -Force
Import-Module "$PSScriptRoot\Publish-HelixSolution\Publish-WebProject.psm1" -Force
Import-Module "$PSScriptRoot\Publish-RuntimeDependencyPackage\Publish-RuntimeDependencyPackage.ps1" -Force
Import-Module "$PSScriptRoot\Invoke-ConfigurationTransform\Invoke-ConfigurationTransform.psm1" -Force

Function Publish-HelixSolution {
    Param (
        [Parameter(Mandatory = $True)]
        [string]$SolutionRootPath,
        
        [Parameter(Mandatory = $True)]
        [string]$PublishToPath
    )

    # 1. Delete $PublishToPath
    
    # 2. Install packages
    # 2.1 Read "runtime-dependencies.json"
    # 2.2 Throw error when "runtime-dependencies.json" doesn't match JSON definition
    # 2.3 Install each package

    # 3. Publish all web projects

    # 4. Invoke configuration transforms
}

<#
.SYNOPSIS
Gets all NuGet package references from a well formed NuGet packages.config-file.

.DESCRIPTION
See https://docs.microsoft.com/en-us/nuget/schema/packages-config for the correct file format.
Only the "id" and "version" attributes are used.

.PARAMETER ConfigurationFilePath
The path of the packages.config file.

.EXAMPLE
Get-RuntimeDependencies -ConfigurationFilePath my-solution\runtime-dependencies.config

Contents of "runtime-dependencies.config":
<?xml version="1.0" encoding="utf-8"?>
<packages>
  <package id="jQuery" version="3.1.1" />
  <package id="NLog" version="4.3.10" />
</packages>

Returns:
[{id:"jQuery",version:"3.1.1"},{id:"NLog",version:"4.3.10"}]

#>
Function Get-RuntimeDependencies {
    Param(
        [Parameter(Mandatory = $True)]
        [string]$ConfigurationFilePath
    )

    If (!(Test-Path $ConfigurationFilePath -PathType Leaf)) {
        $message = "File '$ConfigurationFilePath' not found."
        $ex = (New-Object "System.ArgumentException" $message, $_.Exception)
        Throw $ex
    }

    Try {
        [xml]$configuration = Get-Content -Path $ConfigurationFilePath        
    }
    Catch [System.Management.Automation.RuntimeException] {
        If ($_.Exception.Message -match "Cannot convert value .* to type ""System\.Xml\.XmlDocument""\.") {
            $message = "File '$ConfigurationFilePath' isn't valid XML. Run 'Get-Help $($MyInvocation.MyCommand) -Full' for expected usage."
            $ex = (New-Object "System.ArgumentException" $message, $_.Exception)
            Throw $ex
        }
        Throw $_.Exception
    }

    If (!($configuration.packages)) {
        Throw "No 'packages' root element found in '$ConfigurationFilePath'. Run 'Get-Help $($MyInvocation.MyCommand) -Full' for expected usage."
    }
    
    $packages = $configuration.packages.package | Select-Object -Property "id","version"
    Write-Verbose "Found $($packages.Count) package(s) in '$ConfigurationFilePath'."
    $packages
}

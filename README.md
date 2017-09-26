# Pentia Build Scripts for Sitecore Helix solutions

## Prerequisites

If you haven't done so already, register the Pentia PowerShell NuGet feed by running the following command in an elevated PowerShell prompt:

```powershell
Register-PSRepository -Name "Pentia PowerShell" -SourceLocation "http://tund/nuget/powershell/" -InstallationPolicy "Trusted" -Verbose
```

## Installation

```powershell
Install-Module -Name "Publish-HelixSolution" -Repository "Pentia PowerShell" -Verbose
```

## Release management

1. Increase the version numbers in all `.psd`-files. Ensure to update dependency references as well!
2. Run `Publish-AllModules.ps1` to publish the updated modules to the Pentia PowerShell feed.

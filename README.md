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

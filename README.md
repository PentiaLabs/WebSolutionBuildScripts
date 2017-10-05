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

## Usage

1. Open an elevated PowerShell prompt in a Sitecore Helix solution root directory.
2. Run `Publish-HelixSolution`.
3. When prompted, enter valid values for `WebrootOutputPath` (e.g. `D:\Websites\FOF.Website\www`), `DataOutputPath` (e.g. `D:\Websites\FOF.Website\data`) and `BuildConfiguration` (e.g. `Debug`). These settings are then stored as default values in `<solution root>\.pentia\user-settings.json` for future use. The `.pentia`-directory should *not* be under version control.

## Release management

1. Increase the version numbers in all `.psd`-files. Ensure to update dependency references as well!
2. Run `Publish-AllModules.ps1` to publish the updated modules to the Pentia PowerShell feed.

## Requirements and design decisions

* *NEED* Deploy files to webroot during web publish.
* *NEED* Deploy files to data folder located outside of webroot during web publish.
* *NEED* Support configuration management using XDTs, to make packages environment agnostic.
* *NEED* Make the build process as transparent as possible, i.e. as a minimum, senior developers must be able to comprehend it.
* *NICE* Tearing down and building up an entire Sitecore site must be fast, to avoid having stale config and DLL files laying around in the webroot, due to multiple builds, branch switches etc.
* *NICE* Keep the deployment process consistent across environments, to minimize "works on my machine" errors.
* *NICE* Use existing Windows technology to build and deploy solutions, to avoid .NET-only projects having to use e.g. Gulp modules for deployment.

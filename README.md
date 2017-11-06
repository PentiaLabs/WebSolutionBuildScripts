# Pentia Build Scripts for Sitecore Helix Solutions

Build scripts written in PowerShell, intended to publish Sitecore Helix compliant solutions. 

To release a new version of the build scripts, read the [release management guide](/docs/release-management.md).

![**CI Build**](https://pentia.visualstudio.com/_apis/public/build/definitions/6af2be26-000f-4864-ad4c-0af024086c4e/11/badge)

## Installation

1. Open an elevated instance of PowerShell ISE.
2. Copy, paste and run the following commands: 
```powershell
# Register Pentia's NuGet package feed
Register-PackageSource -Name "Pentia NuGet" -Location "http://tund/nuget/NuGet" -ProviderName "NuGet" -Trusted -Verbose
  
# Register Pentia's PowerShell module feed
Register-PSRepository -Name "Pentia PowerShell" -SourceLocation "http://tund/nuget/powershell/" -InstallationPolicy "Trusted" -Verbose

# Install the latest version of the build scripts
Install-Module -Name "Publish-HelixSolution" -Repository "Pentia PowerShell" -Force -Verbose
```

## Updating

1. Open an elevated instance of PowerShell ISE.
2. Copy, paste and run the following commands: 
```powershell
# Install the latest version of the build scripts
Install-Module -Name "Publish-HelixSolution" -Repository "Pentia PowerShell" -Force -Verbose
```

## Table of contents

* [Usage](/docs/usage.md)
  * [Publishing a solution](/docs/usage.md#publishing-a-solution)
  * [Solution specific user settings](/docs/usage.md#solution-specific-user-settings)
  * [Adding Sitecore and Sitecore modules](/docs/usage.md#adding-sitecore-and-sitecore-modules)
  * [Configuration management](/docs/usage.md#configuration-management)
  * [Build script integration](/docs/usage.md#build-script-integration)
  * [Publish code only](/docs/usage.md#publish-code-only)
* [Migration guide](/docs/migration.md)
* [Development tool integration](/docs/development-tool-integration.md)
  * [Visual Studio Task Runner](/docs/development-tool-integration.md#visual-studio-task-runner)
  * [NPM](/docs/development-tool-integration.md#npm)
  * [Gulp](/docs/development-tool-integration.md#gulp)
* [Setting up Continuous Integration](/docs/devops.md#setting-up-continuous-integration)
  * [TeamCity CI](/docs/devops.md#teamcity-ci)
* [Setting up Continuous Delivery](/docs/devops.md#setting-up-continuous-delivery)
  * [TeamCity CD](/docs/devops.md#teamcity-cd)
  * [Octopus Deploy](/docs/devops.md#octopus-deploy)
* [Troubleshooting](/docs/troubleshooting.md)
  * [Getting help for PowerShell commands](/docs/troubleshooting.md#getting-help-for-powershell-commands)
  * [Running sanity checks](/docs/troubleshooting.md#running-sanity-checks)
  * [Debugging project publishing](/docs/troubleshooting.md#debugging-project-publishing)
  * [Build log](/docs/troubleshooting.md#build-log)
  * [Known issues](/docs/troubleshooting.md#known-issues)

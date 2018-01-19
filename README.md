# Pentia Build Scripts for web solutions

Build scripts written in PowerShell, intended to publish solutions containing web projects. 

To release a new version of the build scripts, read the [release management guide](/docs/release-management.md).

![**CI Build**](https://pentia.visualstudio.com/_apis/public/build/definitions/6af2be26-000f-4864-ad4c-0af024086c4e/11/badge)

## Terminology
* Solution root: Where your `.sln`-file and source code is located.
* Website root: The folder where the IIS-site is pointed at.
* Data root: The website's Sitecore data folder.

## Installation

1. Open an elevated instance of PowerShell ISE.
2. Copy, paste and run the following commands: 
```powershell
# Install NuGet package provider
Install-PackageProvider -Name "NuGet"

# Register Pentia's NuGet package feed
Register-PackageSource -Name "Pentia NuGet" -Location "http://tund/nuget/NuGet" -ProviderName "NuGet" -Trusted -Verbose
  
# Register Pentia's PowerShell module feed
Register-PSRepository -Name "Pentia PowerShell" -SourceLocation "http://tund/nuget/powershell/" -InstallationPolicy "Trusted" -Verbose

# Install the latest version of the build scripts
Install-Module -Name "Publish-WebSolution" -Repository "Pentia PowerShell" -Force -Verbose
```

## Updating

1. Open an elevated instance of PowerShell ISE.
2. Copy, paste and run the following commands: 
```powershell
# Install the latest version of the build scripts
Update-Module -Name "Publish-WebSolution" -Force -Verbose
```

## Table of contents

* [Pseudo-sequence diagram](/docs/pseudo-sequence-diagram.md)
* [Usage](/docs/usage.md)
  * [Publishing a solution](/docs/usage.md#publishing-a-solution)
  * [Publishing only code](/docs/usage.md#publishing-only-code)
  * [Publishing one or more projects](/docs/usage.md#publishing-one-or-more-projects)
  * [Solution specific user settings](/docs/usage.md#solution-specific-user-settings)
  * [Adding Sitecore and Sitecore modules](/docs/usage.md#adding-sitecore-and-sitecore-modules)
  * [Configuration management](/docs/usage.md#configuration-management)
  * [Build script integration](/docs/usage.md#build-script-integration)
* [Migration guide](/docs/migration.md)
  * [Slow Cheetah-based project](/docs/migration.md#slow-cheetah-based-project)
  * [Pentia Builder-based project](/docs/migration.md#pentia-builder-based-project)
  * [Pentia Gulp tasks-based project](/docs/migration.md#pentia-gulp-tasks-based-project)
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
* [FAQ](/docs/faq.md)
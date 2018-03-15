# Pentia Build Scripts for web solutions

Build scripts written in PowerShell, intended to publish solutions containing web projects. 

![**CI Build**](https://pentia.visualstudio.com/_apis/public/build/definitions/6af2be26-000f-4864-ad4c-0af024086c4e/39/badge)

## Table of contents
* [Terminology](#terminology)
* [Installation](#installation)
* [Updating](#updating)
* [Contributing](#contributing)
* [Usage](/docs/usage.md)
  * [Publishing a solution](/docs/usage.md#publishing-a-solution)
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
  * [Visual Studio Context Menu entry](/docs/development-tool-integration.md#visual-studio-context-menu-entry)
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

## Terminology
* Solution root: Where your `.sln`-file and source code is located.
* Website root: The folder where the IIS-site is pointed at.
* Data root: The website's Sitecore data folder.

## Installation

1. Open an elevated PowerShell prompt and run the following commands:
    ```powershell
    PowerShellGet\Install-Module -Name "PowerShellGet" -Repository "PSGallery" -Force
    PowerShellGet\Install-Module -Name "PackageManagement" -Repository "PSGallery" -Force
    PackageManagement\Install-PackageProvider -Name "NuGet" -Force
    ```

2. Close the PowerShell prompt.

3. Download the install script "[Install-WebSolutionBuildScripts.ps1](/Install-WebSolutionBuildScripts.ps1)" and save it to a file. E.g. "`%TEMP%\Install-WebSolutionBuildScripts.ps1`".
    
4. Open an elevated PowerShell prompt and run the install script. E.g. "`.\%TEMP%\Install-WebSolutionBuildScripts.ps1`". 
You'll be prompted for a Personal Access Token (PAT).
![Run installation script](/docs/images/install-websolutionbuildscripts.png)

5. [Generate a PAT](https://pentia.visualstudio.com/_details/security/tokens). The token must grant read-access to packages in the [Pentia VSTS PowerShell package feed](https://pentia.pkgs.visualstudio.com/_packaging/powershell-pentia/nuget/v2). 
You must be part of Pentia Denmark's Active Directory to access the feed. If you're not, contact <it@pentia.dk> for help. 
![Generate a PAT](/docs/images/generate-pat.png)

6. Copy & paste the PAT into the prompt from step 4.
![Enter PAT into install script](/docs/images/install-websolutionbuildscripts-with-pat.png)

7. The installation should now commence. You can delete the installation file and revoke the PAT once the installation is done.

## Updating

1. [Create a Personal Access Token](https://pentia.visualstudio.com/_details/security/tokens) (PAT) for VSTS. The token must grant read-access to packages.
2. Open an elevated PowerShell prompt.
3. Run the following commands, using your VSTS username and PAT as credentials: 
    ```powershell
    PowerShellGet\Update-Module -Name "Publish-WebSolution" -Credential (Get-Credential) -Force -Verbose
    ```

## Contributing

To release a new version of the build scripts, read the [release management guide](/docs/release-management.md).

### Style guide

#### Keywords (try, catch, foreach, switch)
lowercase (rationale: no language other than VB uses mixed case keywords?)

#### Process Block Keywords (begin, process, end, dynamicparameter)
lowercase (same reason as above)

#### Comment Help Keywords (.SYNOPSIS, .EXAMPLE, etc)
UPPERCASE

#### Package/Module Names
PascalCase

#### Class Names
PascalCase

#### Exception Names (these are just classes in PowerShell)
PascalCase

#### Global Variable Names
$PascalCase

#### Local Variable Names
$camelCase (see for example: $args and $this)

#### Function Names
PascalCase

#### Function/method arguments
PascalCase

#### Private Function Names (in modules)
PascalCase

#### Constants
$PascalCase

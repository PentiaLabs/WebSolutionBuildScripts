# Pentia Build Scripts for Sitecore Helix Solutions

Build scripts written in PowerShell, intended to publish Sitecore Helix compliant solutions. 

## Table of contents

* [Prerequisites](#prerequisites)
* [Installation](#installation)
* [Usage](#usage)
  * [Publishing a solution](#publishing-a-solution)
  * [Solution specific user settings](#solution-specific-user-settings)
  * [Sitecore and Sitecore modules - runtime dependencies](#sitecore-and-sitecore-modules---runtime-dependencies)
  * [Configuration management](#configuration-management)
* [Migration guide](#migration-guide)
* [Development tool integration](#development-tool-integration)
  * [Visual Studio Task Runner](#visual-studio-task-runner)
  * [NPM](#npm)
  * [Gulp](#gulp)
* [Setting up Continuous Integration](#setting-up-continuous-integration)
  * [Build Agent setup](#build-agent-setup)
* [Troubleshooting](#troubleshooting)
  * [Getting help](#getting-help)
  * [Build log](#build-log)
  * [Known issues](#known-issues)

## Build Status
![**CI Build**](https://pentia.visualstudio.com/_apis/public/build/definitions/6af2be26-000f-4864-ad4c-0af024086c4e/11/badge)

## Prerequisites

Register the Pentia PowerShell NuGet feed by running the following command in an elevated PowerShell prompt:

```powershell
Register-PSRepository -Name "Pentia PowerShell" -SourceLocation "http://tund/nuget/powershell/" -InstallationPolicy "Trusted" -Verbose
```

## Installation

Install the `Publish-HelixSolution` module by running the following command in an elevated PowerShell prompt:

```powershell
Install-Module -Name "Publish-HelixSolution" -Repository "Pentia PowerShell" -Force -Verbose
```

## Usage

Historically, build scripts aim to do the following:

1. Provision a clean Sitecore root. *The deprecated Pentia Builder did this by copying from Pentia's `\\buildlibrary`. The newer build scripts do this by installing "runtime dependency" NuGet packages.*
2. Copy custom code on top of it. *The deprecated Pentia Builder did this using RoboCopy. The newer build scripts use web publish.*
3. Copy custom configuration on top of it. *The deprecated Pentia Builder did this using custom NAnt tasks. The newer build scripts use [XDTs](https://msdn.microsoft.com/en-us/library/dd465326(v=vs.110).aspx).*

I.e., while the implementations change, the intentions remain the same.

### Publishing a solution

Open an elevated PowerShell prompt and run the following command in the solution root directory:

```powershell
Publish-ConfiguredHelixSolution
```

You'll be prompted for various required parameters. Once provided, these parameters will be saved in a local file for future use (see [Solution specific user settings](#solution-specific-user-settings) below).

### Solution specific user settings

To avoid having to enter the function parameters over and over for the `Publish-ConfiguredHelixSolution` cmdlet, they are stored in `<solution root path>/.pentia/user-settings.json`.

The `.pentia` directory should be added to the solution's `.gitignore` file:

```bash
.pentia/
```

### Sitecore and Sitecore modules - runtime dependencies

Runtime dependencies like Sitecore and Sitecore modules are installed as NuGet packages, and must be configured in a `runtime-dependencies.config` configuration file.
They serve the same purpose as the corresponding Pentia `\\buildlibrary` modules.

[A full guide on installing runtime dependencies can be found here.](https://sop.pentia.dk/Backend/Package-Management/NuGet/Installing-NuGet-Packages.html)

### Configuration management

Configuration management is done via [XML Document Transforms](https://msdn.microsoft.com/en-us/library/dd465326(v=vs.110).aspx), or "XDTs" for short.

Whether or not a configuration file is a XDT, is determined by the existance of the XML namespace declaration "`xmlns:xdt="http://schemas.microsoft.com/XML-Document-Transform`".

#### File placement
Configuration files and XDTs must be placed according to the following conventions:
* Configuration files and XDTs must be placed in projects of type "web project".
* Sitecore configuration include files and their XDTs must be placed in `<project root>\App_Config\[...]`.
* XDTs targeting `Web.config` must be placed directly in the project root.
* XDTs targeting `Web.config` must be named `Web.<Vendor Prefix>.<Helix Layer>(.<Project Group>).<Project Name>.<Build Configuration>.config`, e.g. `Web.Pentia.Feature.Navigation.ProdCM.config`.

#### Build Actions

The [`Build Action`](https://stackoverflow.com/questions/145752/what-are-the-various-build-action-settings-in-visual-studio-project-properties) of all `Web.<Project Name>.config` files in the solution should be set to `None`, as they only serve as a way to group configuration transform files targeting the main `Web.config` file shipped with Sitecore.

![Build Action of `Web.<Project Name>.config` convenience files](/docs/images/web.config-build-action.png)

The [Build Action](https://stackoverflow.com/questions/145752/what-are-the-various-build-action-settings-in-visual-studio-project-properties) of all XDTs, incl. those targeting `Web.config` (i.e. `Web.<Project Name>.<Build Configuration>.config`), must be set to `Content`.

![Build Action of `Web.<Project Name>.<Build Configuration>.config` XDT files](/docs/images/web.config-xdt-build-action.png)

![Build Action of Sitecore include files](/docs/images/include.config-build-action.png)

#### Examples

`[...]/Pentia.Feature.Search/code/Web.Pentia.Feature.Search.config` - this file will be ignored, because it's `Build Action` should be `None`.

`[...]/Pentia.Feature.Search/code/Web.Pentia.Feature.Search.Always.config` - this transform will be applied to `Web.config`, regardless of the build configuration (`[...].Always.config`).

`[...]/Pentia.Feature.Search/code/Web.Pentia.Feature.Search.Debug.config` - this transform will be applied to `Web.config`, if the build configuration is set to `debug` (`[...].Debug.config`).

`[...]/Pentia.Feature.Search/code/App_Config/Include/Pentia/Feature/Search/ServiceConfigurator.config` - this file will be copied to `<webroot>/App_Config/Include/[...]/ServiceConfigurator.config`, because it's `Build Action` should be `Content`.

`[...]/Pentia.Feature.Search/code/App_Config/Include/Pentia/Feature/Search/ServiceConfigurator.Debug.config` - this file will be copied to `<webroot>/App_Config/Include/[...]/ServiceConfigurator.config`, because it's `Build Action` should be `Content`. It will be applied to `<webroot\>/App_Config/Include/[...]/ServiceConfigurator.config`, if the build configuration is set to `debug` (`[...].Debug.config`).

## Migration guide

The following section is a short guide on how to migrate from Gulp-based build scripts.

### `solution-config.json`

* `configurationTransform.AlwaysApplyName` now defaults to "Always" by convention (case insensitive).
* The latest version of `MSBuild.exe` installed on the system is now automatically used for compilation.
* The `configs` section has been replaced with `./pentia/user-settings.json`. See [Solution specific user settings](#solution-specific-user-settings).

#### Before - `solution-config.json`
```json
{
    "configurationTransform": {
      "AlwaysApplyName": "always"
    },
    "msbuild": {
      "showError": true,
      "showStandardOutput": true,
      "toolsversion": 14.0,
      "verbosity": "Minimal"
    },
    "configs": [
      {
        "name": "debug",
        "rootFolder": "C:\\Websites\\HC.website",
        "websiteRoot" :"C:\\Websites\\HC.website\\Website",
        "websiteDataRoot" :"C:\\Websites\\HC.website\\Data"
      },
      {
        "name": "development",
        "rootFolder": "Websites",
        "websiteRoot" :"Websites\\Website",
        "websiteDataRoot" :"Websites\\Data"
      }
    ]
}
```

#### After - `./pentia/user-settings.json`
This file is automatically generated and updated.
```json
{
    "webrootOutputPath":  "C:\\Websites\\HC.website\\Website",
    "dataOutputPath":  "C:\\Websites\\HC.website\\Data",
    "buildConfiguration":  "debug"
}
```

### `solution-packages.json`

This file has been replaced with `runtime-dependencies.config`. See [Runtime dependencies](#runtime-dependencies).

#### Before - `solution-packages.json`
```json
{
    "packages":[
        {
            "packageName": "Sitecore.Full",
            "version": "8.2.170728",
            "location": "http://tund/nuget/FullSitecore/"  
        },
        {
            "packageName": "Sitecore.Publishing.Module",
            "version": "2.0.0",
            "location": "http://tund/nuget/sitecore/"  
        }
    ]
}
```

#### After - `runtime-dependencies.config`
```xml
<?xml version="1.0" encoding="utf-8"?>
<packages>
  <package id="Sitecore.Full" version="8.2.170728" />
  <package id="Sitecore.Publishing.Module" version="2.0.0" />
</packages>
```

### `gulpfile.js`

The scripts called from within `gulpfile.js` (e.g. `Setup-Development-Environment`, which in turn calls `delete-website`, `install-packages` etc.) have been replaced with `Publish-ConfiguredHelixSolution`. 
Hence these parts of `gulpfile.js` are largely obsolete.

#### Before - `gulpfile.js`
```javascript
var gulp = require('gulp');
var runSequence = require('run-sequence');
var publish = require('@pentia/publish-projects');
var packagemanager = require('@pentia/sitecore-package-manager');
var configTransform = require('@pentia/configuration-transformer');
var watchprojects = require('@pentia/watch-publish-projects');
var powershell = require('./node_modules/@pentia/publish-projects/modules/powershell')
var rimraf = require('rimraf');
var fs = require('fs-extra');

gulp.task('Setup-Development-Environment', function(callback) {
  runSequence(
    'delete-website',
    'install-packages',
    'publish-all-layers',
    'apply-xml-transform',
    'copy-license',
    'sync',
    callback);
});

gulp.task('sync', function(callback) {
  powershell.runAsync("./autosync-scripts/autosync-unicorn.ps1", "", callback);
});

gulp.task('setup', function(callback) {
  runSequence('Setup-Development-Environment',
    callback);
});

gulp.task('delete-website', function(callback) {
  rimraf('C:\\websites\\HC.website\\Website', callback);
});

gulp.task('copy-license', function() {
  fs.copy('\\\\buildlibrary\\library\\Sitecore License\\Pentia 8.x\\www\\Data\\pentia.license.xml', 'C:\\Websites\\HC.website\\Data\\license.xml');
});
```

#### After - `gulpfile.js`
```javascript
var gulp = require('gulp');
var runSequence = require('run-sequence');
var powershell = require('./node_modules/@pentia/publish-projects/modules/powershell');
var fs = require('fs-extra');

gulp.task('Setup-Development-Environment', function(callback) {
  runSequence('publish-helix-solution', 'copy-license', 'sync',  callback);
});

gulp.task('publish-helix-solution', function(callback) {
  powershell.runAsync("Publish-ConfiguredHelixSolution", "", callback);
});

gulp.task('copy-license', function() {
  var licenseFile = '\\\\buildlibrary\\library\\Sitecore License\\Pentia 8.x\\www\\Data\\pentia.license.xml';
  fs.copy(licenseFile, 'C:\\Websites\\HC.website\\Data\\license.xml');
});

gulp.task('sync', function(callback) {
  powershell.runAsync("./autosync-scripts/autosync-unicorn.ps1", "", callback);
});
```

## Development tool integration

### Visual Studio Task Runner

Use this [extension](https://marketplace.visualstudio.com/items?itemName=MadsKristensen.CommandTaskRunner) to enable support for PowerShell scripts via the Task Runner.

### NPM

Add a [script](https://docs.npmjs.com/misc/scripts) object to your package.json, if you're using [NPM as a build tool](https://www.keithcirkel.co.uk/how-to-use-npm-as-a-build-tool/):

```json
"scripts": {
    "publish-solution": "powershell Publish-ConfiguredHelixSolution"
},
```

Run it using:

```bash
npm run publish-solution
```

### Gulp

Using a module that looks like this: 

```javascript
/*jslint node: true */
"use strict";

function Powershell () {
}

Powershell.prototype.runAsync = function (pathToScriptFile, parameters, callback) {
  console.log("Powershell - running: " + pathToScriptFile + " " + parameters);
  var spawn = require("child_process").spawn;
  var child = spawn("powershell.exe", [pathToScriptFile, parameters]);

  child.stdout.setEncoding('utf8')
  child.stderr.setEncoding('utf8')
  
  child.stdout.on("data", function (data) {
    console.log(data);
  });

  child.stderr.on("data", function (data) {
    console.log("Error: " + data);
  });

  child.on("exit", function () {
    console.log("Powershell - done running " + pathToScriptFile);
    if (callback)
      callback();
  });

  child.stdin.end();
}

exports = module.exports = new Powershell();
```

You can use it in your `gulpfile.js` like so:

```javascript
var powershell = require("./powershell");
powershell.runAsync("C:\path\to\your\file.ps1", "-arguments here", callback);
```

## Setting up Continuous Integration

### Build Agent setup

See [Installation](#installation) instructions above - these are the same for build agents.

### Usage

1. Run `Publish-UnconfiguredHelixSolution`.
2. Specify all required parameters.
3. Have the build agent publish the solution to a relative path. This allows e.g. TeamCity to create the output in a temporary build agent working directory which is cleaned up periodically.
4. Make sure that the solution root path is set correctly. Usually the easiest way to do this is by ensuring that the build agent's working directory is the same as the VCS checkout root, as most of our solutions have the `.sln` file located in the VCS root.

Example:
```powershell
Publish-UnconfiguredHelixSolution `
-SolutionRootPath "." `
-WebrootOutputPath ".\PackagePath\Webroot" `
-DataOutputPath ".\PackagePath\Data"
```

## Troubleshooting

### Getting help

You can get help for a specific PowerShell cmdlet by running `Get-Help <cmdlet> -Full`. E.g.:

```powershell 
Get-Help Publish-ConfiguredHelixSolution -Full

Get-Help Publish-UnconfiguredHelixSolution -Full
``` 

### Build log
In order to enable verbose or debug output for the entire process, run this command in your PowerShell console:

```powershell
set "$PSDefaultParameterValues['*:Verbose'] = $True" # enables Verbose output
```

If you want to debug the build process, you can enable the debug flag:

```powershell
set "$PSDefaultParameterValues['*:Debug'] = $True" # enables Debug output
```

Piping build output to a file is done by using [redirects](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_redirection?view=powershell-5.1).

#### Piping all output to file
```powershell
Publish-ConfiguredHelixSolution *> build.txt
```

#### Piping all error output to file
```powershell
Publish-ConfiguredHelixSolution 2> errors.txt
```

#### Piping all verbose output to file
```powershell
Publish-ConfiguredHelixSolution 4> verbose.txt
```

#### Piping all verbose and error output to file
```powershell
Publish-ConfiguredHelixSolution 4>&2 verbose.txt
```

### Known issues

#### Path Too long

```powershell
Get-ChildItem : Could not find a part of the path 'D:\Projects\Solution\Website\src\Project\Frontend\code\node_modules\gulp-import-css\node_modules\gulp-util\node_modules\dateformat\node_modules\meow\node_modules\read-pkg-up\node_modules\read-pkg\node_modules\load-json-file\node_modules\pinkie-promise\node_modules'.
```

This is caused by the `Get-ChildItem` call, when a path in the solution exceeds the windows NTFS path limitation of 255 characters. Reduce the path length to solve the issue.

# Pentia Build Scripts for Sitecore Helix Solutions

In the following, all commands expect to be run from an elevated PowerShell prompt.

## Build Status
![**CI Build**](https://pentia.visualstudio.com/_apis/public/build/definitions/6af2be26-000f-4864-ad4c-0af024086c4e/11/badge)

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

### Publishing a solution

Run the following in the solution root directory:

```powershell
Publish-HelixSolution
```

You'll be prompted for various required parameters. Once provided, these parameters will be saved in a local file for future use.

#### Solution specific user settings

To avoid having to enter function parameters over and over, the parameters for `Publish-HelixSolution` are stored in a local file.

It's placed here: `$SolutionRootPath/.pentia/user-settings.json`.

The `.pentia` directory should be added to the solution's `.gitignore` file:

```bash
.pentia/
```

### Runtime dependencies

Runtime dependencies like Sitecore and Sitecore modules are installed as so called "runtime dependencies", and must be configured in a `runtime-dependencies.config` file. 

[A full guide on installing runtime dependencies can be found here.](https://sop.pentia.dk/Backend/Package-Management/NuGet/Installing-NuGet-Packages.html)

### Web.config and publishing

The "Build Action" of all `web.config` files in the solution should be set to "None", to prevent them from being copied to the web publish output directory. This ensures that the default `web.config` shipped with Sitecore is not overwritten.

The only reason the `web.config` is placed in the Visual Studio projects, is to help with grouping the configuration transform files, and to enable preview of configuration transforms.

## Integration

### Visual Studio Task Runner

Use this [extension](https://marketplace.visualstudio.com/items?itemName=MadsKristensen.CommandTaskRunner) to enable support for PowerShell scripts via the Task Runner.

### NPM

Add a [script](https://docs.npmjs.com/misc/scripts) object to your package.json, if you're using [NPM as a build tool](https://www.keithcirkel.co.uk/how-to-use-npm-as-a-build-tool/):

```json
"scripts": {
    "publish-solution": "powershell Publish-HelixSolution"
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

## Build Agent setup

### Installation

See Installation instructions above - these are the same for build agents.

### Usage

1. Run `Publish-HelixSolution` with the `-IgnoreUserSettings` switch. This avoids writing user settings to disk.
2. Specify all required parameters (e.g. `$SolutionRootPath`, `WebrootOutputPath`).
3. Have the build agent publish the solution to a relative path. This allows e.g. TeamCity to create the output in a temporary build agent working directory which is cleaned up periodically.
4. Make sure that the solution root path is set correctly. Usually the easiest way to do this is by ensuring that the build agent's working directory is the same as the VCS checkout root, as most of our solutions have the `.sln` file located in the VCS root.

Example:
```powershell
Publish-HelixSolution -IgnoreUserSettings `
-SolutionRootPath "." `
-WebrootOutputPath ".\PackagePath\Webroot" `
-DataOutputPath ".\PackagePath\Data" `
-BuildConfiguration "Debug"
```

## Troubleshooting

### Getting help

```powershell 
Get-Help Publish-HelixSolution -Full
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
Publish-HelixSolution *> build.txt
```

#### Piping all error output to file
```powershell
Publish-HelixSolution 2> errors.txt
```

#### Piping all verbose output to file
```powershell
Publish-HelixSolution 4> verbose.txt
```

#### Piping all verbose and error output to file
```powershell
Publish-HelixSolution 4>&2 verbose.txt
```

## Known errors

### Path Too long

```powershell
Get-ChildItem : Could not find a part of the path 'D:\Projects\Solution\Website\src\Project\Frontend\code\node_modules\gulp-import-css\node_modules\gulp-util\node_modules\dateformat\node_modules\meow\node_modules\read-pkg-up\node_modules\read-pkg\node_modules\load-json-file\node_modules\pinkie-promise\node_modules'.
```

This is caused by the `Get-ChildItem` call, when a path in the solution exceeds the windows NTFS path limitation of 255 characters. Reduce the path length to solve the issue.

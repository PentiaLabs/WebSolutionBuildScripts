## Usage

Historically, build scripts aim to do the following:

1. Provision a clean Sitecore root. *The deprecated Pentia Builder did this by copying from Pentia's `\\buildlibrary`. The newer build scripts do this by installing "runtime dependency" NuGet packages.*
2. Copy custom code on top of it. *The deprecated Pentia Builder did this using RoboCopy. The newer build scripts use web publish.*
3. Copy custom configuration on top of it. *The deprecated Pentia Builder did this using custom NAnt tasks. The newer build scripts use [XDTs](https://msdn.microsoft.com/en-us/library/dd465326(v=vs.110).aspx).*

I.e., while the implementations change, the intentions remain the same.

### Publishing a solution

Open an elevated PowerShell prompt and run the following command in the solution root directory:

```powershell
Publish-ConfiguredWebSolution
```

You'll be prompted for various required parameters. Once provided, these parameters will be saved in a local file for future use (see [Solution specific user settings](#solution-specific-user-settings) below).

### Publishing only code

**Prerequisite:** `Publish-ConfiguredWebSolution` has to be run at least once before publishing individual layers or projects.

To publish only code, open an elevated PowerShell prompt and run the following command in the solution root directory:

```powershell
Get-WebProject | Publish-UnconfiguredWebProject -OutputPath (Get-UserSettings).webrootOutputPath
```

### Publishing one or more projects

**Prerequisite:** `Publish-ConfiguredWebSolution` has to be run at least once before publishing individual layers or projects.

Open an elevated PowerShell prompt and run the following command in e.g. a Sitecore Helix-layer directory or project directory:

```powershell
Get-WebProject | Publish-ConfiguredWebProject
```

You'll be prompted for various required parameters. Once provided, these parameters will be saved in a local file for future use (see [Solution specific user settings](#solution-specific-user-settings) below).

#### Caveats 
XDTs are applied after the publish. This means that e.g. insert-statements are executed more than once. 

This isn't a problem for config files which are part of the web project, because they'll be overwritten with a fresh, unmodified version as part of the publish. 

But it's an issue when an XDT targets e.g. `Web.config`, or a similar Sitecore standard config file, which isn't part of the web project being published, because those files won't be overwritten with fresh versions.

To avoid this, don't use "Insert", but rather "InsertIfMissing" and similar idempotent XDT constructs.

### Solution specific user settings

To avoid having to enter the function parameters over and over for the `Publish-ConfiguredWebSolution` cmdlet, they are stored in `<solution root path>/.pentia/user-settings.json`.

The `.pentia` directory should be added to the solution's `.gitignore` file:

```bash
.pentia/
```

### Adding Sitecore and Sitecore modules

Runtime dependencies like Sitecore and Sitecore modules are installed as NuGet packages, and must be configured in a `packages.config` configuration file.
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

#### SlowCheetah NuGet package

**Make sure SlowCheetah is not installed in any projects!**

It's important that SlowCheetah is **not** installed as a NuGet package in any of the projects in the solution, as it will add a build target which is triggered each time the solution is built, including during publish. 

This will usually cause the `Debug` XDT to be applied, even when another `BuildConfiguration` is specified from the command line when calling `Publish-ConfiguredWebSolution` or `Publish-UnconfiguredWebSolution`.

![SlowCheetah NuGet package](/docs/images/slow-cheetah-nuget-package.png)

![SlowCheetah build target in csproj](/docs/images/slow-cheetah-build-target.png)

### Build script integration

Shown below is a build script example which does the following:

1. Restore NuGet packages using a [globally available `NuGet.exe`](https://docs.microsoft.com/en-us/nuget/tools/nuget-exe-cli-reference).
2. Compile the solution using the latest version of `MSBuild.exe` available on the machine.
3. Publish the solution to a designated webroot and data folder - the user is prompted for these values once, which are then stored as [solution specific user settings](#solution-specific-user-settings).
4. Copy a Sitecore license from Pentia's buildlibrary NAS to the website's data folder.

The script should be placed in the same directory as the solution's `.sln` file.

```powershell
Function RestoreNuGetPackages {
    & "nuget.exe" "restore" "$PSScriptRoot" *>> $script:buildLogFilePath
    if ($LASTEXITCODE -eq 0) {
        Write-Host "NuGet packages restored successfully. Build log written to '$script:buildLogFilePath'"
    }
    else {
        Throw "NuGet package restore failed. Build log written to '$script:buildLogFilePath'"
    }
}

Function BuildSolution {    
    $msBuild = Get-MSBuild
    & "$msBuild" "$PSScriptRoot" *>> $script:buildLogFilePath
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Solution compilation succeeded. Build log written to '$script:buildLogFilePath'"
    }
    else {
        Throw "Solution compilation failed. Build log written to '$script:buildLogFilePath'"
    }
}

Try
{
    Import-Module Publish-WebSolution -MinimumVersion "0.5.1" -Force -ErrorAction Stop

    $buildLogFilePath = "$PSScriptRoot\.pentia\build-$(Get-Date -Format "yyyy-MM-dd.HH.mm.ss").log"

    # Build and publish solution
    RestoreNuGetPackages
    BuildSolution
    Publish-ConfiguredWebSolution -SolutionRootPath $PSScriptRoot | Out-Null

    # Load user settings
    $settings = Get-UserSettings -SolutionRootPath $PSScriptRoot

    # Copy Pentia Sitecore license
    Copy-Item "\\buildlibrary.hq.pentia.dk\library\Sitecore License\Pentia 8.x\www\Data\pentia.license.xml" "$($settings.dataOutputPath)\license.xml" -ErrorAction Stop

    Write-Host "Done."

} Catch {
    Write-Error -Exception $_.Exception
    Exit 1
}
```

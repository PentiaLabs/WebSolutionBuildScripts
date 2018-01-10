## Pseudo-sequence diagram

1. Run a build script trigger. This could be NPM, Gulp, PowerShell, a .bat-file, cmd.exe, NAnt, Visual Studio etc.

2. Run "complimentary pre-publish scripts", such as setting up an IIS instance, databases etc.

3. Invoke `Publish-ConfiguredWebSolution`.

    1. Invoke `Get-UserSettings`.
        1. Load "webroot" and "data folder" output paths, and the desired build configuration, from `<solution root>/.pentia/user-settings.json`.
        2. Prompt the user if any settings are null or empty.
        
    2. Invoke `Publish-UnconfiguredWebSolution`.
        1. Invoke `Remove-WebrootOutputPath` to delete any existing files.
        2. Invoke `Publish-AllRuntimeDependencies`.
            1. Read `<solution root>/runtime-dependencies.config`.
            2. If a package can't be found in the local package cache, install it. *Most of our Sitecore packages are found in the feed [http://tund/nuget/NuGet/](http://tund/feeds/NuGet). Packages are loaded and installed using standard [PowerShell PackageManagement](https://docs.microsoft.com/en-us/powershell/module/packagemanagement/?view=powershell-5.1).*
            3. Unpack all packages to the "webroot" and "data folder" output paths, in the order read from the config file.
        
        
        3. Invoke `Publish-AllWebProjects`.
            1. Get all web projects found under the solution root path.
            2. Get the `MSBuild.exe` path. *The path is found using [hMSBuild.bat](https://github.com/3F/hMSBuild).*
            3. Run `MSBuild.exe /target:WebPublish  [...]` for each project.

    3. Invoke `Set-WebSolutionConfiguration`.
        1. Get all XDTs for the build configuration "Always" and the current build configuration, found under the solution root path.
        2. Apply them to their respective configuration files under the webroot output path.
        3. Delete all XDTs from the webroot output path.

4. Run "complimentary post-publish scripts", such as warming up the website etc.

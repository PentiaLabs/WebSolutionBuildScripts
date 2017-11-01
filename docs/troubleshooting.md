## Troubleshooting

### Getting help for PowerShell commands

You can get help for a specific PowerShell cmdlet by running `Get-Help <cmdlet> -Full`. E.g.:

```powershell 
Get-Help Publish-ConfiguredHelixSolution -Full

Get-Help Publish-UnconfiguredHelixSolution -Full
``` 

### Debugging project publishing

Under the covers, the build scripts use the ["Publish to Folder"](https://www.google.dk/search?q=msbuild+publish+to+folder) feature of `MSBuild.exe`.

This means that for the scripts to succeed, an important criteria is that all web projects in the solution must be publishable.

You can check whether or not the criteria is fulfilled by opening the solution in Visual Studio, and publishing each web project in turn.

![Publish project](/docs/images/publish-to-folder.png)

#### Missing files

Common causes:
* The solution hasn't been compiled (with the underlying issue possibly being that NuGet packages haven't been restored).
* A project contains one or more references to files which are missing from the filesyste, (most often someone has deleted them from the filesystem, but not removed them from the Visual Studio solution).

E.g.:

```
CopyAllFilesToSingleFolderForPackage:
  [...]
  Copying bin\Debug\Netmester.Util.pdb to obj\Debug\Package\PackageTmp\bin\Debug\Netmester.Util.pdb.
D:\VisualStudio2017\MSBuild\Microsoft\VisualStudio\v15.0\Web\Microsoft.Web.Publishing.targets(3007,5): error : Copying file bin\Debug\Netmester.Util.pdb to obj\Debug\Package\PackageTmp\bin\Debug\Netmester.Util.pdb failed. Could not find file 'bin\Debug\Netmester.Util.pdb
Done Building Project "D:\Projects\FOF\src\Project\Legacy\FOF.Tests\FOF.Tests.csproj" (WebPublish target(s)) -- FAILED.
Build FAILED.
```

![Missing files](/docs/images/missing-files.png)

### Build log
In order to enable verbose output for the entire process, run this command in your PowerShell console:

```powershell
$VerbosePreference = "Continue"
```

Then run the `Publish-ConfiguredHelixSolution` or `Publish-UnconfiguredHelixSolution` commands with the `-Verbose` flag.

![Verbose cmdlet output](/docs/images/verbose-output.png)

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

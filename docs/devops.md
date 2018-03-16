## Setting up Continuous Integration

A typical CI build should do the following:

1. Restore NuGet packages using `NuGet.exe`.
2. Compile the solution using `MSBuild.exe`.
3. Run `Publish-ConfiguredWebSolution`, providing all required parameters.
    * Have the build agent publish the solution to a subdirectory. This allows e.g. TeamCity to create the output in a temporary build agent working directory which is cleaned up periodically.
    * Make sure that the solution root path is set correctly. Usually the easiest way to do this is by ensuring that the build agent's working directory is the same as the VCS checkout root, as most of our solutions have the `.sln` file located in the VCS root.

### TeamCity CI

Example:

```powershell
try {
  Import-Module "Pentia.Publish-WebSolution" -Force -ErrorAction "Stop"
  $VerbosePreference = "Continue" 
  Publish-ConfiguredWebSolution -SolutionRootPath "$PWD" -WebrootOutputPath "$PWD\output\Webroot" -DataOutputPath "$PWD\output\Data" -BuildConfiguration "Debug" -Verbose
} catch {
  Write-Error -Exception $_.Exception
  exit 1
} finally {
  $VerbosePreference = "SilentlyContinue"
}
```

*[`$PWD`](https://www.google.dk/search?q=PowerShell+%24PWD) is the absolute path to the current directory.*

![TeamCity CI configuration example](/docs/images/team-city-ci-example.png)

## Setting up Continuous Delivery

This is basically the same as for [CI](#setting-up-continuous-integration) described earlier:

1. *Same*
2. *Same*
3. Run `Publish-UnconfiguredWebSolution`, providing all required parameters.
    * *Same*
    * *Same*
4. Create a package based on the output, using `NuGet.exe pack [...].nuspec`.
5. Push the package to e.g. Octopus Deploy.

### TeamCity CD

```powershell
try {
  Import-Module "Pentia.Publish-WebSolution" -Force -ErrorAction "Stop"  
  Publish-UnconfiguredWebSolution -SolutionRootPath "$PWD" -WebrootOutputPath "$PWD\Output\Webroot" -DataOutputPath "$PWD\Output\Data"
} catch {
  Write-Error -Exception $_.Exception
  exit 1
}
```

![TeamCity CD configuration example](/docs/images/team-city-cd-example.png)

### Octopus Deploy

The [guidelines reg. configuration management](/docs/usage.md#configuration-management) dictate the way Octopus Deploy should apply additional XML Document Tranforms:

1. Ensure the solution complies to the [configuration management guidelines](/docs/usage.md#configuration-management).
2. Enable the "Configuration Transforms" feature in Octopus.
3. Enable the "Automatically run configuration transform files" option.
4. Add the following as additional transforms (this ensures that e.g. `web.Pentia.Foundation.Search.Always.config` and `web.Pentia.Foundation.Search.Debug.config` is applied to `web.config`): 
    * `App_Config/**/*.Always.config => *.config`
    * `web.*.Always.config => web.config`
    * `web.*.#{Octopus.Environment.Name}.config => web.config`

5. Add any additional transforms as required by the solution. *E.g. `web*.#{Octopus.Machine.Name}.config => web.config` - see the official documentation on [Octopus Deploy System Variables](https://octopus.com/docs/deploying-applications/variables/system-variables) for inspiration on how to split up configuration differences.*

![Octopus Deploy enabled features](/docs/images/octopus-deploy-enabled-features.png)

![Octopus Deploy additional transforms](/docs/images/octopus-deploy-additional-transforms.png)

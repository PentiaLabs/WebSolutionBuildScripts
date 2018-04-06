<#
.SYNOPSIS
Used to publish a web solution to disk for a specific build configuration.

.DESCRIPTION
Used to publish a web solution to disk, applying and subsequently removing all relevant XDTs. 
The steps it runs through are:

1. Delete $WebrootOutputPath.
2. Publish runtime dependencies to $WebrootOutputPath.
3. Publish all web projects to $WebrootOutputPath, on top of the published runtime dependencies.
4. Apply all XML Document Transform files found in $WebrootOutputPath.
5. Delete all XML Document Transform files found in $WebrootOutputPath.

.PARAMETER SolutionRootPath
This is the absolute path to the root of your solution, usually the same directory as your ".sln"-file is placed. 
Uses the current working directory ($PWD) as a fallback.

.PARAMETER WebrootOutputPath
The path to where you want your webroot to be published. E.g. "D:\Websites\SolutionSite\www".

.PARAMETER DataOutputPath
This is where the Sitecore data folder will be placed. E.g. "D:\Websites\SolutionSite\Data".

.PARAMETER BuildConfiguration
The build configuration that will be passed to "MSBuild.exe".

.PARAMETER WebProjects
The list of webprojects to publish - will call Get-WebProject if empty

.PARAMETER PublishParallelly
If set, MSBuild will use all available nodes for publishing multiple projects in parallel; otherwise, MSBuild will only use one node for publishing.

.EXAMPLE
Publish-ConfiguredWebSolution -SolutionRootPath "D:\Project\Solution" -WebrootOutputPath "D:\Websites\SolutionSite\www" -DataOutputPath "D:\Websites\SolutionSite\Data" -BuildConfiguration "Debug"
Publishes the solution placed at "D:\Project\Solution" to "D:\Websites\SolutionSite\www" using the "Debug" build configuration, and saves the provided parameters to "D:\Project\Solution\.pentia\user-settings.json" for future use.

Publish-ConfiguredWebSolution
Publishes the solution using the saved user settings found in "<current directory>\.pentia\user-settings.json", and prompts the user for any missing settings.

.NOTES
Most large scale solutions will end up with file lock issues when using the "-PublishParallelly" switch, which is why it's off by default.

In order to enable verbose or debug output for the entire command, run the following in your current PowerShell session (your "PowerShell command prompt"):
    $VerbosePreference = "Continue"
    $DebugPreference = "Continue"
#> 
function Publish-ConfiguredWebSolution {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$SolutionRootPath,

        [Parameter(Mandatory = $false)]
        [string]$WebrootOutputPath,

        [Parameter(Mandatory = $false)]
        [string]$DataOutputPath,

        [Parameter(Mandatory = $false)]
        [string]$BuildConfiguration,

        [Parameter(Mandatory = $false)]
        [string[]]$WebProjects,

        [switch]$PublishParallelly
    )

    $SolutionRootPath = Get-SolutionRootPath -SolutionRootPath $SolutionRootPath		
    $parameters = Get-MergedParametersAndUserSettings -SolutionRootPath $SolutionRootPath -WebrootOutputPath $WebrootOutputPath -DataOutputPath $DataOutputPath -BuildConfiguration $BuildConfiguration
    $WebrootOutputPath = $parameters.webrootOutputPath
    $DataOutputPath = $parameters.dataOutputPath
    $BuildConfiguration = $parameters.buildConfiguration

    Publish-UnconfiguredWebSolution -SolutionRootPath $SolutionRootPath -WebrootOutputPath $WebrootOutputPath -DataOutputPath $DataOutputPath -WebProjects $WebProjects -PublishParallelly:$PublishParallelly
    if (Test-Path $WebrootOutputPath) {
        Set-WebSolutionConfiguration -WebrootOutputPath $WebrootOutputPath -BuildConfiguration $BuildConfiguration
    }
    else {
        Write-Warning "'$WebrootOutputPath' not found. Skipping solution configuration."
    }
}

function Get-SolutionRootPath {
    param (
        [Parameter(Mandatory = $false)]
        [string]$SolutionRootPath
    )

    if ([string]::IsNullOrWhiteSpace($SolutionRootPath)) {
        Write-Verbose "`$SolutionRootPath not set. Using '$PWD'."
        $SolutionRootPath = "$PWD"
    }
    if (-not ([System.IO.Path]::IsPathRooted($SolutionRootPath))) {
        $SolutionRootPath = [System.IO.Path]::Combine($PWD, $SolutionRootPath)
        Write-Verbose "`$SolutionRootPath not rooted. Using '$SolutionRootPath'."
    }
    $SolutionRootPath
}

<#
.SYNOPSIS
Publishes a web solution, without applying any XDTs.

.DESCRIPTION
Used to publish a Sitecore web solution to disk, without applying or removing any XDTs. 
The steps it runs through are:

1. Delete $WebrootOutputPath.
2. Publish runtime dependencies to $WebrootOutputPath.
3. Publish all web projects to $WebrootOutputPath, on top of the published runtime dependencies.

.PARAMETER SolutionRootPath
This is the absolute path to the root of your solution, usually the same directory as your ".sln"-file is placed. 
Uses the current working directory ($PWD) as a fallback.

.PARAMETER WebrootOutputPath
The path to where you want your webroot to be published. E.g. "D:\Websites\SolutionSite\www".

.PARAMETER DataOutputPath
This is where the Sitecore data folder will be placed. E.g. "D:\Websites\SolutionSite\Data".

.PARAMETER WebProjects
The list of webprojects to publish - will call Get-WebProject if empty

.PARAMETER PublishParallelly
If set, MSBuild will use all available nodes for publishing multiple projects in parallel; otherwise, MSBuild will only use one node for publishing.

.EXAMPLE
Publish-UnconfiguredWebSolution -SolutionRootPath "D:\Project\Solution" -WebrootOutputPath "D:\Websites\SolutionSite\www" -DataOutputPath "D:\Websites\SolutionSite\Data"
Publishes the solution placed at "D:\Project\Solution" to "D:\Websites\SolutionSite\www".

.NOTES
Most large scale solutions will end up with file lock issues when using the "-PublishParallelly" switch, which is why it's off by default.

In order to enable verbose or debug output for the entire command, run the following in your current PowerShell session (your "PowerShell command prompt"):
    $VerbosePreference = "Continue"
    $DebugPreference = "Continue"
#>
function Publish-UnconfiguredWebSolution {
    [CmdletBinding(SupportsShouldProcess = $true)]
    param (
        [Parameter(Mandatory = $false)]
        [string]$SolutionRootPath,
		
        [Parameter(Mandatory = $true)]
        [string]$WebrootOutputPath,
		
        [Parameter(Mandatory = $true)]
        [string]$DataOutputPath,

        [Parameter(Mandatory = $false)]
        [string[]]$WebProjects,

        [switch]$PublishParallelly
    )

    if (-not ([System.IO.Path]::IsPathRooted($WebrootOutputPath))) {
        $WebrootOutputPath = [System.IO.Path]::Combine($PWD, $WebrootOutputPath)
    }
    
    if (-not ([System.IO.Path]::IsPathRooted($DataOutputPath))) {
        $DataOutputPath = [System.IO.Path]::Combine($PWD, $DataOutputPath)
    }

    $SolutionRootPath = Get-SolutionRootPath -SolutionRootPath $SolutionRootPath

    Write-Progress -Activity "Publishing web solution" -Status "Cleaning webroot output path"
    Remove-WebrootOutputPath -WebrootOutputPath $WebrootOutputPath

    Write-Progress -Activity "Publishing web solution" -Status "Publishing runtime dependency packages"    
    Publish-AllRuntimeDependencies -SolutionRootPath $SolutionRootPath -WebrootOutputPath $WebrootOutputPath -DataOutputPath $DataOutputPath

    Write-Progress -Activity "Publishing web solution" -Status "Publishing web projects"
    Publish-MultipleWebProjects -SolutionRootPath $SolutionRootPath -WebrootOutputPath $WebrootOutputPath -WebProjects $WebProjects -PublishParallelly:$PublishParallelly
	
    Write-Progress -Activity "Publishing web solution" -Completed -Status "Done."
}

function Remove-WebrootOutputPath {
    [CmdletBinding(SupportsShouldProcess = $true)]
    param (
        [Parameter(Mandatory = $true)]
        [string]$WebrootOutputPath
    )
    if (-not $pscmdlet.ShouldProcess($WebrootOutputPath, "Delete the directory and all contents")) {
        return
    }
    if (Test-Path $WebrootOutputPath -PathType Container) {
        Write-Verbose "Deleting '$WebrootOutputPath' and all contents."
        Remove-Item -Path $WebrootOutputPath -Recurse -Force
    }
}

<#
.SYNOPSIS
Publishes the contents of all runtime dependency packages to the specified directores.

.DESCRIPTION
Publishes the contents of all runtime dependency packages to the specified directores, by looking for a "packages.config" to install packages using NuGet, 
or a "runtime-dependencies.config" to install packages using the PowerShell Package Management framework (deprecated).


.PARAMETER SolutionRootPath
This is the absolute path to the root of your solution, usually the same directory as your ".sln"-file is placed. 
Uses the current working directory ($PWD) as a fallback.

.PARAMETER WebrootOutputPath
The path to where you want your webroot to be published. E.g. "D:\Websites\SolutionSite\www".

.PARAMETER DataOutputPath
This is where the Sitecore data folder will be placed. E.g. "D:\Websites\SolutionSite\Data".

.EXAMPLE
Publish-AllRuntimeDependencies -SolutionRootPath "D:\Projects\Abbr\Solution\" -WebrootOutputPath "D:\Websites\SolutionSite\www". -DataOutputPath "D:\Websites\SolutionSite\Data"
Publishes all runtime packages defined in "D:\Projects\Abbr\Solution\packages.config" and "D:\Projects\Abbr\Solution\runtime-dependencies.config" to the specified output paths.
#>
function Publish-AllRuntimeDependencies {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$SolutionRootPath,

        [Parameter(Mandatory = $true)]
        [string]$WebrootOutputPath,

        [Parameter(Mandatory = $true)]
        [string]$DataOutputPath
    )
    if (-not [System.IO.Path]::IsPathRooted($SolutionRootPath)) {
        $SolutionRootPath = [System.IO.Path]::Combine($PWD, $SolutionRootPath)
    }
    Publish-PackagesUsingPackageManagement -SolutionRootPath $SolutionRootPath -WebrootOutputPath $WebrootOutputPath -DataOutputPath $DataOutputPath
    Publish-PackagesUsingNuGet -SolutionRootPath $SolutionRootPath -WebrootOutputPath $WebrootOutputPath -DataOutputPath $DataOutputPath
}

function Publish-PackagesUsingPackageManagement {
    param (
        [Parameter(Mandatory = $true)]
        [string]$SolutionRootPath,

        [Parameter(Mandatory = $true)]
        [string]$WebrootOutputPath,

        [Parameter(Mandatory = $true)]
        [string]$DataOutputPath
    )
    $runtimeDependencyConfigurationFileName = "runtime-dependencies.config"
    $runtimeDependencyConfigurationFilePath = [System.IO.Path]::Combine($SolutionRootPath, $runtimeDependencyConfigurationFileName)
    if (-not (Test-Path $runtimeDependencyConfigurationFilePath -PathType Leaf)) {
        Write-Verbose "'$runtimeDependencyConfigurationFilePath' not found - skipping runtime package installation using Package Management."
        return
    }
    Write-Warning "Usage of 'runtime-dependencies.config' is deprecated. Use regular 'packages.config' and 'NuGet.config' files instead."
    $runtimeDependencies = Get-RuntimeDependencyPackage -ConfigurationFilePath $RuntimeDependencyConfigurationFilePath
    for ($i = 0; $i -lt $runtimeDependencies.Count; $i++) {
        $runtimeDependency = $runtimeDependencies[$i]
        Write-Progress -Activity "Publishing web solution" -PercentComplete ($i / $runtimeDependencies.Count * 100) -Status "Publishing runtime dependency packages" -CurrentOperation "$($runtimeDependency.id) $($runtimeDependency.version)"
        Publish-RuntimeDependencyPackage -WebrootOutputPath $WebrootOutputPath -DataOutputPath $DataOutputPath -PackageName $runtimeDependency.id -PackageVersion $runtimeDependency.version -PackageSource $runtimeDependency.source
    }
}

function Publish-PackagesUsingNuGet {
    param (
        [Parameter(Mandatory = $true)]
        [string]$SolutionRootPath,

        [Parameter(Mandatory = $true)]
        [string]$WebrootOutputPath,

        [Parameter(Mandatory = $true)]
        [string]$DataOutputPath
    )
    $nugetPackageFileName = "packages.config"
    $nugetPackageFilePath = [System.IO.Path]::Combine($SolutionRootPath, $nugetPackageFileName)
    if (-not(Test-Path $nugetPackageFilePath -PathType Leaf)) {
        Write-Verbose "'$nugetPackageFileName' not found - skipping runtime package installation using NuGet."
        return
    }
    Write-Progress -Activity "Publishing web solution" -Status "Publishing runtime dependency packages" -CurrentOperation "Installing packages in parallel"
    Install-NuGetExe
    $packageOutputDirectory = [System.IO.Path]::Combine($env:APPDATA, ".pentia")
    Install-NuGetPackage -PackageConfigFile $nugetPackageFilePath -SolutionDirectory $SolutionRootPath -OutputDirectory $packageOutputDirectory
    [xml]$nugetPackageFileXml = Get-Content $nugetPackageFilePath
    $runtimeDependencies = @($nugetPackageFileXml | Select-Xml -XPath "/packages/package" | Select-Object -ExpandProperty "Node")
    for ($i = 0; $i -lt $runtimeDependencies.Count; $i++) {
        $runtimeDependency = $runtimeDependencies[$i]
        Write-Progress -Activity "Publishing web solution" -PercentComplete ($i / $runtimeDependencies.Count * 100) -Status "Publishing runtime dependency packages" -CurrentOperation "Copying package contents sequentially"
        Publish-NuGetPackage -PackageName $runtimeDependency.id -PackageVersion $runtimeDependency.version -PackageOutputPath $packageOutputDirectory -WebrootOutputPath $WebrootOutputPath -DataOutputPath $DataOutputPath
    }
}

function Publish-MultipleWebProjects {
    param (
        [Parameter(Mandatory = $true)]
        [string]$SolutionRootPath,
    
        [Parameter(Mandatory = $true)]
        [string]$WebrootOutputPath,

        [Parameter(Mandatory = $false)]
        [string[]]$WebProjects,

        [switch]$PublishParallelly
    )
    $msBuildExecutablePath = Get-MSBuild

    if ($WebProjects.Count -lt 1) {
        $WebProjects = Get-WebProject -SolutionRootPath $SolutionRootPath
    }
    if ($WebProjects.Count -lt 1) {
        Write-Verbose "No web projects found - skipping web project publishing."
        return
    }
    Write-Progress -Activity "Publishing web solution" -Status "Publishing web projects" -CurrentOperation "Creating web publish project"
    $projectFilePath = New-WebPublishProject -SolutionRootPath $SolutionRootPath -WebProjects $WebProjects -PublishParallelly:$PublishParallelly
    Write-Progress -Activity "Publishing web solution" -Status "Publishing web projects" -CurrentOperation "Publishing all web projects referenced by '$projectFilePath'"
    Publish-WebProject -WebProjectFilePath $projectFilePath  -OutputPath $WebrootOutputPath -MSBuildExecutablePath $msBuildExecutablePath
}

<#
.SYNOPSIS
Creates a .csproj-file which references all projects in "WebProjects".

.DESCRIPTION
Creates a .csproj-file which references all projects in "WebProjects".
Publishing this project will trigger the WebPublish target for all referenced projects. 
This gives a significant performance boost compared to publishing individual projects sequentially.

.PARAMETER SolutionRootPath
The solution root path.

.PARAMETER WebProjects
A list of web projects to publish.

.PARAMETER PublishParallelly
If set, MSBuild will use all available nodes for publishing multiple projects in parallel; otherwise, MSBuild will only use one node for publishing.
#>
function New-WebPublishProject {
    [CmdletBinding(SupportsShouldProcess = $true)]
    [OutputType([string])]
    param (
        [Parameter(Mandatory = $true)]
        [string]$SolutionRootPath,
        
        [Parameter(Mandatory = $true)]
        [string[]]$WebProjects,

        [switch]$PublishParallelly
    )
    $webProjectFilePaths = @()
    foreach ($webProject in $WebProjects) {
        if ([System.IO.Path]::IsPathRooted($webProject)) {
            $webProjectFilePaths += $webProject
        }
        else {
            $webProjectFilePaths += [System.IO.Path]::Combine($SolutionRootPath, $webProject)
        }
    }
    $formattedWebProjectPaths = $webProjectFilePaths -join ";"
    [xml]$webPublishProject = "<!-- This file is (re-)generated automatically --><Project xmlns=""http://schemas.microsoft.com/developer/msbuild/2003""><ItemGroup><WebProjects Include=""$formattedWebProjectPaths"" /></ItemGroup><Target Name=""WebPublish""><MSBuild Projects=""@(WebProjects)"" Targets=""WebPublish"" BuildInParallel=""$PublishParallelly"" /></Target></Project>"
    $webPublishProjectDirectory = [System.IO.Path]::Combine($SolutionRootPath, ".pentia")
    if (-not (Test-Path $webPublishProjectDirectory) -and $pscmdlet.ShouldProcess($webPublishProjectDirectory, "Create misc. directory")) {
        $webPublishProjectDirectory = New-Item $webPublishProjectDirectory -ItemType Directory
    }
    $projectFilePath = [System.IO.Path]::Combine($webPublishProjectDirectory, "WebPublish.csproj")
    if ($pscmdlet.ShouldProcess($projectFilePath, "Create .csproj-file")) {
        $webPublishProject.Save($projectFilePath)
    }
    $projectFilePath
}

<#
.SYNOPSIS
Applies XDTs to a set of configuration files, then deletes the XDTs.

.DESCRIPTION
Applies all XML Document Transforms found in $WebrootOutputPath to their configuration file counterparts.

.PARAMETER WebrootOutputPath
The path to the webroot. E.g. "D:\Websites\SolutionSite\www".

.PARAMETER BuildConfiguration
The build configuration that will be used to select which transforms to apply.

.EXAMPLE
Set-WebSolutionConfiguration -WebrootOutputPath "D:\Websites\SolutionSite\www" -BuildConfiguration "Debug"
Searchse for all "*.Debug.config" XDTs in the "D:\Websites\SolutionSite\www" directory, and applies them to their configuration file counterparts.

.NOTES
In order to enable verbose or debug output for the entire command, run the following in your current PowerShell session (your "PowerShell command prompt"):
    $VerbosePreference = "Continue"
    $DebugPreference = "Continue"
    
We'd like to call this function "Configure-WebSolution", but according 
to https://msdn.microsoft.com/en-us/library/ms714428(v=vs.85).aspx the "Set" verb should be used instead.
#>
function Set-WebSolutionConfiguration {
    [CmdletBinding(SupportsShouldProcess = $true)]
    param (
        [Parameter(Mandatory = $true)]
        [string]$WebrootOutputPath,
		
        [Parameter(Mandatory = $true)]
        [string]$BuildConfiguration
    )
	
    if (-not (Test-Path $WebrootOutputPath)) {
        throw "Path '$WebrootOutputPath' not found."
    }
    
    $WebrootOutputPath = Resolve-Path $WebrootOutputPath

    Write-Progress -Activity "Configuring web solution" -Status "Applying XML Document Transforms"
    if ($pscmdlet.ShouldProcess($WebrootOutputPath, "Apply XML Document Transforms")) {
        Invoke-AllConfigurationTransforms -SolutionOrProjectRootPath $WebrootOutputPath -WebrootOutputPath $WebrootOutputPath -BuildConfiguration $BuildConfiguration
    }

    Write-Progress -Activity "Configuring web solution" -Status "Removing XML Document Transform files"
    if ($pscmdlet.ShouldProcess($WebrootOutputPath, "Remove XML Document Transform files")) {
        Get-ConfigurationTransformFile -SolutionRootPath $WebrootOutputPath | ForEach-Object { Remove-Item -Path $_ }
    }

    Write-Progress -Activity "Configuring web solution" -Status "Done." -Completed
}

Export-ModuleMember -Function Publish-ConfiguredWebSolution, Publish-UnconfiguredWebSolution, Set-WebSolutionConfiguration, Publish-AllRuntimeDependencies

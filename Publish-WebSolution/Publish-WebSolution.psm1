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

.EXAMPLE
Publish-ConfiguredWebSolution -SolutionRootPath "D:\Project\Solution" -WebrootOutputPath "D:\Websites\SolutionSite\www" -DataOutputPath "D:\Websites\SolutionSite\Data" -BuildConfiguration "Debug"
Publishes the solution placed at "D:\Project\Solution" to "D:\Websites\SolutionSite\www" using the "Debug" build configuration, and saves the provided parameters to "D:\Project\Solution\.pentia\user-settings.json" for future use.

Publish-ConfiguredWebSolution
Publishes the solution using the saved user settings found in "<current directory>\.pentia\user-settings.json", and prompts the user for any missing settings.

.NOTES
In order to enable verbose or debug output for the entire command, run the following in your current PowerShell session (your "PowerShell command prompt"):
    $VerbosePreference = "Continue"
    $DebugPreference = "Continue"
#> 
Function Publish-ConfiguredWebSolution {
    [CmdletBinding(DefaultParameterSetName = "UseUserSettings")]
    Param (
        [Parameter(Mandatory = $False)]
        [string]$SolutionRootPath,

        [Parameter(Mandatory = $False)]
        [string]$WebrootOutputPath,

        [Parameter(Mandatory = $False)]
        [string]$DataOutputPath,

        [Parameter(Mandatory = $False)]
        [string]$BuildConfiguration
    )

    $SolutionRootPath = Get-SolutionRootPath -SolutionRootPath $SolutionRootPath		
    $parameters = Get-ActualPublishParameters -SolutionRootPath $SolutionRootPath -WebrootOutputPath $WebrootOutputPath -DataOutputPath $DataOutputPath -BuildConfiguration $BuildConfiguration
    $WebrootOutputPath = $parameters.webrootOutputPath
    $DataOutputPath = $parameters.dataOutputPath
    $BuildConfiguration = $parameters.buildConfiguration

    Publish-UnconfiguredWebSolution -SolutionRootPath $SolutionRootPath -WebrootOutputPath $WebrootOutputPath -DataOutputPath $DataOutputPath
    If (Test-Path $WebrootOutputPath) {
        Set-WebSolutionConfiguration -WebrootOutputPath $WebrootOutputPath -BuildConfiguration $BuildConfiguration
    }
    Else {
        Write-Warning "'$WebrootOutputPath' not found. Skipping solution configuration."
    }
}

Function Get-SolutionRootPath {
    Param (
        [Parameter(Mandatory = $False)]
        [string]$SolutionRootPath
    )

    If ([string]::IsNullOrWhiteSpace($SolutionRootPath)) {
        $SolutionRootPath = "$PWD"
        Write-Verbose "`$SolutionRootPath not set. Using '$PWD'."
    }
    $SolutionRootPath
}

Function Get-ActualPublishParameters {
    [CmdletBinding(DefaultParameterSetName = "UseUserSettings")]
    Param (
        [Parameter(Mandatory = $True)]
        [string]$SolutionRootPath,

        [Parameter(Mandatory = $False)]
        [string]$WebrootOutputPath,

        [Parameter(Mandatory = $False)]
        [string]$DataOutputPath,

        [Parameter(Mandatory = $False)]
        [string]$BuildConfiguration
    )

    $userSettings = Get-UserSettings -SolutionRootPath $SolutionRootPath
    $mergedSettings = Merge-ParametersAndUserSettings -Settings $userSettings -WebrootOutputPath $WebrootOutputPath -DataOutputPath $DataOutputPath -BuildConfiguration $BuildConfiguration
    If([string]::IsNullOrWhiteSpace($mergedSettings.webrootOutputPath)) {
        $mergedSettings.webrootOutputPath = Read-Host "Enter value for `$WebrootOutputPath"
    }
    If([string]::IsNullOrWhiteSpace($mergedSettings.dataOutputPath)) {
        $mergedSettings.dataOutputPath = Read-Host "Enter value for `$DataOutputPath"
    }
    If([string]::IsNullOrWhiteSpace($mergedSettings.buildConfiguration)) {
        $mergedSettings.buildConfiguration = Read-Host "Enter value for `$BuildConfiguration"
    }
    Set-UserSettings -SolutionRootPath $SolutionRootPath -Settings $mergedSettings
    $mergedSettings
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

.EXAMPLE
Publish-UnconfiguredWebSolution -SolutionRootPath "D:\Project\Solution" -WebrootOutputPath "D:\Websites\SolutionSite\www" -DataOutputPath "D:\Websites\SolutionSite\Data"
Publishes the solution placed at "D:\Project\Solution" to "D:\Websites\SolutionSite\www".

.NOTES
In order to enable verbose or debug output for the entire command, run the following in your current PowerShell session (your "PowerShell command prompt"):
    $VerbosePreference = "Continue"
    $DebugPreference = "Continue"
#>
Function Publish-UnconfiguredWebSolution {
    [CmdletBinding(SupportsShouldProcess = $True)]
    Param (
        [Parameter(Mandatory = $False)]
        [string]$SolutionRootPath,
		
        [Parameter(Mandatory = $True)]
        [string]$WebrootOutputPath,
		
        [Parameter(Mandatory = $True)]
        [string]$DataOutputPath
    )

    $SolutionRootPath = Get-SolutionRootPath -SolutionRootPath $SolutionRootPath

    Write-Progress -Activity "Publishing web solution" -Status "Cleaning webroot output path"
    Remove-WebrootOutputPath -WebrootOutputPath $WebrootOutputPath

    Write-Progress -Activity "Publishing web solution" -Status "Publishing runtime dependency packages"    
    Publish-AllRuntimeDependencies -SolutionRootPath $SolutionRootPath -WebrootOutputPath $WebrootOutputPath -DataOutputPath $DataOutputPath

    Write-Progress -Activity "Publishing web solution" -Status "Publishing web projects"
    Publish-AllWebProjects -SolutionRootPath $SolutionRootPath -WebrootOutputPath $WebrootOutputPath    
	
    Write-Progress -Activity "Publishing web solution" -Completed -Status "Done."
}

Function Remove-WebrootOutputPath {
    [CmdletBinding(SupportsShouldProcess = $True)]
    Param (
        [Parameter(Mandatory = $True)]
        [string]$WebrootOutputPath
    )
    If (-not $pscmdlet.ShouldProcess($WebrootOutputPath, "Delete the directory and all contents")) {
        return
    }
    If (Test-Path $WebrootOutputPath -PathType Container) {
        Write-Verbose "Deleting '$WebrootOutputPath' and all contents."
        Remove-Item -Path $WebrootOutputPath -Recurse -Force
    }
}

Function Publish-AllRuntimeDependencies {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $True)]
        [string]$SolutionRootPath,

        [Parameter(Mandatory = $True)]
        [string]$WebrootOutputPath,

        [Parameter(Mandatory = $True)]
        [string]$DataOutputPath
    )
    $runtimeDependencyConfigurationFileName = "runtime-dependencies.config"
    $runtimeDependencyConfigurationFilePath = [System.IO.Path]::Combine($SolutionRootPath, $runtimeDependencyConfigurationFileName)
    If (-not (Test-Path $runtimeDependencyConfigurationFilePath -PathType Leaf)) {
        Write-Verbose "No '$runtimeDependencyConfigurationFileName' file found in '$SolutionRootPath'. Skipping runtime package installation."
        return      
    }
    $runtimeDependencies = Get-RuntimeDependencyPackage -ConfigurationFilePath $RuntimeDependencyConfigurationFilePath
    for ($i = 0; $i -lt $runtimeDependencies.Count; $i++) {
        $runtimeDependency = $runtimeDependencies[$i]
        Write-Progress -Activity "Publishing web solution" -PercentComplete ($i / $runtimeDependencies.Count * 100) -Status "Publishing runtime dependency packages" -CurrentOperation "$($runtimeDependency.id) $($runtimeDependency.version)"
        Publish-RuntimeDependencyPackage -WebrootOutputPath $WebrootOutputPath -DataOutputPath $DataOutputPath -PackageName $runtimeDependency.id -PackageVersion $runtimeDependency.version -PackageSource $runtimeDependency.source
    }
}

Function Publish-AllWebProjects {
    Param (
        [Parameter(Mandatory = $False)]
        [string]$SolutionRootPath,
    
        [Parameter(Mandatory = $True)]
        [string]$WebrootOutputPath
    )
    $msBuildExecutablePath = Get-MSBuild
    $webProjects = Get-WebProject -SolutionRootPath $SolutionRootPath
    for ($i = 0; $i -lt $webProjects.Count; $i++) {
        Write-Progress -Activity "Publishing web solution" -PercentComplete ($i / $webProjects.Count * 100) -Status "Publishing web projects" -CurrentOperation "$webProject"
        $webProject = $webProjects[$i]
        $webProject | Publish-WebProject -OutputPath $WebrootOutputPath -MSBuildExecutablePath $msBuildExecutablePath
    }
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
Function Set-WebSolutionConfiguration {
    [CmdletBinding(SupportsShouldProcess = $True)]
    Param (
        [Parameter(Mandatory = $True)]
        [string]$WebrootOutputPath,
		
        [Parameter(Mandatory = $True)]
        [string]$BuildConfiguration
    )
	
    If (-not (Test-Path $WebrootOutputPath)) {
        Throw "Path '$WebrootOutputPath' not found."
    }

    Write-Progress -Activity "Configuring web solution" -Status "Applying XML Document Transforms"
    If ($pscmdlet.ShouldProcess($WebrootOutputPath, "Apply XML Document Transforms")) {
        Invoke-AllTransforms -SolutionRootPath $WebrootOutputPath -WebrootOutputPath $WebrootOutputPath -BuildConfiguration $BuildConfiguration
    }

    Write-Progress -Activity "Configuring web solution" -Status "Removing XML Document Transform files"
    If ($pscmdlet.ShouldProcess($WebrootOutputPath, "Remove XML Document Transform files")) {
        Get-ConfigurationTransformFile -SolutionRootPath $WebrootOutputPath | ForEach-Object { Remove-Item -Path $_ }
    }

    Write-Progress -Activity "Configuring web solution" -Status "Done." -Completed
}

Function Invoke-AllTransforms {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $True)]
        [string]$SolutionRootPath,

        [Parameter(Mandatory = $True)]
        [string]$WebrootOutputPath,
        
        [Parameter(Mandatory = $True)]
        [string]$BuildConfiguration
    )	
    $xdtFiles = @(Get-ConfigurationTransformFile -SolutionRootPath $SolutionRootPath -BuildConfigurations "Always", $BuildConfiguration)
    for ($i = 0; $i -lt $xdtFiles.Count; $i++) {
        Write-Progress -Activity "Configuring web solution" -PercentComplete ($i / $xdtFiles.Count * 100) -Status "Applying XML Document Transforms" -CurrentOperation "$xdtFile"
        $xdtFile = $xdtFiles[$i]
        $fileToTransform = Get-PathOfFileToTransform -ConfigurationTransformFilePath $xdtFile -WebrootOutputPath $WebrootOutputPath
        Invoke-ConfigurationTransform -XmlFilePath $fileToTransform -XdtFilePath $xdtFile | Set-Content -Path $fileToTransform -Encoding UTF8
    }
}

Export-ModuleMember -Function Publish-ConfiguredWebSolution, Publish-UnconfiguredWebSolution, Set-WebSolutionConfiguration

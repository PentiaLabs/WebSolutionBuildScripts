<#
.SYNOPSIS
Used to publish a Sitecore Helix solution to a folder.

.DESCRIPTION
This function is used to publish a sitecore solution to a specific folder.
The steps it runs through are:

1. Delete $WebrootOutputPath.
2. Publish runtime dependencies to $WebrootOutputPath.
3. Publish all web projects to $WebrootOutputPath, on top of the published runtime dependencies.
4. Invoke configuration transforms.

.PARAMETER SolutionRootPath
This is the absolute path to the root of your solution, usually the same directory as your `.sln` file is placed.
Uses the current working directory as a fallback.

.PARAMETER WebrootOutputPath
The path to where you want your webroot to be published. E.g. "D:\Websites\SolutionSite\www".

.PARAMETER DataOutputPath
This is where the Sitecore data folder will be placed. E.g. "D:\Websites\SolutionSite\Data".

.PARAMETER BuildConfiguration
The build configuration that will be passed to `MSBuild.exe`.

.EXAMPLE
Publish-HelixSolution -SolutionRootPath "D:\Project\Solution" -WebrootOutputPath "D:\Websites\SolutionSite\www" -DataOutputPath "D:\Websites\SolutionSite\Data" -BuildConfiguration "Debug"
Publishes the solution placed at "D:\Project\Solution" to "D:\Websites\SolutionSite" using the Debug build configuration

.NOTES
In order to enable verbose or debug output for the entire command, set these variables:
    set "$PSDefaultParameterValues:['*:Verbose'] = $True"
    set "$PSDefaultParameterValues:['*:Debug'] = $True"
#> 
Function Publish-HelixSolution {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $False)]
        [string]$SolutionRootPath,

        [Parameter(Mandatory = $True)]
        [string]$WebrootOutputPath,

        [Parameter(Mandatory = $True)]
        [string]$DataOutputPath,

        [Parameter(Mandatory = $True)]
        [string]$BuildConfiguration
    )
    
    $SolutionRootPath = Get-SolutionRootPath -SolutionRootPath $SolutionRootPath

    # If output is set to "Verbose", set "$PSDefaultParameterValues:['*:Verbose'] = $True"
    # If output is set to "Debug", set "$PSDefaultParameterValues:['*:Debug'] = $True"
    # etc.

    # 1. Delete $WebrootOutputPath
    Write-Progress -Activity "Publishing Helix solution" -Status "Cleaning webroot output path"
    Remove-WebrootOutputPath -WebrootOutputPath $WebrootOutputPath

    # 2. Publish runtime dependencies
    Write-Progress -Activity "Publishing Helix solution" -Status "Publishing runtime dependency packages"    
    Publish-AllRuntimeDependencies -SolutionRootPath $SolutionRootPath -WebrootOutputPath $WebrootOutputPath -DataOutputPath $DataOutputPath

    # 3. Publish all web projects on top of the published runtime dependencies
    Write-Progress -Activity "Publishing Helix solution" -Status "Publishing web projects"
    Publish-AllWebProjects -SolutionRootPath $SolutionRootPath -WebrootOutputPath $WebrootOutputPath

    # 4. Invoke configuration transforms
    Write-Progress -Activity "Publishing Helix solution" -Status "Applying XML transforms"
    Invoke-AllTransforms -SolutionRootPath $SolutionRootPath -WebrootOutputPath $WebrootOutputPath -BuildConfiguration $BuildConfiguration

    Write-Progress -Activity "Publishing Helix solution" -Completed -Status "Done."
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

Function Remove-WebrootOutputPath {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $True)]
        [string]$WebrootOutputPath
    )
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
        Write-Progress -Activity "Publishing Helix solution" -PercentComplete ($i / $runtimeDependencies.Count * 100) -Status "Publishing runtime dependency packages" -CurrentOperation "$($runtimeDependency.id) $($runtimeDependency.version)"
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
    $webProjects = Get-SitecoreHelixProject -SolutionRootPath $SolutionRootPath
    for ($i = 0; $i -lt $webProjects.Count; $i++) {
        Write-Progress -Activity "Publishing Helix solution" -PercentComplete ($i / $webProjects.Count * 100) -Status "Publishing web projects" -CurrentOperation "$webProject"
        $webProject = $webProjects[$i]
        $webProject | Publish-WebProject -OutputPath $WebrootOutputPath -MSBuildExecutablePath $msBuildExecutablePath
    }
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
        Write-Progress -Activity "Publishing Helix solution" -PercentComplete ($i / $xdtFiles.Count * 100) -Status "Applying XML transforms" -CurrentOperation "$xdtFile"
        $xdtFile = $xdtFiles[$i]
        $fileToTransform = Get-PathOfFileToTransform -ConfigurationTransformFilePath $xdtFile -WebrootOutputPath $WebrootOutputPath
        Invoke-ConfigurationTransform -XmlFilePath $fileToTransform -XdtFilePath $xdtFile | Set-Content -Path $fileToTransform        
    }
}

Export-ModuleMember -Function Publish-HelixSolution

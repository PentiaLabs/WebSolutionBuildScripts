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
    Write-Progress -Activity "Publishing Helix solution" -PercentComplete 0 -Status "Cleaning webroot output path"
    Remove-WebrootOutputPath -WebrootOutputPath $WebrootOutputPath

    # 2. Publish runtime dependencies
    Write-Progress -Activity "Publishing Helix solution" -PercentComplete 25 -Status "Publishing runtime dependency packages"    
    Publish-AllRuntimeDependencies -SolutionRootPath $SolutionRootPath -WebrootOutputPath $WebrootOutputPath -DataOutputPath $DataOutputPath

    # 3. Publish all web projects on top of the published runtime dependencies
    Write-Progress -Activity "Publishing Helix solution" -PercentComplete 50 -Status "Publishing web projects"
    Publish-AllWebProjects -SolutionRootPath $SolutionRootPath -WebrootOutputPath $WebrootOutputPath

    # 4. Invoke configuration transforms
    Write-Progress -Activity "Publishing Helix solution" -PercentComplete 75 -Status "Applying XML transforms"
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
    $webProjects = Get-SitecoreHelixProject -SolutionRootPath $SolutionRootPath
    for ($i = 0; $i -lt $webProjects.Count; $i++) {
        Write-Progress -Activity "Publishing Helix solution" -PercentComplete ($i / $webProjects.Count * 100) -Status "Publishing web projects" -CurrentOperation "$webProject"
        $webProject = $webProjects[$i]
        $webProject | Publish-WebProject -OutputPath $WebrootOutputPath
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

Import-Module "$PSScriptRoot\Publish-RuntimeDependencyPackage\Get-RuntimeDependencyPackage.psm1" -Force
Import-Module "$PSScriptRoot\Publish-RuntimeDependencyPackage\Publish-RuntimeDependencyPackage.psm1" -Force

Import-Module "$PSScriptRoot\Publish-HelixSolution\Get-SitecoreHelixProject.psm1" -Force
Import-Module "$PSScriptRoot\Publish-HelixSolution\Publish-WebProject.psm1" -Force

Import-Module "$PSScriptRoot\Invoke-ConfigurationTransform\Invoke-ConfigurationTransform.psm1" -Force

Function Publish-HelixSolution {
    Param (
        [Parameter(Mandatory = $False)]
        [string]$SolutionRootPath,

        [Parameter(Mandatory = $True)]
        [string]$WebrootOutputPath,

        [Parameter(Mandatory = $True)]
        [string]$DataOutputPath
    )

    If ([string]::IsNullOrWhiteSpace($SolutionRootPath)) {
        $SolutionRootPath = $MyInvocation.PSCommandPath
        Write-Verbose "`$SolutionRootPath not set. Using '$SolutionRootPath'."
    }

    # 1. Delete $PublishToPath
    Remove-WebrootOutputPath -WebrootOutputPath $WebrootOutputPath

    # 2. Publish runtime dependencies
    $runtimeDependencyConfigurationFileName = "runtime-dependencies.config"
    $runtimeDependencyConfigurationFilePath = [System.IO.Path]::Combine($SolutionRootPath, $runtimeDependencyConfigurationFileName)
    IF (Test-Path $runtimeDependencyConfigurationFilePath -PathType Leaf) {
        Publish-RuntimeDependency -RuntimeDependencyConfigurationFilePath $runtimeDependencyConfigurationFilePath -WebrootOutputPath $WebrootOutputPath -DataOutputPath $DataOutputPath
    } Else {
        Write-Verbose "No '$runtimeDependencyConfigurationFileName' file found in '$SolutionRootPath'. Skipping runtime package installation."
    }

    # 3. Publish all web projects on top of runtime dependencies
    

    # 4. Invoke configuration transforms
}

Function Remove-WebrootOutputPath {
    Param (
        [Parameter(Mandatory = $True)]
        [string]$WebrootOutputPath
    )
    If (Test-Path $WebrootOutputPath -PathType Container) {
        Write-Verbose "Deleting '$WebrootOutputPath' and all contents."
        Remove-Item -Path $WebrootOutputPath -Recurse -Force
    }
}

Function Publish-RuntimeDependency {
    Param (
        [Parameter(Mandatory = $True)]
        [string]$RuntimeDependencyConfigurationFilePath,

        [Parameter(Mandatory = $True)]
        [string]$WebrootOutputPath,

        [Parameter(Mandatory = $True)]
        [string]$DataOutputPath
    )
    $runtimeDependencies = Get-RuntimeDependency -ConfigurationFilePath $RuntimeDependencyConfigurationFilePath
    foreach ($runtimeDependency in $runtimeDependencies) {
        Publish-RuntimeDependencyPackage -WebrootOutputPath $WebrootOutputPath -DataOutputPath $DataOutputPath -PackageName $runtimeDependency.id -PackageVersion $runtimeDependency.version
    }
}

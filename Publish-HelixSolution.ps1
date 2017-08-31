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
    $runtimeDependencyConfigurationFileName = "runtime-dependencies.config"
    $runtimeDependencies = Get-RuntimeDependency -ConfigurationFilePath [System.IO.Path]::Combine($SolutionRootPath, $runtimeDependencyConfigurationFileName)
    foreach ($runtimeDependency in $runtimeDependencies) {
        Publish-RuntimeDependencyPackage -WebrootOutputPath $WebrootOutputPath -DataOutputPath $DataOutputPath -PackageName $runtimeDependency.id -PackageVersion $runtimeDependency.version
    }

    # 3. Publish all web projects

    # 4. Invoke configuration transforms
}

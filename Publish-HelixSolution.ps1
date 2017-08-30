. ".\Publish-HelixSolution\Get-SitecoreHelixProject.psm1" -Force
. ".\Publish-HelixSolution\Publish-WebProject.psm1" -Force
. ".\Publish-RuntimeDependencyPackage\Publish-RuntimeDependencyPackage.ps1" -Force
. ".\Invoke-ConfigurationTransform\Invoke-ConfigurationTransform.psm1" -Force

Function Publish-HelixSolution {
    Param (
        [Parameter(Mandatory = $True)]
        [string]$SolutionRootPath,
        
        [Parameter(Mandatory = $True)]
        [string]$PublishToPath
    )

    # 1. Delete $PublishToPath
    
    # 2. Install packages
    # 2.1 Read "runtime-dependencies.json"
    # 2.2 Throw error when "runtime-dependencies.json" doesn't match JSON definition
    # 2.3 Install each package

    # 3. Publish all web projects

    # 4. Invoke configuration transforms
}
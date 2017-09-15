$ErrorActionPreference = Stop

Function Register-TundRepository {
    $repository = Get-PSRepository "Tund" -ErrorAction SilentlyContinue
    if (-not $repository) {
        Register-PSRepository -Name "Tund" -SourceLocation "http://tund/nuget/powershell/" -PublishLocation "http://tund/nuget/powershell/" -Verbose
    }
}

Function Publish {
    Param(
        [Parameter(ValueFromPipeline = $True)]
        $modulePath
    )
    Process {
        Write-Host "Publishing '$modulePath'"
        Publish-Module -Path $modulePath -NuGetApiKey "***REMOVED***" -Repository "Tund" -Force -ErrorAction Continue        
    }
}

Register-TundRepository | Out-Null

$modules = Get-Module -Name ".\**\*.psd1" -ListAvailable

# Module installation is required for the other modules to be publishable. 
# This is because Test-ModuleManifest is run prior to publication, 
# and all required modules *must* be installed on the local system
# for it to validate the module manifest.
# See https://github.com/PowerShell/PowerShellGet/blob/90c5a3d4c8a2e698d38cfb5ef4b1c44d79180d66/Tests/PSGetPublishModule.Tests.ps1#L1470).
$modulesWithoutDependencies = $modules | Where-Object { $_.RequiredModules.Count -eq 0 }
Write-Host "Publishing all modules without dependencies."
$modulesWithoutDependencies | Select-Object -ExpandProperty "ModuleBase" | Publish
Write-Host "Installing all modules without dependencies."
$modulesWithoutDependencies | Install-Module -Repository "Tund" -Force

# Since these modules can have interdependencies, they need to be installed an published one by one.
$modulesWithDependencies = $modules | Where-Object { $_.RequiredModules.Count -gt 0 } | Sort-Object -Property "RequiredModules"
foreach ($moduleWithDependencies in $modulesWithDependencies) {
    Write-Host "Publishing single module with dependencies."
    $moduleWithDependencies | Select-Object -ExpandProperty "ModuleBase" | Publish
    Write-Host "Installing single module with dependencies."
    $moduleWithDependencies | Install-Module -Repository "Tund" -Force
}

Write-Host "Done."
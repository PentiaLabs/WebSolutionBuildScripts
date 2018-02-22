Param (
    [Parameter(Mandatory = $True)]
    [string]$Username,

    [Parameter(Mandatory = $True)]
    [string]$PersonalAccessToken
)

Import-Module -Name "PowerShellGet" -MinimumVersion "1.6" -ErrorAction Stop

Function Register-PentiaPowerShellRepository {
    Param(
        [Parameter(Mandatory = $True)]
        [Repository]$Repository
    )
    Unregister-PSRepository $Repository.Name -ErrorAction SilentlyContinue
    Register-PSRepository -Name $Repository.Name -SourceLocation $Repository.SourceLocation -PublishLocation $Repository.PublishLocation -InstallationPolicy "Trusted" -Credential $Repository.Credentials -PackageManagementProvider NuGet
}

Function Publish {
    Param(
        [Parameter(ValueFromPipeline = $True)]
        $ModulePath,

        [Parameter(Mandatory = $True)]
        [Repository]$Repository
    )
    Process {
        Write-Host "Publishing '$ModulePath' to '$($Repository.Name)'"
        Publish-Module -Path $ModulePath -NuGetApiKey $Repository.NuGetApiKey -Repository $Repository.Name -Credential $Repository.Credentials -Force -ErrorAction Continue
    }
}

Function Publish-AllModules {
    Param(
        [Parameter(Mandatory = $True)]
        [Repository]$Repository
    )
    
    Write-Host "Publishing all modules to '$($Repository.Name)'..."
    Register-PentiaPowerShellRepository -Repository $Repository | Out-Null

    $modules = Get-Module -Name ".\**\*.psd1" -ListAvailable

    # Module installation is required for the other modules to be publishable. 
    # This is because Test-ModuleManifest is run prior to publication, 
    # and all required modules *must* be installed on the local system
    # for it to validate the module manifest.
    # See https://github.com/PowerShell/PowerShellGet/blob/90c5a3d4c8a2e698d38cfb5ef4b1c44d79180d66/Tests/PSGetPublishModule.Tests.ps1#L1470).
    $modulesWithoutDependencies = $modules | Where-Object { $_.RequiredModules.Count -eq 0 }
    Write-Host "Publishing all modules without dependencies."
    $modulesWithoutDependencies | Select-Object -ExpandProperty "ModuleBase" | Publish -Repository $Repository
    Write-Host "Installing all modules without dependencies."
    $modulesWithoutDependencies | Install-Module -Repository $Repository.Name -Credential $Repository.Credentials -Force

    # Since these modules can have interdependencies, they need to be installed and published one by one.
    $modulesWithDependencies = $modules | Where-Object { $_.RequiredModules.Count -gt 0 } | Sort-Object -Property { $_.RequiredModules.Count }
    foreach ($moduleWithDependencies in $modulesWithDependencies) {
        Write-Host "Publishing single module with dependencies."
        $moduleWithDependencies | Select-Object -ExpandProperty "ModuleBase" | Publish -Repository $Repository
        Write-Host "Installing single module with dependencies."
        $moduleWithDependencies | Install-Module -Repository $Repository.Name -Credential $Repository.Credentials -Force
    }
}

Class Repository {
    [string]$Name
    [string]$SourceLocation
    [string]$PublishLocation
    [string]$NuGetApiKey
    [string]$Username
    [string]$Password
    [PSCredential]$Credentials
}

$tund = New-Object Repository
$tund.Name = "Pentia ProGet PowerShell"
$tund.SourceLocation = "http://tund.hq.pentia.dk/nuget/powershell/"
$tund.PublishLocation = "http://tund.hq.pentia.dk/nuget/powershell/"
$tund.NuGetApiKey = "***REMOVED***"

$vsts = New-Object Repository
$vsts.Name = "Pentia VSTS PowerShell"
$vsts.SourceLocation = "https://pentia.pkgs.visualstudio.com/_packaging/powershell-pentia/nuget/v2"
$vsts.PublishLocation = "https://pentia.pkgs.visualstudio.com/_packaging/powershell-pentia/nuget/v2"
$vsts.NuGetApiKey = "<irrelevant>"
$vsts.Username = $Username
$vsts.Password = $PersonalAccessToken
$vsts.Credentials = New-Object System.Management.Automation.PSCredential ($vsts.Username, (ConvertTo-SecureString $vsts.Password -AsPlainText -Force))

#Publish-AllModules -Repository $tund
Publish-AllModules -Repository $vsts

Write-Host "Done."
param (
    [Parameter(Mandatory = $true)]
    [string]$Username,

    [Parameter(Mandatory = $true)]
    [string]$PersonalAccessToken
)

Import-Module -Name "PowerShellGet" -MinimumVersion "1.6.0" -ErrorAction Stop -Force

Class Repository {
    [string]$Name
    [string]$SourceLocation
    [string]$PublishLocation
    [string]$NuGetApiKey
    [string]$Username
    [string]$Password
    [PSCredential]$Credentials
}

function Publish-AllModulesToLocalFolder {    
    $localFolder = "$PSScriptRoot\output"
    Write-Host "Publishing all modules to '$localFolder'..."    
    New-Item -Path $localFolder -ItemType Directory -Force -ErrorAction SilentlyContinue | Out-Null
    if (-not (Get-PSRepository -Name "Local Folder" -ErrorAction SilentlyContinue)) {
        Register-PSRepository -Name "Local Folder" -SourceLocation "$localFolder" -PublishLocation "$localFolder"
    }

    $modules = Get-Module -Name ".\**\*.psd1" -ListAvailable

    # Module installation is required for the other modules to be publishable. 
    # This is because Test-ModuleManifest is run prior to publication, 
    # and all required modules *must* be installed on the local system
    # for it to validate the module manifest.
    # See https://github.com/PowerShell/PowerShellGet/blob/90c5a3d4c8a2e698d38cfb5ef4b1c44d79180d66/Tests/PSGetPublishModule.Tests.ps1#L1470).
    Remove-Item -Path "$localFolder\*"
    $modulesWithoutDependencies = $modules | Where-Object { $_.RequiredModules.Count -eq 0 }
    Write-Host "Publishing all modules without dependencies."
    $modulesWithoutDependencies | Select-Object -ExpandProperty "ModuleBase" | ForEach-Object { Publish-Module -Path $_ -Repository "Local Folder" }
    Write-Host "Installing all modules without dependencies."
    $modulesWithoutDependencies | Install-Module -Repository "Local Folder" -Scope CurrentUser -Force

    # Since these modules can have interdependencies, they need to be installed and published one by one.
    $modulesWithDependencies = $modules | Where-Object { $_.RequiredModules.Count -gt 0 } | Sort-Object -Property { $_.RequiredModules.Count }
    foreach ($moduleWithDependencies in $modulesWithDependencies) {
        Write-Host "Publishing single module with dependencies."
        $moduleWithDependencies | Select-Object -ExpandProperty "ModuleBase" | ForEach-Object { Publish-Module -Path $_ -Repository "Local Folder" }
        Write-Host "Installing single module with dependencies."
        $moduleWithDependencies | Install-Module -Repository "Local Folder" -Scope CurrentUser -Force
    }
    $localFolder
}

function Publish-AllModulesToRepository {
    param (
        [Parameter(Mandatory = $true)]
        [Repository]$Repository,

        [Parameter(Mandatory = $true)]
        [string]$LocalFolder
    )
    Write-Host "Publishing all modules to '$($Repository.Name)'..."
    # We're falling back to raw NuGet commands because interaction with feeds which require credentials is currently f*cked in PowerShellGet
    $nugetExePath = Get-Command -Name "NuGet.exe" -ErrorAction SilentlyContinue | Select-Object -ExpandProperty "Path"
    if (-not $nugetExePath) {
        Install-NuGetExe
        $nugetExePath = "$PSScriptRoot/.pentia/NuGet.exe"
    }
    if ($Repository.Username -and $Repository.Password) {
        & "$nugetExePath" "sources" "add" "-Name" "$($Repository.Name)" "-Source" "$($Repository.PublishLocation)" "-Username" "$($Repository.Username)" "-Password" "$($Repository.Password)"
    }
    $packages = Get-ChildItem "$LocalFolder\*.nupkg"
    foreach ($package in $packages) {
        & "$nugetExePath" "push" "$($package.FullName)" "-Source" "$($Repository.PublishLocation)" "-ApiKey" "$($Repository.NuGetApiKey)"   
    }
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

$localFolder = Publish-AllModulesToLocalFolder
#Publish-AllModulesToRepository -Repository $tund -LocalFolder $localFolder
#Publish-AllModulesToRepository -Repository $vsts -LocalFolder $localFolder

Write-Host "Done."
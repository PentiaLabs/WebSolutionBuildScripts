<#
.SYNOPSIS
Installs a package using Windows PackageManagement (https://docs.microsoft.com/en-us/powershell/module/PackageManagement/?view=powershell-5.0).
Requires -RunAsAdministrator.
#>
Function Install-RuntimePackage {
    Param(
        [Parameter(Mandatory = $True)]
        [string]$PackageName,
        
        [Parameter(Mandatory = $True)]
        [string]$PackageVersion,
        
        [Parameter(Mandatory = $True)]
        [string]$PackageSource,
        
        [Parameter(Mandatory = $False)]
        [string]$Username = [string]::Empty,
        
        [Parameter(Mandatory = $False)]
        [SecureString]$Password = [SecureString]::Empty,
        
        [Parameter(Mandatory = $True)]
        [string]$WebRootPath,

        [Parameter(Mandatory = $True)]
        [string]$DataRootPath
    ) 

    Write-Verbose "Searching for package '$PackageName' version '$PackageVersion'."
    $nugetPackage = Get-RuntimeDependencyPackageFromCache -PackageName $PackageName -PackageVersion $PackageVersion
    if (-not $nugetPackage) {
        Write-Verbose "Package '$PackageName $PackageVersion' not found locally. Installing from '$PackageSource'."
        Install-RuntimeDependencyPackageFromRemote
        $nugetPackage = Get-RuntimeDependencyPackageFromCache -PackageName $PackageName -PackageVersion $PackageVersion
    }
    
    Copy-RuntimeDependencyPackageContents

    $hasDeployScript = (Get-ChildItem -Path "$WebRootPath" -Filter packageDeploy.ps1).Count -lt 0

    if ($hasDeployScript) {
        Invoke-Expression "$WebRootPath\packageDeploy.ps1"  
        Remove-Item -Path "$WebRootPath\packageDeploy.ps1" 
    }
}

Function Get-RuntimeDependencyPackageFromCache {
    Param(
        [Parameter(Mandatory = $True)]
        [string]$PackageName,
        
        [Parameter(Mandatory = $True)]
        [string]$PackageVersion
    )
    If(!(Test-PackageProvider "NuGet")) {
        Throw "The NuGet package provider isn't installed. Run 'Install-PackageProvider -Name NuGet' from an elevated PowerShell prompt."
    }
    $nugetPackage = Get-Package -ProviderName NuGet -AllVersions | Where-Object {$_.Name -eq $PackageName -and $_.Version -eq $PackageVersion}
    $nugetPackage
}

Function Test-PackageProvider {
    Param(
        [Parameter(Mandatory = $True)]
        [string]$Name
    )
    (Get-PackageProvider | Where-Object { $_.Name -eq $Name } | Select-Object -ExpandProperty "Count") -gt 0
}

Function Install-RuntimeDependencyPackage {    
    Param(
        [Parameter(Mandatory = $True)]
        [string]$PackageName,
    
        [Parameter(Mandatory = $True)]
        [string]$PackageVersion,
    
        [Parameter(Mandatory = $True)]
        [string]$PackageSource,
    
        [Parameter(Mandatory = $False)]
        [string]$Username = [string]::Empty,
    
        [Parameter(Mandatory = $False)]
        [SecureString]$Password = [SecureString]::Empty
    )
    $credentials = [System.Management.Automation.PSCredential]::Empty
    if ([string]::IsNullOrWhiteSpace($Username) -eq $false -and [string]::IsNullOrWhiteSpace($Password) -eq $false) {
        $credentials = New-Object System.Management.Automation.PSCredential($Username, $Password)
    }
    
    Write-Verbose "Installing package '$PackageName'."
    Find-Package -Source $PackageSource -Name $PackageName -RequiredVersion $PackageVersion -Credential $credentials | Install-Package -Credential $credentials -Force
}

Function Copy-RuntimeDependencyPackageContents {
    Param (
        [Parameter(Mandatory = $true)]
        [object]$nugetPackage
    )
    
    Write-Host "Copying $($PackageName)"
    $packagePath = $nugetPackage | Select-Object -Property Source | ForEach-Object { Split-Path -Path $_.Source }
    if (Test-Path -Path "$packagePath\Webroot" -PathType Container) {
        Write-Verbose "Copying '$($PackageName)' web root."
        robocopy "$packagePath\Webroot" "$WebRootPath" *.* /E /MT 64 /NFL /NP /NDL /NJH | Write-Verbose
    }
    
    if (Test-Path -Path "$packagePath\Data" -PathType Container) {
        Write-Verbose "Copying '$($PackageName)' data root."
        robocopy "$packagePath\Data" "$DataRootPath" *.* /E /MT 64 /NFL /NP /NDL /NJH | Write-Verbose
    }
}
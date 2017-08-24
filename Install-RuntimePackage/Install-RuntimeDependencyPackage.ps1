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
        [string]$WebrootPath,

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

    $hasDeployScript = (Get-ChildItem -Path "$WebrootPath" -Filter packageDeploy.ps1).Count -gt 0

    if ($hasDeployScript) {
        Invoke-Expression "$WebrootPath\packageDeploy.ps1"  
        Remove-Item -Path "$WebrootPath\packageDeploy.ps1" 
    }
}

Function Get-RuntimeDependencyPackageFromCache {
    Param(
        [Parameter(Mandatory = $True)]
        [string]$PackageName,
        
        [Parameter(Mandatory = $True)]
        [string]$PackageVersion
    )
    $packageProvider = "NuGet"
    If(!(Test-PackageProvider $packageProvider)) {
        Throw "The package provider '$packageProvider' isn't installed. Run 'Install-PackageProvider -Name $packageProvider' from an elevated PowerShell prompt."
    }
    $package = Get-Package -ProviderName $packageProvider -Name $PackageName -RequiredVersion $PackageVersion -ErrorAction SilentlyContinue
    Write-Host $package
    $package
}

Function Test-PackageProvider {
    Param(
        [Parameter(Mandatory = $True)]
        [string]$Name
    )
    (Get-PackageProvider | Select-Object -ExpandProperty "Name") -contains $Name
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
        [Microsoft.PackageManagement.Packaging.SoftwareIdentity]$Package,

        [Parameter(Mandatory = $True)]
        [string]$WebrootOutputPath,

        [Parameter(Mandatory = $True)]
        [string]$DataOutputPath
    )
    
    Write-Host "Copying $($PackageName)"
    return $null
    $packagePath = $Package | Select-Object -Property Source | ForEach-Object { Split-Path -Path $_.Source }
    if (Test-Path -Path "$packagePath\Webroot" -PathType Container) {
        Write-Verbose "Copying '$($PackageName)' web root."
        robocopy "$packagePath\Webroot" "$WebrootPath" *.* /E /MT 64 /NFL /NP /NDL /NJH | Write-Verbose
    }
    
    if (Test-Path -Path "$packagePath\Data" -PathType Container) {
        Write-Verbose "Copying '$($PackageName)' data root."
        robocopy "$packagePath\Data" "$DataRootPath" *.* /E /MT 64 /NFL /NP /NDL /NJH | Write-Verbose
    }
}
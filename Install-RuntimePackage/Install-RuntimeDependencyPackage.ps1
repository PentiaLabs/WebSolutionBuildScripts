<#
.SYNOPSIS
Publishes the contents of a runtime dependency package to a website. Requires -RunAsAdministrator.

.DESCRIPTION
Publishes the contents of a runtime dependency package to a website, using Windows PackageManagement (https://docs.microsoft.com/en-us/powershell/module/PackageManagement/?view=powershell-5.0).

Packages are expected to be NuGet-packages and contain any of the following folders:

- <package>/Webroot
- <package>/Data

All of the above are optional.

The following steps are performed during package publishing:

1. Check if the required package is cached locally.
1.1 If the package isn't found locally, install it from the specified package source.
2. Copy the contents of the "<package>\Webroot"-folder to the "<WebrootOutputPath>".
3. Copy the contents of the "<package>\Data"-folder to the "<DataOutputPath>".

.PARAMETER PackageName
The name of the package to install.

.PARAMETER PackageVersion
The exact version of the package to install.

.PARAMETER PackageSource
The URI where the package is located. Can be a file path as well.

.PARAMETER Username
Optional username required to access the package source.

.PARAMETER Password
Optional password required to access the package source.

.PARAMETER WebrootOutputPath
The path where the contents of "<package>\Webroot" will be copied to.

.PARAMETER DataOutputPath
The path where the contents of "<package>\Data" will be copied to.

.EXAMPLE
Deploy-RuntimeDependencyPackage -Verbose -PackageName "Sitecore.Full" -PackageVersion "8.2.170407" -PackageSource "http://tund/feeds/FullSitecore" -WebrootOutputPath "C:\my-website\www" -DataOutputPath "C:\my-website\SitecoreDataFolder"
#>
Function Publish-RuntimeDependencyPackage {
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
        [string]$WebrootOutputPath,

        [Parameter(Mandatory = $True)]
        [string]$DataOutputPath
    ) 

    Write-Host "Publishing package '$PackageName'."
    Write-Verbose "Searching for package '$PackageName' version '$PackageVersion'."
    $package = Get-RuntimeDependencyPackageFromCache -PackageName $PackageName -PackageVersion $PackageVersion
    if (-not $package) {
        Write-Verbose "Package '$PackageName' version '$PackageVersion' not found locally. Installing from '$PackageSource'."
        Install-RuntimeDependencyPackage
        $package = Get-RuntimeDependencyPackageFromCache -PackageName $PackageName -PackageVersion $PackageVersion
    }
    Copy-RuntimeDependencyPackageContents -Package $package -WebrootOutputPath $WebrootOutputPath -DataOutputPath $DataOutputPath
}

Function Get-RuntimeDependencyPackageFromCache {
    Param(
        [Parameter(Mandatory = $True)]
        [string]$PackageName,
        
        [Parameter(Mandatory = $True)]
        [string]$PackageVersion
    )
    $packageProvider = "NuGet"
    If (!(Test-PackageProvider $packageProvider)) {
        Throw "The package provider '$packageProvider' isn't installed. Run 'Install-PackageProvider -Name $packageProvider' from an elevated PowerShell prompt."
    }
    $package = Get-Package -ProviderName $packageProvider -Name $PackageName -RequiredVersion $PackageVersion -ErrorAction SilentlyContinue
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
        [Parameter(Mandatory = $True)]
        [Microsoft.PackageManagement.Packaging.SoftwareIdentity]$Package,

        [Parameter(Mandatory = $True)]
        [string]$WebrootOutputPath,

        [Parameter(Mandatory = $True)]
        [string]$DataOutputPath
    )
    
    $packageName = $Package.Name
    Write-Host "Copying package '$packageName'."

    $webrootSourcePath = $Package.FullPath + "\Webroot"
    Copy-PackageFolder -PackageName $packageName -SourceFriendlyName "webroot" -Source $webrootSourcePath -Target $WebrootOutputPath
    
    $dataSourcePath = $Package.FullPath + "\Data"
    Copy-PackageFolder -PackageName $packageName -SourceFriendlyName "data" -Source $dataSourcePath -Target $DataOutputPath
}

Function Copy-PackageFolder {
    Param (        
        [Parameter(Mandatory = $True)]
        [string]$PackageName,
        
        [Parameter(Mandatory = $True)]
        [string]$SourceFriendlyName,
                
        [Parameter(Mandatory = $True)]
        [string]$Source,
    
        [Parameter(Mandatory = $True)]
        [string]$Target
    )

    Write-Verbose "Checking if package '$PackageName' has a $SourceFriendlyName folder '$Source'."
    if (Test-Path -Path $Source -PathType Container) {
        Write-Verbose "Copying '$PackageName' $SourceFriendlyName files from '$Source' to '$Target'."
        robocopy "$Source" "$Target" *.* /E /MT 64 /NFL /NP /NDL /NJH | Write-Verbose
    }
    else {
        Write-Verbose "No $SourceFriendlyName folder '$Source' found in package '$PackageName'."
    }
}
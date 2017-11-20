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
1.1 If the package isn't found locally, it's installed from a registered package source, or from the $PackageSource parameter.
2. Copy the contents of the "<package>\Webroot"-folder to the "<WebrootOutputPath>".
3. Copy the contents of the "<package>\Data"-folder to the "<DataOutputPath>".

.PARAMETER Package
Optional package definition, as found in a NuGet packages.config file. 
If set, "$Package.id" will be used instead of "$PackageName", and "$Package.version" instead of "$PackageVersion".

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
Publish-RuntimeDependencyPackage -Verbose -PackageName "Sitecore.Full" -PackageVersion "8.2.170407" -PackageSource "http://tund/nuget/nuget/FullSitecore" -WebrootOutputPath "C:\my-website\www" -DataOutputPath "C:\my-website\SitecoreDataFolder"
#>
Function Publish-RuntimeDependencyPackage {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $True)]
        [string]$PackageName,
        
        [Parameter(Mandatory = $True)]
        [string]$PackageVersion,
        
        [Parameter(Mandatory = $False)]
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
    Write-Verbose "Publishing package '$PackageName'."
    Write-Verbose "Searching for package '$PackageName' version '$PackageVersion'."
    $package = Get-RuntimeDependencyPackageFromCache -PackageName $PackageName -PackageVersion $PackageVersion
    If (-not $package) {
        Write-Verbose "Package '$PackageName' version '$PackageVersion' not found locally. Installing from '$PackageSource'."
        Install-RuntimeDependencyPackage -PackageName $PackageName -PackageVersion $PackageVersion -PackageSource $PackageSource -Username $Username -Password $Password
        $package = Get-RuntimeDependencyPackageFromCache -PackageName $PackageName -PackageVersion $PackageVersion
    }
    If (-not $package) {
        Throw "Unable to install package '$PackageName' version '$PackageVersion' from source '$PackageSource'."
    }
    Copy-RuntimeDependencyPackageContent -Package $package -WebrootOutputPath $WebrootOutputPath -DataOutputPath $DataOutputPath
}

Function Get-RuntimeDependencyPackageFromCache {
    [CmdletBinding()]
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
    # The "custom filtering" has been added specifically as a workaround for https://github.com/OneGet/oneget/issues/321.
    Get-Package -ProviderName $packageProvider -AllVersions | Where-Object { ($_.Name -eq $PackageName) -and ($_.Version -eq $PackageVersion) } | Select-Object -First 1
}

Function Test-PackageProvider {
    [CmdletBinding()]
    [OutputType([System.Boolean])]        
    Param(
        [Parameter(Mandatory = $True)]
        [string]$Name
    )
    (Get-PackageProvider | Select-Object -ExpandProperty "Name") -contains $Name
}

Function Install-RuntimeDependencyPackage {   
    [CmdletBinding()] 
    Param(
        [Parameter(Mandatory = $True)]
        [string]$PackageName,
    
        [Parameter(Mandatory = $True)]
        [string]$PackageVersion,
    
        [Parameter(Mandatory = $False)]
        [string]$PackageSource,
    
        [Parameter(Mandatory = $False)]
        [string]$Username = [string]::Empty,
    
        [Parameter(Mandatory = $False)]
        [SecureString]$Password = [SecureString]::Empty
    )
    $credentials = [System.Management.Automation.PSCredential]::Empty
    If ([string]::IsNullOrWhiteSpace($Username) -eq $false -and [string]::IsNullOrWhiteSpace($Password) -eq $false) {
        $credentials = New-Object System.Management.Automation.PSCredential($Username, $Password)
    }
    Try {
        If ([string]::IsNullOrWhiteSpace($PackageSource)) {
            # There's currently a bug in the Find-Package cmdlet which requires us to manually pipe in all available package sources.
            # See https://github.com/OneGet/oneget/issues/270 for details.
            $package = Get-PackageSource -ProviderName "NuGet" | Find-Package -Name $PackageName -RequiredVersion $PackageVersion -Credential $credentials -ErrorAction Stop | Select-Object -First 1
        }
        Else {
            $package = Find-Package -Source $PackageSource -Name $PackageName -RequiredVersion $PackageVersion -Credential $credentials -ErrorAction Stop
        }
        Write-Verbose "Installing package '$PackageName'."
        $package | Install-Package -Credential $credentials -Force
    }
    Catch {
        If ($_.Exception.Message -match "No match was found for the specified search criteria and package name") {
            Throw "The package '$PackageName' version '$PackageVersion' couldn't be found in the source '$PackageSource'. " + 
            "Make sure that all required package sources are set up correctly, e.g. 'Register-PackageSource -Name ""Pentia NuGet"" -Location ""http://tund/nuget/Nuget"" -Trusted -ProviderName ""NuGet""'."
        }
        Else {
            Throw $_.Exception
        }
    }
}

Function Copy-RuntimeDependencyPackageContent {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $True)]
        [Microsoft.PackageManagement.Packaging.SoftwareIdentity]$Package,

        [Parameter(Mandatory = $True)]
        [string]$WebrootOutputPath,

        [Parameter(Mandatory = $True)]
        [string]$DataOutputPath
    )
    
    $packageName = $Package.Name
    Write-Verbose "Copying package contents of '$packageName'."

    $packageDirectory = Get-PackageDirectory -Package $Package

    $webrootSourcePath = [System.IO.Path]::Combine($packageDirectory, "Webroot")
    Copy-PackageFolder -SourceFriendlyName "webroot" -Source $webrootSourcePath -Target $WebrootOutputPath
    
    $dataSourcePath = [System.IO.Path]::Combine($packageDirectory, "Data")
    Copy-PackageFolder -SourceFriendlyName "data" -Source $dataSourcePath -Target $DataOutputPath
}

Function Get-PackageDirectory {
    [CmdletBinding()]
    [OutputType([System.String])]        
    Param (
        [Parameter(Mandatory = $True)]
        [Microsoft.PackageManagement.Packaging.SoftwareIdentity]$Package
    )
    Write-Verbose "Determining directory where package '$($Package.Name)' was unpacked."
    # The "FullPath" points to the "unpack directory", e.g. "<package root>\My-Package.1.0.0\".
    If ([System.IO.Path]::IsPathRooted($Package.FullPath) -and [System.IO.Directory]::Exists($Package.FullPath)) {
        $packageDirectory = $Package.FullPath
        Write-Verbose "Package directory determined via `$Package.FullPath ('$packageDirectory')."
        return $packageDirectory
    }
    # The "Source" points to the NuGet package file *inside* the "unpack directory", e.g. "<package root>\My-Package.1.0.0\My-Package.1.0.0.nupgk".
    If ([System.IO.Path]::IsPathRooted($Package.Source) -and [System.IO.File]::Exists($Package.Source)) {
        $packageDirectory = [System.IO.Path]::GetDirectoryName($Package.Source)
        Write-Verbose "Package directory determined via `$Package.Source ('$packageDirectory')."
        return $packageDirectory
    }
    Throw "Unable to determine unpack directory of package '$($Package.Name)'. Source: '$($Package.Source)'. FullPath: '$($Package.FullPath)'."
}

Function Copy-PackageFolder {
    [CmdletBinding()]
    Param (        
        [Parameter(Mandatory = $True)]
        [string]$SourceFriendlyName,
                
        [Parameter(Mandatory = $True)]
        [string]$Source,
    
        [Parameter(Mandatory = $True)]
        [string]$Target
    )

    Write-Verbose "Checking if package has a $SourceFriendlyName folder '$Source'."
    if (Test-Path -Path $Source -PathType Container) {
        Write-Verbose "Copying $SourceFriendlyName files from '$Source' to '$Target'."
        robocopy "$Source" "$Target" *.* /E /MT 64 /NFL /NP /NDL /NJH | Write-Verbose
    }
    else {
        Write-Verbose "No $SourceFriendlyName folder found."
    }
}

Export-ModuleMember -Function Publish-RuntimeDependencyPackage

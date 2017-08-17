#Requires -RunAsAdministrator
function Install-RuntimePackage (
    [Parameter(Mandatory=$true)]
    [object]$package,
    [Parameter(Mandatory=$true)]
    [string]$webRootPath,
    [Parameter(Mandatory=$true)]
    [string]$dataRootPath,
    [Parameter(Mandatory=$False)]
    [string]$username = [string]::Empty,
    [Parameter(Mandatory=$False)]
    [SecureString]$password = [SecureString]::Empty) {

    . $PSScriptRoot\Get-WebRequestFromUrl.ps1
    Write-Host "Getting" $package.packageName "Package"
    $nugetPackage = Get-Package -ProviderName NuGet -AllVersions | Where-Object {$_.Name -eq $package.packageName -and $_.version -eq $package.Version} 

    if(-not ($nugetPackage))
    {
        Write-Host ("Package not found locally installing from " + $package.location)
        
        $Credential = [System.Management.Automation.PSCredential]::Empty
        if ([string]::IsNullOrWhiteSpace($username) -eq $false -and [string]::IsNullOrWhiteSpace($password) -eq $false) {
            $Credential =  New-Object System.Management.Automation.PSCredential($username, $password)
        }

        if($Credential -eq [System.Management.Automation.PSCredential]::Empty)
        {
            Write-Verbose ("Testing if location is url")
            if($package.location.StartsWith("http://") -or $package.location.StartsWith("https://"))
            {
                Write-Verbose ("Location had been determined to be a url: " + $package.location)
                Write-Verbose ("Testing if location needs authentication")
                $request = Get-WebRequestFromUrl -url $package.location
                $statusCode = [int]$request.StatusCode;

                if($statusCode -eq 401)
                {
                    Write-Verbose ("Getting credentials for endpoint")
                    $Credential = Get-Credential -Message ("Please enter your credentials for " + $package.location);
                }
                elseif ($statusCode -gt 499 -and $statusCode -lt 600) {
                    Write-Error ("package location endpoint " + $package.location + " failed with error code " + $statusCode)
                }
            }
        }
        
        Write-Verbose -Message ("Installing package: " + $package.packageName)
        Find-Package -Source $package.location -Name $package.packageName -RequiredVersion $package.version -Credential $Credential | Install-Package -Credential $Credential -Force
        $nugetPackage = Get-Package -ProviderName NuGet -AllVersions | Where-Object {$_.Name -eq $package.packageName -and $_.version -eq $package.version} 
    }

    Write-Host "Copying" $package.packageName
    $packagePath = $nugetPackage | Select-Object -Property Source | foreach { Split-Path -Path $_.Source }
    if(Test-Path -Path "$packagePath\webroot")
    {
        Write-Host "Copying " $package.packageName " Webroot"
        robocopy "$packagePath\webroot" "$webRootPath" *.* /E /MT 64 /NFL /NP /NDL /NJH 
    }

    if(Test-Path -Path "$packagePath\Data")
    {
        Write-Host "Copying " $package.packageName " Data Folder"
        robocopy "$packagePath\Data" "$dataRootPath" *.* /E /MT 64 /NFL /NP /NDL /NJH
    }

    $hasDeployScript = (Get-ChildItem -Path "$webRootPath" -Filter packageDeploy.ps1).Count -lt 0

    if($hasDeployScript)
    {
        Invoke-Expression "$webRootPath\packageDeploy.ps1"  
        Remove-Item -Path "$webRootPath\packageDeploy.ps1" 
    }
}
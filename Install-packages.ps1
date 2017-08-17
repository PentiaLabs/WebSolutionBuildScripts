param(
    [Parameter(Mandatory=$true)]
    [string]$packagesFileLocation,
    [Parameter(Mandatory=$true)]
    [string]$webRootPath,
    [Parameter(Mandatory=$true)]
    [string]$dataRootPath)

. $PSScriptRoot\Install-Runtimepackage\Install-Runtimepackage.ps1
$ErrorActionPreference = "Stop"

if((Test-Path -Path $packagesFileLocation) -eq $false)
{
    Write-Error -Message "solution-packages.json not found at $packagesFileLocation"
}

if((Test-Path -Path $webRootPath) -eq $false)
{
    Write-Host "Creating " $webRootPath
    New-Item $webRootPath -type directory > $null
}

if((Test-Path -Path $dataRootPath) -eq $false)
{
    Write-Host "Creating " $dataRootPath 
    New-Item $dataRootPath -type directory > $null
}
$packages = (Get-Content $packagesFileLocation -Raw) | ConvertFrom-Json

[string]$username = ""; 
[string]$password = "";

if ($packages.credentials -ne $null -And (Test-Path $packages.credentials)) {
    $credentials = (Get-Content $packages.credentials -Raw) | ConvertFrom-Json

    $username = $credentials.username
    $password = $credentials.password
}

foreach ($package in $packages.packages) {
    Install-NugetPackage -package $package -webRootPath $webRootPath -dataRootPath $dataRootPath -username $username -password $password
}
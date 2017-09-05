Import-Module "$PSScriptRoot\..\Get-MSBuild\Get-MSBuild.psm1"

<# 
 .SYNOPSIS
 Publishes a web project to the specified output directory using MSBuild.

 .PARAMETER WebProjectFilePath
 Absolute or relative path of the web project file.

 .PARAMETER OutputPath
 Absolute or relative path of the output directory.

 .PARAMETER MSBuildExecutablePath
 Absolute or relative path of MSBuild.exe. If null or empty, the script will attempt to find the latest MSBuild.exe installed with Visual Studio 2017 or later.

 .EXAMPLE 
 Publish-WebProject -WebProjectFilePath "C:\Path\To\MyProject.csproj" -OutputPath "C:\Websites\MyWebsite"
 Publish a project.

 .EXAMPLE 
 Publish-WebProject -WebProjectFilePath "C:\Path\To\MyProject.csproj" -OutputPath "C:\Websites\MyWebsite" -MSBuildExecutablePath "C:\Path\To\MsBuild.exe"
 Publish a project and specify which MSBuild.exe to use.
#>   
Function Publish-WebProject {
    [CmdletBinding()]
    Param (
        [Parameter(Position = 0, Mandatory = $True, ValueFromPipeline)]
        [string]$WebProjectFilePath,
        [Parameter(Position = 1, Mandatory = $True)]
        [string]$OutputPath,
        [Parameter(Position = 2, Mandatory = $False)]
        [string]$MSBuildExecutablePath
    )
		
    Process {
        if (!(Test-Path $WebProjectFilePath -PathType Leaf)) {
            Throw "Path '$WebProjectFilePath' not found."
        }
        if ([string]::IsNullOrEmpty($MSBuildExecutablePath)) {
            Write-Verbose "`$MSBuildExecutablePath not set."
            $MSBuildExecutablePath = Get-MSBuild
        }
        if (!(Test-Path $MSBuildExecutablePath -PathType Leaf)) {
            Throw "Path '$MSBuildExecutablePath' not found."
        }
        Write-Verbose "Using '$MSBuildExecutablePath'."
        Write-Host "Publishing '$WebProjectFilePath' to '$OutputPath'."
        $output = (& "$MSBuildExecutablePath" "$WebProjectFilePath" /t:WebPublish /verbosity:minimal /p:publishUrl="$OutputPath" /p:DeployOnBuild="true" /p:DeployDefaultTarget="WebPublish" /p:WebPublishMethod="FileSystem" /p:DeleteExistingFiles="false" /p:_FindDependencies="false" /p:MSDeployUseChecksum="true") | Out-String
        If ($LASTEXITCODE -eq 0) {
            Write-Verbose $output
        }
        Else {
            Write-Error $output
            Throw "Error publishing project '$WebProjectFilePath'."
        }
    }
}

Export-ModuleMember -Function Publish-WebProject

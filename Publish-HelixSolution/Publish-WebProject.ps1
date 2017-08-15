. "$PSScriptRoot\..\Shared\Get-MSBuild.ps1"

<# 
 .SYNOPSIS
 Publishes a web project to the specified output directory using MSBuild.

 .PARAMETER WebProjectFilePath
 Absolute or relative path of the web project file.

 .PARAMETER OutputDirectory
 Absolute or relative path of the output directory.

 .PARAMETER MSBuildExecutablePath
 Absolute or relative path of MSBuild.exe. If null or empty, the script will attempt to find the latest MSBuild.exe installed with Visual Studio 2017 or later.

 .EXAMPLE 
 Publish-WebProject -WebProjectFilePath "C:\Path\To\MyProject.csproj" -OutputDirectory "C:\Websites\MyWebsite"
 Publish a project.

 .EXAMPLE 
 Publish-WebProject -WebProjectFilePath "C:\Path\To\MyProject.csproj" -OutputDirectory "C:\Websites\MyWebsite" -MSBuildExecutablePath "C:\Path\To\MsBuild.exe"
 Publish a project and specify which MSBuild.exe to use.
#>
Function Publish-WebProject {
    [CmdletBinding()]
    Param (
        [Parameter(Position = 0, Mandatory = $True, ValueFromPipeline)]
        [string]$WebProjectFilePath,
        [Parameter(Position = 1, Mandatory = $True)]
        [string]$OutputDirectory,
        [Parameter(Position = 2, Mandatory = $False)]
        [string]$MSBuildExecutablePath
    )
		
    Process {
        $pathExists = Test-Path $WebProjectFilePath
        if ($pathExists -eq $False) {
            Throw "Path '$WebProjectFilePath' not found."
        }
        if ([string]::IsNullOrEmpty($MSBuildExecutablePath)) {
            Write-Verbose "`$MSBuildExecutablePath not set."
            $MSBuildExecutablePath = Get-MSBuild
        }
        Write-Verbose "Using '$MSBuildExecutablePath'."
        Write-Information "Publishing '$WebProjectFilePath' to '$OutputDirectory'."
        & "$MSBuildExecutablePath" "$WebProjectFilePath" /t:WebPublish /verbosity:minimal /p:publishUrl="$OutputDirectory" /p:DeployOnBuild="true" /p:DeployDefaultTarget="WebPublish" /p:WebPublishMethod="FileSystem" /p:DeleteExistingFiles="false" /p:_FindDependencies="false" /p:MSDeployUseChecksum="true"
        Write-Verbose "Exit code '$LASTEXITCODE'."
    }
}

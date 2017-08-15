. "..\Shared\Get-MSBuild.ps1"

Function Publish-HelixProject {
    [CmdletBinding()]
    Param (
        [Parameter(Position = 0, Mandatory = $True, ValueFromPipeline)]
        [string]$HelixProjectPath,
        [Parameter(Position = 1, Mandatory = $True)]
        [string]$PublishUrlOrDirectory,
        [Parameter(Position = 2, Mandatory = $False)]
        [string]$MSBuildExecutablePath
    )
		
    Process {
		$pathExists = Test-Path $HelixProjectPath
        if ($pathExists -eq $False) {
            Throw "Path '$HelixProjectPath' not found."
        }
		if([string]::IsNullOrEmpty($MSBuildExecutablePath)) {
			Write-Verbose "`$MSBuildExecutablePath not set."
			$MSBuildExecutablePath = Get-MSBuild | Select-Object -ExpandProperty FullName
		}
		Write-Verbose "Using '$MSBuildExecutablePath'"
        Write-Information "Publishing '$HelixProjectPath' to '$PublishUrlOrDirectory'."
		& "$MSBuildExecutablePath" "$HelixProjectPath" /t:WebPublish /verbosity:minimal /p:publishUrl="$PublishUrlOrDirectory" /p:DeployOnBuild="true" /p:DeployDefaultTarget="WebPublish" /p:WebPublishMethod="FileSystem" /p:DeleteExistingFiles="false" /p:_FindDependencies="false" /p:MSDeployUseChecksum="true"
		Write-Verbose "Exit code '$LASTEXITCODE'."
    }
}

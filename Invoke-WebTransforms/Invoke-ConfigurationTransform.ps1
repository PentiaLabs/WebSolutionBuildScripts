. "$PSScriptRoot\..\Shared\Get-MSBuild.ps1"

Function Invoke-ConfigurationTransform {
    [CmdletBinding()]
    Param (
        [Parameter(Position = 0, Mandatory = $True, ValueFromPipeline)]
        [string]$ConfigurationFilePath,
        [Parameter(Position = 1, Mandatory = $True)]
        [string]$BuildConfiguration,
        [Parameter(Position = 2, Mandatory = $True)]
        [string]$OutputFilePath,
        [Parameter(Position = 3, Mandatory = $False)]
        [string]$MSBuildExecutablePath
    )

    Process {
        if ([string]::IsNullOrEmpty($MSBuildExecutablePath)) {
            Write-Verbose "`$MSBuildExecutablePath not set."
            $MSBuildExecutablePath = Get-MSBuild
        }
        Write-Verbose "Using '$MSBuildExecutablePath'."
        & "$MSBuildExecutablePath" ./applytransform.targets /target:"ApplyTransform" /property:Configuration="$BuildConfiguration" /p:WebConfigToTransform="$OutputFilePath" /p:TransformFile="$ConfigurationFilePath" /p:FileToTransform="$($_.Name)"
    }

}
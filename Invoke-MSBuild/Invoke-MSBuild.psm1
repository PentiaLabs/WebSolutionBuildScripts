<#
.SYNOPSIS
Invokes MSBuild.exe.

.PARAMETER ProjectOrSolutionFilePath
Path to the project or solution to build. Can be piped.

.PARAMETER BuildConfiguration
The build configuration to use. Leave blank to use each project's default configuration (usually "Debug").

.PARAMETER BuildArgs
Additional arguments for MSBuild.exe, e.g. "/target:WebPublish", "/property:PublishUrl:<destination>" etc.
See the official documentation for details: https://msdn.microsoft.com/en-us/library/ms164311.aspx.

.EXAMPLE
Get-WebProject -SolutionRootPath $PWD | Invoke-MSBuild -BuildConfiguration "Staging"
Gets all web projects found under the current working directory, and invokes their default build target using the build configuration "Staging".

Get-WebProject -SolutionRootPath $PWD | Invoke-MSBuild -BuildConfiguration "Staging" -BuildArgs "/t:WebPublish", "/p:PublishUrl:C:\Output", "/p:WebPublishMethod=FileSystem"
Gets all web projects found under the current working directory, and invokes the "WebPublish" build target with the output path "C:\Output", using the build configuration "Staging".
#>
Function Invoke-MSBuild {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $True, ValueFromPipeline = $True)]
        [string]$ProjectOrSolutionFilePath,

        [Parameter(Mandatory = $False)]
        [string]$BuildConfiguration,

        [Parameter(Mandatory = $False)]
        [string[]]$BuildArgs
    )

    Process {
        If (-not (Test-Path -Path $ProjectOrSolutionFilePath -PathType Leaf)) {
            Throw "Project or solution file '$ProjectOrSolutionFilePath' not found."
        }
        $msBuildExecutablePath = Get-MSBuild
        If (-not $BuildArgs) {
            $BuildArgs = @()
            $BuildArgs += """/maxcpucount""" # Blank means all CPUs. Else use e.g. "/maxcpucount:4"
        }
        If (-not [System.String]::IsNullOrWhiteSpace($BuildConfiguration)) {
            $BuildArgs += """/property:Configuration=$BuildConfiguration"""
        }        
        $BuildArgs += """$ProjectOrSolutionFilePath"""
        & $msBuildExecutablePath $BuildArgs
        If ($LASTEXITCODE -ne 0) {
            Throw "Failed to build '$ProjectOrSolutionFilePath'."
        }
    }
}

Export-ModuleMember -Function Invoke-MSBuild

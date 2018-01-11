<#
.SYNOPSIS
Invokes MSBuild.exe.

.PARAMETER ProjectOrSolutionFilePath
Path to the project or solution to build. Can be piped.

.PARAMETER BuildConfiguration
The build configuration to use. Leave blank to use each project's default configuration (usually "Debug").

.EXAMPLE
Get-WebProject -SolutionRootPath $PWD | Invoke-MSBuild -BuildConfiguration "Staging"
Builds all web projects found under the current working directory, using the build configuration "Staging".
#>
Function Invoke-MSBuild {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $True, ValueFromPipeline = $True)]
        [string]$ProjectOrSolutionFilePath,

        [Parameter(Mandatory = $False)]
        [string]$BuildConfiguration
    )

    Process {
        If (-not (Test-Path -Path $ProjectOrSolutionFilePath -PathType Leaf)) {
            Throw "Project or solution file '$ProjectOrSolutionFilePath' not found."
        }
        $msBuildExecutablePath = Get-MSBuild
        $msBuildArgs = @()
        $msBuildArgs += """/maxcpucount""" # Blank means all CPUs. Else use e.g. "/maxcpucount:4"
        If (-not [System.String]::IsNullOrWhiteSpace($BuildConfiguration)) {
            $msBuildArgs += """/property:Configuration=$BuildConfiguration"""
        }        
        $msBuildArgs += """$ProjectOrSolutionFilePath"""
        & $msBuildExecutablePath $msBuildArgs
        If ($LASTEXITCODE -ne 0) {
            Throw "Failed to build '$ProjectOrSolutionFilePath'."
        }
    }
}

Export-ModuleMember -Function Invoke-MSBuild
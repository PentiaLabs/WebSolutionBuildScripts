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
        [Parameter(Mandatory = $True, ValueFromPipeline)]
        [string]$WebProjectFilePath,
        
        [Parameter(Mandatory = $True)]
        [string]$OutputPath,

        [Parameter(Mandatory = $False)]
        [string]$MSBuildExecutablePath
    )
		
    Process {
        If (!(Test-Path $WebProjectFilePath -PathType Leaf)) {
            Throw "File path '$WebProjectFilePath' not found."
        }
        If ([string]::IsNullOrEmpty($MSBuildExecutablePath)) {
            Write-Verbose "`$MSBuildExecutablePath not set."
            $MSBuildExecutablePath = Get-MSBuild
        }
        If (!(Test-Path $MSBuildExecutablePath -PathType Leaf)) {
            Throw "File path '$MSBuildExecutablePath' not found."
        }
        If (-not ([System.IO.Path]::IsPathRooted($OutputPath))) {
            $OutputPath = [System.IO.Path]::Combine($PWD, $OutputPath)
        }
        Write-Verbose "Using '$MSBuildExecutablePath'."
        Write-Verbose "Publishing '$WebProjectFilePath' to '$OutputPath'."
        $output = (& "$MSBuildExecutablePath" "$WebProjectFilePath" /t:WebPublish /p:PublishUrl="$OutputPath" /p:WebPublishMethod="FileSystem" /p:DeleteExistingFiles="false" /p:MSDeployUseChecksum="true") | Out-String
        If ($LASTEXITCODE -eq 0) {
            Write-Verbose $output
        }
        Else {
            Write-Error $output
            Throw "Error publishing project '$WebProjectFilePath'."
        }
    }
}

<# 
 .SYNOPSIS
 Publishes a web project to the specified output directory using MSBuild and applies all relevant XDTs.
 
 .DESCRIPTION
 Publishes a web project to the specified output directory using MSBuild and applies all relevant XDTs. The XDTs are then deleted.
 Optional function parameters which are omitted, will be read from the settings found in "<solution root>\.pentia\user-settings.json".
 If no settings file exists, the user is prompted for input.

 .PARAMETER WebProjectFilePath
 Absolute or relative path of the web project file.

 .PARAMETER OutputPath
 Absolute or relative path of the output directory.

 .EXAMPLE 
 Publish-ConfiguredWebProject -WebProjectFilePath "C:\Path\To\MyProject.csproj" -OutputPath "C:\Websites\MyWebsite" -BuildConfiguration "Debug"
 Publish a project, and apply all XDTs for the "Debug" configuration.

 .EXAMPLE 
 Publish-ConfiguredWebProject -WebProjectFilePath "C:\Path\To\MyProject.csproj" -OutputPath "C:\Websites\MyWebsite" -BuildConfiguration "Debug" -MSBuildExecutablePath "C:\Path\To\MsBuild.exe"
 Publish a project, apply all XDTs for the "Debug" configuration, and use the specified MSBuild.exe.

 "./MyProject.csproj" | Publish-ConfiguredWebProject
 Publish the project "MyProject.csproj", using the settings found in "<solution root>\.pentia\user-settings.json".

 Get-WebProject | Publish-ConfiguredWebProject
 Retrive all web projects in or under the current directory, and publish them using the settings found in "<solution root>\.pentia\user-settings.json".
#>   
Function Publish-ConfiguredWebProject {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $True, ValueFromPipeline)]
        [string]$WebProjectFilePath,

        [Parameter(Mandatory = $False)]
        [string]$WebrootOutputPath,

        [Parameter(Mandatory = $False)]
        [string]$DataOutputPath,

        [Parameter(Mandatory = $False)]
        [string]$BuildConfiguration
    )
    Process {
        if (-not (Test-Path $WebProjectFilePath -PathType Leaf)) {
            Throw "File path '$WebProjectFilePath' not found."
        }
        $solutionRootPath = $WebProjectFilePath | Find-SolutionRootPath
        $settings = Get-MergedParametersAndUserSettings -SolutionRootPath $solutionRootPath -WebrootOutputPath $WebrootOutputPath -DataOutputPath $DataOutputPath -BuildConfiguration $BuildConfiguration
        Publish-WebProject -WebProjectFilePath $WebProjectFilePath -OutputPath $settings.webrootOutputPath
        $projectDirectory = [System.IO.Path]::GetDirectoryName($WebProjectFilePath)
        Invoke-AllConfigurationTransforms -SolutionOrProjectRootPath $projectDirectory -WebrootOutputPath $settings.webrootOutputPath -BuildConfiguration $settings.buildConfiguration
        # Delete XDTs
        Get-ConfigurationTransformFile -SolutionRootPath $settings.webrootOutputPath | ForEach-Object { Remove-Item -Path $_ }
    }
}

Function Find-SolutionRootPath {
    [CmdletBinding()]
    [OutputType([String])]
    Param (
        [Parameter(Mandatory = $True, ValueFromPipeline)]
        [string]$SearchStartPath
    )
    Process {
        if (-not (Test-Path $SearchStartPath)) {
            Throw "Path '$SearchStartPath' not found."
        }
        $absoluteSearchStartPath = Resolve-Path $SearchStartPath
        if (Test-Path $absoluteSearchStartPath -PathType Leaf) {
            $directory = [System.IO.Path]::GetDirectoryName($absoluteSearchStartPath)            
        }
        else {
            $directory = $absoluteSearchStartPath
        }

        $userSettingsFilePath = Get-UserSettingsFilePath -SolutionRootPath $directory
        if (Test-Path $userSettingsFilePath) {
            return "$directory"
        }

        $parent = Split-Path $directory -Parent
        if ([String]::IsNullOrWhiteSpace($parent)) {
            return $Null
        }

        Find-SolutionRootPath -SearchStartPath $parent
    }
}

Export-ModuleMember -Function Publish-WebProject, Publish-ConfiguredWebProject

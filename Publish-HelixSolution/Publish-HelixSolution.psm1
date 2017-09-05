Import-Module "$PSScriptRoot\..\Publish-RuntimeDependencyPackage\Get-RuntimeDependencyPackage.psm1" -Force
Import-Module "$PSScriptRoot\..\Publish-RuntimeDependencyPackage\Publish-RuntimeDependencyPackage.psm1" -Force

Import-Module "$PSScriptRoot\..\Publish-WebProject\Get-SitecoreHelixProject.psm1" -Force
Import-Module "$PSScriptRoot\..\Publish-WebProject\Publish-WebProject.psm1" -Force

Import-Module "$PSScriptRoot\..\ConfigurationTransformFile\Get-ConfigurationTransformFile.ps1" -Force
Import-Module "$PSScriptRoot\..\Invoke-ConfigurationTransform\Invoke-ConfigurationTransform.psm1" -Force

Function Publish-HelixSolution {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $False)]
        [string]$SolutionRootPath,

        [Parameter(Mandatory = $True)]
        [string]$WebrootOutputPath,

        [Parameter(Mandatory = $True)]
        [string]$DataOutputPath,

        [Parameter(Mandatory = $True)]
        [string]$BuildConfiguration
    )

    If ([string]::IsNullOrWhiteSpace($SolutionRootPath)) {
        $SolutionRootPath = $MyInvocation.PSCommandPath
        Write-Verbose "`$SolutionRootPath not set. Using '$SolutionRootPath'."
    }

    # If output is set to "Verbose", set "$PSDefaultParameterValues:['*:Verbose'] = $True"
    # If output is set to "Debug", set "$PSDefaultParameterValues:['*:Debug'] = $True"
    # etc.

    # 1. Delete $WebrootOutputPath
    Remove-WebrootOutputPath -WebrootOutputPath $WebrootOutputPath

    # 2. Publish runtime dependencies
    Publish-RuntimeDependency -SolutionRootPath $SolutionRootPath -WebrootOutputPath $WebrootOutputPath -DataOutputPath $DataOutputPath

    # 3. Publish all web projects on top of the published runtime dependencies
    Get-SitecoreHelixProject -SolutionRootPath $SolutionRootPath | Publish-WebProject -OutputPath $WebrootOutputPath

    # 4. Invoke configuration transforms
    Invoke-Transform -SolutionRootPath $SolutionRootPath -WebrootOutputPath $WebrootOutputPath -BuildConfiguration $BuildConfiguration
}

Function Remove-WebrootOutputPath {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $True)]
        [string]$WebrootOutputPath
    )
    If (Test-Path $WebrootOutputPath -PathType Container) {
        Write-Verbose "Deleting '$WebrootOutputPath' and all contents."
        Remove-Item -Path $WebrootOutputPath -Recurse -Force
    }
}

Function Publish-RuntimeDependency {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $True)]
        [string]$SolutionRootPath,

        [Parameter(Mandatory = $True)]
        [string]$WebrootOutputPath,

        [Parameter(Mandatory = $True)]
        [string]$DataOutputPath
    )
    $runtimeDependencyConfigurationFileName = "runtime-dependencies.config"
    $runtimeDependencyConfigurationFilePath = [System.IO.Path]::Combine($SolutionRootPath, $runtimeDependencyConfigurationFileName)
    If (Test-Path $runtimeDependencyConfigurationFilePath -PathType Leaf) {
        $runtimeDependencies = Get-RuntimeDependencyPackage -ConfigurationFilePath $RuntimeDependencyConfigurationFilePath
        foreach ($runtimeDependency in $runtimeDependencies) {
            Publish-RuntimeDependencyPackage -WebrootOutputPath $WebrootOutputPath -DataOutputPath $DataOutputPath -PackageName $runtimeDependency.id -PackageVersion $runtimeDependency.version
        }
    }
    Else {
        Write-Verbose "No '$runtimeDependencyConfigurationFileName' file found in '$SolutionRootPath'. Skipping runtime package installation."
    }
}

Function Invoke-Transform {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $True)]
        [string]$SolutionRootPath,

        [Parameter(Mandatory = $True)]
        [string]$WebrootOutputPath,
        
        [Parameter(Mandatory = $True)]
        [string]$BuildConfiguration
    )
    $xdtFiles = Get-ConfigurationTransformFile -SolutionRootPath $SolutionRootPath -BuildConfiguration $BuildConfiguration
    foreach ($xdtFile in $xdtFiles) {
        $fileToTransform = Get-PathOfFileToTransform -ConfigurationTransformFilePath $xdtFile -WebrootOutputPath $WebrootOutputPath
        Invoke-ConfigurationTransform -XmlFilePath $fileToTransform -XdtFilePath $xdtFile | Set-Content -Path $fileToTransform
    }
}

Export-ModuleMember -Function Publish-HelixSolution

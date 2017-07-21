. .\get-solutionfolder.ps1
Function Push-HelixConfigurations {
	[CmdletBinding()]
	Param(
		[Parameter(Position = 0, ValueFromPipeline)]
		[string]$ConfigurationFilePath,
		[Parameter(Position = 1)]
		[string]$Buildconfiguration,
		[Parameter(Position = 2)]
		[string]$WebrootPath)

	Process {
		
		if ([string]::IsNullOrEmpty($Buildconfiguration)) {
			$Buildconfiguration = "debug";
		}

		if ([string]::IsNullOrEmpty($WebrootPath)) {
			$WebrootPath = get-solutionconfig -Path $(get-solutionfolder -Path $ConfigurationFilePath) -BuildConfig $Buildconfiguration | Select-Object -ExpandProperty websiteRoot;
		}

		& "C:\Program Files (x86)\MSBuild\14.0\Bin\MSBuild.exe" ./applytransform.targets /target:"ApplyTransform" /property:Configuration="$Buildconfiguration" /p:WebConfigToTransform="$webRootPath" /p:TransformFile="$($_.FullName)" /p:FileToTransform="$($_.Name)"
	}

}
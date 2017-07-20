. .\get-msbuild.ps1
. .\get-solutionconfig.ps1
Function publish-helixproject {
	[CmdletBinding()]
	Param(
		[Parameter(Position = 0, ValueFromPipeline)]
		[string]$ProjectPath,
		[Parameter(Position = 1)]
		[string]$WebrootPath)
        
	Process {

		if ([string]::IsNullOrEmpty($WebrootPath)) {
			$WebrootPath = get-solutionconfig -Path "D:\projects\hc" | Select-Object -ExpandProperty websiteRoot;
		}

		$msbuildPath = get-msbuild | Select-Object -ExpandProperty FullName
		& "$msbuildPath" $_.FullName /t:WebPublish /verbosity:minimal /p:DeployOnBuild="true" /p:DeployDefaultTarget="WebPublish" /p:WebPublishMethod="FileSystem" /p:DeleteExistingFiles="false" /p:publishUrl=$WebrootPath /p:_FindDependencies="false" /p:MSDeployUseChecksum="true" 
	}

}

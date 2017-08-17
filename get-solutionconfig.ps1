Function get-solutionconfig {
	[CmdletBinding()]
	Param(
		[Parameter(Position = 0)]
		[string]$BuildConfig,
		[Parameter(Position = 1)]
		[string]$Path)


	if ([string]::IsNullOrEmpty($BuildConfig)) {
		$BuildConfig = "debug";
	}

	if ([string]::IsNullOrEmpty($Path)) {
		$Path = $PSScriptRoot;
	}

	$jsonConfig = Get-Content -Path $Path\solution-config.json -Raw | ConvertFrom-Json;
	$config = $jsonConfig.configs | Where-Object -Property Name -EQ $buildConfig
	$config
}



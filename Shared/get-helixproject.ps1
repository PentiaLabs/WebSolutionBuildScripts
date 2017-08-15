Function get-helixproject {
	[CmdletBinding()]
	Param(
		[Parameter(Position = 0)]
		[string]$Path,
		[Parameter(Position = 1)]
		[ValidateSet('Feature', 'Foundation', 'Project')]
		[string]$Layer)
	
	if ([string]::IsNullOrEmpty($Path)) {
		$path = $PSScriptRoot;
	}
	
	$projects = get-childitem -Path $path -Recurse *.csproj -Exclude *test*
	$helixProjects = $projects | Select-Object  @{n = "FullName"; e = {$_.FullName}}, @{n = "Layer"; e = {$_.FullName.Remove(0, $_.FullName.IndexOf("src") + 4).Split("\") | select -First 1}},@{n = "ProjectPath"; e = {$Path}}
	
	$LayerIsEmpty = [string]::IsNullOrEmpty($Layer)
	if (-not $LayerIsEmpty) {
		$helixProjects = $helixProjects | Where-Object -Property Layer -EQ $Layer
	}
	
	$helixProjects
}
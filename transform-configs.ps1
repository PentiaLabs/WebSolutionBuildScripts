param(
	[Parameter(Mandatory=$true)]
    [string]$buildConfig,
    [Parameter(Mandatory=$true)]
    [string]$webRootPath)

$include = @("*.$($buildConfig).config", "*.release.config")
get-childitem -Include $include -Recurse -Exclude "web.*.config" | Select-Object -Property FullName,@{Name="Name";Expression= {$_.FullName.ToLower().Replace(".$($buildConfig.ToLower())","").Replace(".release","").Remove(0,$_.FullName.IndexOf("App_Config"))} }  | foreach { & "C:\Program Files (x86)\MSBuild\14.0\Bin\MSBuild.exe" ./node_modules/@pentia/configuration-transformer/applytransform.targets /target:"ApplyTransform" /property:Configuration="$buildConfig" /p:WebConfigToTransform="$webRootPath" /p:TransformFile="$($_.FullName)" /p:FileToTransform="$($_.Name)" }


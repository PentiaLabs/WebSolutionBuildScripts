function test-configfile($file)
{
	$xdoc = New-Object System.Xml.XmlDocument
	$xdoc.Load($file)
	Write-Output ($xdoc.DocumentElement.xdt -eq "http://schemas.microsoft.com/XML-Document-Transform")
}

$configurations = Get-ChildItem -Recurse *.config -Exclude "web.*.config" -Path "D:\Projects\hc" | Where-Object { $_.FullName -NotLike "*\obj*" -and $_.FullName -notlike "*\bin*" } | Where-Object { test-configfile -file $_ -eq $true}

foreach { & "C:\Program Files (x86)\MSBuild\14.0\Bin\MSBuild.exe" ./node_modules/@pentia/configuration-transformer/applytransform.targets /target:"ApplyTransform" /property:Configuration="$buildConfig" /p:WebConfigToTransform="$webRootPath" /p:TransformFile="$($_.FullName)" /p:FileToTransform="$($_.Name)" }
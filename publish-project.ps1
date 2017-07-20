param(
    [Parameter(Mandatory=$true)]
    [string]$webRootPath)

get-childitem *.csproj -Recurse -Exclude "*Tests*" | Select-Object -ExpandProperty FullName | foreach { & "C:\Program Files (x86)\MSBuild\14.0\Bin\MSBuild.exe" $_ /t:WebPublish /verbosity:minimal /p:DeployOnBuild="true" /p:DeployDefaultTarget="WebPublish" /p:WebPublishMethod="FileSystem" /p:DeleteExistingFiles="false" /p:publishUrl=$webRootPath /p:_FindDependencies="false" /p:MSDeployUseChecksum="true" }

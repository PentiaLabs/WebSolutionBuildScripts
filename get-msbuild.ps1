Import-Module VSSetup 
& $(Get-VSSetupInstance | get-childitem -Path { $_.InstallationPath }  -Filter msbuild.exe -Recurse | select -First 1 -ExpandProperty FullName)
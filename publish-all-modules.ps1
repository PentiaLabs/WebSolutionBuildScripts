$numberOfRepositoriesNamedTund = Get-PSRepository Tund | measure | Select-Object -ExpandProperty	Count 

if($numberOfRepositoriesNamedTund -lt 1)
{
	Register-PSRepository -Name Tund -SourceLocation http://tund/nuget/powershell/ -PublishLocation http://tund/nuget/powershell/
}

get-module -Name .\**\*.psd1 -ListAvailable | Select-Object -ExpandProperty ModuleBase | % { Publish-Module -Path $_ -NuGetApiKey ***REMOVED*** -Repository Tund -Force }
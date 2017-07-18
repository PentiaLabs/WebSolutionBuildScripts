#Get variables

$buildConfig = "debug";

$jsonConfig = Get-Content -Path .\solution-config.json -Raw | ConvertFrom-Json;
$config = $jsonConfig.configs | where -Property Name -EQ $buildConfig


# delete-website
remove-item -force -recurse -Path $config.websiteRoot 
# install-packages
.\powershell-scripts\install-packages.ps1 -packagesFileLocation .\solution-packages.json -webRootPath $config.websiteRoot -dataRootPath $config.websiteDataRoot
# publish-all-layers
.\publish.ps1 -webRootPath $config.websiteRoot
# transform-configs
.\transform-configs.ps1 -buildConfig $buildConfig -webRootPath $config.websiteRoot
# copy-license
copy-item -Path "\\buildlibrary\library\Sitecore License\Pentia 8.x\www\Data\pentia.license.xml" -Destination "$($config.websiteDataRoot)\license.xml"
# sync
.\Autosync-Scripts\autosync-unicorn.ps1
$path = "D:\Projects\HC"
$projects = get-childitem -Path $path -Recurse *.csproj 
$helixProjects = $projects | Select-Object  @{n="FullName"; e={$_.FullName}},@{n="Layer"; e={$_.FullName.Remove(0,$_.FullName.IndexOf("src")+4).Split("\") | select -First 1}}
$helixProjects 
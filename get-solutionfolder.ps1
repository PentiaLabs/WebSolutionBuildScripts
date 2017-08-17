Function get-solutionfolder {
	[CmdletBinding()]
	Param(
		[Parameter(Position = 0)]
		[string]$Path)

		Get-ParentPaths -Path $Path | get-childitem -Filter *.sln
    
}
function Get-ParentPaths
{
	[CmdletBinding()]
	Param(
		[Parameter(Position = 0)]
		[string]$Path)

    $Item = Get-Item -Path $Path
    if ($Item.FullName -ne $Item.Root.FullName)
    {
        Get-ParentPaths -Path $Item.Parent.FullName
        $Item.FullName
    }
    else
    {
        $Item.FullName
    }
}
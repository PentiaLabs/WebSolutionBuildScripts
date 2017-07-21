function test-transformfile {
	[CmdletBinding()]
	Param(		
		[Parameter(Position = 0)]
		[string]$FullPath)

	$xdoc = New-Object System.Xml.XmlDocument
	$xdoc.Load($FullPath)
	Write-Output ($xdoc.DocumentElement.xdt -eq "http://schemas.microsoft.com/XML-Document-Transform")
}
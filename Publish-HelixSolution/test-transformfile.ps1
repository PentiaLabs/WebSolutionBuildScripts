# Check whether or not a given XML file is a WebTransform-file based on the value of the XDT-attribute.
function Test-TransformFile {
	[CmdletBinding()]
	Param(		
		[Parameter(Position = 0)]
		[string]$FullPath)

	$xdoc = New-Object System.Xml.XmlDocument
	$xdoc.Load($FullPath)
	Write-Output ($xdoc.DocumentElement.xdt -eq "http://schemas.microsoft.com/XML-Document-Transform")
}
. .\test-transformfile.ps1
Function get-helixconfigs {
	[CmdletBinding()]
	Param(		
		[Parameter(Position = 0)]
		[string]$Path)
	
	Get-ChildItem -Recurse *.config -Exclude "web.*.config" -Path $Path | Where-Object { $_.FullName -NotLike "*\obj*" -and $_.FullName -notlike "*\bin*" } | Where-Object { $(test-transformfile -FullPath $_) -eq $true}
}


function Get-WebRequestFromUrl (
    [Parameter(Mandatory=$true)]
    [string]$url
)
{
$HTTP_Request = [System.Net.WebRequest]::Create($url)

try {
    $res = $HTTP_Request.GetResponse()
} catch [System.Net.WebException] {
    $res = $_.Exception.Response
}

Write-Output $res
}
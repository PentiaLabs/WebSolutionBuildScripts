Function Get-WebRequestFromUrl {
    Param(        
        [Parameter(Mandatory = $true)]
        [string]$url
    )
    $httpRequest = [System.Net.WebRequest]::Create($url)
    try {
        $res = $httpRequest.GetResponse()
    }
    catch [System.Net.WebException] {
        $res = $_.Exception.Response
    }
    Write-Output $res
}
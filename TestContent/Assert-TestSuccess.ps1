Param (
    [Parameter(Mandatory = $True)]
    [string]$NUnitFormattedTestResultFilePath
)

[xml]$results = Get-Content $NUnitFormattedTestResultFilePath
$failures = $results.SelectNodes("//test-case[@result='Failure']")
$failures | Select-Object -Property "name", "description" | Write-Error

Exit $failures.Count

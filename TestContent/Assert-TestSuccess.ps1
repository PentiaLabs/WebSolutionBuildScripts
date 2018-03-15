param (
    [Parameter(Mandatory = $true)]
    [string]$NUnitFormattedTestResultFilePath
)

[xml]$results = Get-Content $NUnitFormattedTestResultFilePath
$failures = $results.SelectNodes("//test-case[@result='Failure']")
$failures | Select-Object -Property "name", "description" | Write-Error

exit $failures.Count

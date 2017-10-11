Function New-HelixSolutionPackage {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $True)]
        [string]$SolutionRootPath,

        [Parameter(Mandatory = $True)]
        [string]$WebrootOutputPath,

        [Parameter(Mandatory = $True)]
		[string]$DataOutputPath,
		
        [Parameter(Mandatory = $True)]
        [string]$BuildConfiguration
    )


    
}


Export-ModuleMember -Function Package-HelixSolution

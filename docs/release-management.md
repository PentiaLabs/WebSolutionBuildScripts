## Release management

To create a new release of the Sitecore Helix Build Scripts, do the following:

1. Update all `.psd` files with the new script version as appropriate.
2. Run `Publish-AllModules.ps1`.
3. Update all TeamCity build agents using the script shown below.

```powershell
Function Invoke-CommandOnMachine {
    Param (      
      [string[]] $MachineNames,
      [string] $UserName,
      [string] $Password
    )
    
    $passwordAsSecureString = ConvertTo-SecureString -AsPlainText $Password -Force
    $credentials = New-Object System.Management.Automation.PSCredential -ArgumentList $UserName, $passwordAsSecureString

    Invoke-Command -ComputerName $MachineNames -ScriptBlock { 
        Install-Module "Publish-HelixSolution" -Force
        Get-Module "Publish-HelixSolution" -ListAvailable
    } -Credential $credentials
}

$machineNames = @("teambuild01","teambuild02","teambuild03","teambuild04","teambuild05")
Invoke-CommandOnMachine -MachineNames $machineNames -UserName "teamcity" -Password "<PASSWORD GOES HERE>"
```

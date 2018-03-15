## Release management

To create a new release of the Build Scripts, do the following:

1. Update all `.psd` files with the new script version as appropriate.
2. Generate a Personal Access Token (PAT) with "Package read/write" access via https://pentia.visualstudio.com/_details/security/tokens.
3. Run `Publish-AllModules.ps1 -Username <VSTS username> -PersonalAccessToken <PAT>`.
4. Update all TeamCity build agents using the script shown below.

```powershell
function Invoke-CommandOnMachine {
    param (      
      [string[]] $MachineNames,
      [string] $UserName,
      [string] $Password
    )
    
    $passwordAsSecureString = ConvertTo-SecureString -AsPlainText $Password -Force
    $credentials = New-Object System.Management.Automation.PSCredential -ArgumentList $UserName, $passwordAsSecureString

    Invoke-Command -ComputerName $MachineNames -ScriptBlock { 
        Install-Module "Publish-WebSolution" -Force
        Get-Module "Publish-WebSolution" -ListAvailable
    } -Credential $credentials
}

$machineNames = @("teambuild01","teambuild02","teambuild03","teambuild04","teambuild05")
Invoke-CommandOnMachine -MachineNames $machineNames -UserName "teamcity" -Password "<PASSWORD GOES HERE>"
```

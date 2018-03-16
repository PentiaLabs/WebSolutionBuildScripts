## Release management

To create a new release of the Build Scripts, do the following:

1. Update all `.psd` files with the new script version as appropriate.
2. Log in to the [PowerShell Gallery](https://www.powershellgallery.com) with the  user it@pentia.dk. The password is available through LastPass.
3. Copy the NuGet API shown at the bottom of the [PowerShell Gallery account page](https://www.powershellgallery.com/account).
4. Run `Publish-AllModules.ps1 -NuGetApiKey <API key from PowerShell Gallery>`.
5. Update all TeamCity build agents using the script shown below. The password can be obtained from it@pentia.dk.

```powershell
function Install-BuildScriptsOnRemoteMachine {
    param (      
      [string[]] $MachineNames,
      [string] $UserName,
      [string] $Password
    )
    
    $passwordAsSecureString = ConvertTo-SecureString -AsPlainText $Password -Force
    $credentials = New-Object System.Management.Automation.PSCredential -ArgumentList $UserName, $passwordAsSecureString

    Invoke-Command -ComputerName $MachineNames -ScriptBlock { 
        PowerShellGet\Install-Module -Name "Pentia.Publish-WebSolution" -Force
        Get-Module -Name "Pentia.Publish-WebSolution" -ListAvailable
    } -Credential $credentials
}

$machineNames = @("teambuild01","teambuild02","teambuild03","teambuild04","teambuild05")
Install-BuildScriptsOnRemoteMachine -MachineNames $machineNames -UserName "teamcity" -Password "<PASSWORD GOES HERE>"
```

<#
.SYNOPSIS
Stores a UserSettings-object to "$SolutionRootPath/.pentia/user-settings.json". Any existing file is overwritten.

.PARAMETER SolutionRootPath
OPTIONAL - Settings are saved to "$SolutionRootPath/.pentia/user-settings.json". The current directory ($PWD) is used as a fallback.

.PARAMETER Settings
A simple settings object containing webroot, data folder and build configuration settings.

.EXAMPLE
Set-UserSettings -Settings @{ webrootOutputPath = "$TestDrive\www"; dataOutputPath = "$TestDrive\data"; BuildConfiguration = "Debug"}
Saves the specified user settings to "<current directory>/.pentia/user-settings.json".
#>
Function Set-UserSettings {
    [CmdletBinding(SupportsShouldProcess = $True)]
    Param (
        [Parameter(Mandatory = $False)]
        [string]$SolutionRootPath,

        [Parameter(Mandatory = $True)]
        [UserSettings]$Settings
    )
    $settingsFilePath = Get-UserSettingsFilePath -SolutionRootPath $SolutionRootPath
    If (-not $pscmdlet.ShouldProcess($settingsFilePath, "Save and overwrite settings file")) {
        return
    }
    Write-Verbose "Saving user settings to '$settingsFilePath'."
    New-Item -Path $settingsFilePath -Force | Out-Null
    $SERIALIZATION_MAX_DEPTH = 100 # 100 is the maximum supported by "ConvertTo-Json"
    $Settings | ConvertTo-Json -Depth $SERIALIZATION_MAX_DEPTH | Out-File $settingsFilePath -Force
}

<#
.SYNOPSIS
Concatenates the provided path and the relative user settings file path (".\.pentia\user-settings.json").

.PARAMETER SolutionRootPath
OPTIONAL: The path to concatenate. If omitted, the current working directory is used.

.EXAMPLE
Get-UserSettingsFilePath
Return "<current working directory>\.pentia\user-settings.json"

Get-UserSettingsFilePath -SolutionRootPath "C:\Some-Path\"
Return "C:\Some-Path\.pentia\user-settings.json"
#>
Function Get-UserSettingsFilePath {
    [CmdletBinding()]
    [OutputType([System.String])]
    Param (
        [Parameter(Mandatory = $False)]
        [string]$SolutionRootPath
    )
    If ([string]::IsNullOrWhiteSpace($SolutionRootPath)) {
        $SolutionRootPath = $PWD
    }
    If (-not (Test-Path $SolutionRootPath)) {
        Throw "Path '$SolutionRootPath' not found."
    }
    $absoluteSolutionRootPath = Resolve-Path $SolutionRootPath
    [System.IO.Path]::Combine($absoluteSolutionRootPath, ".pentia", "user-settings.json")
}

<#
.SYNOPSIS
Loads a UserSettings-object from "$SolutionRootPath/.pentia/user-settings.json".

.PARAMETER SolutionRootPath
OPTIONAL - Settings are loaded from "$SolutionRootPath/.pentia/user-settings.json". The current directory ($PWD) is used as a fallback.

.EXAMPLE
$settings = Get-UserSettings
Returns the previously saved user settings, or an empty object.
#>
Function Get-UserSettings {
    [CmdletBinding()]
    [OutputType([UserSettings])]
    Param (
        [Parameter(Mandatory = $False)]
        [string]$SolutionRootPath
    )
    $settingsFilePath = Get-UserSettingsFilePath -SolutionRootPath $SolutionRootPath
    If (Test-Path $settingsFilePath) {
        Write-Verbose "Reading user settings from '$settingsFilePath'."
        Get-Content -Path $settingsFilePath | ConvertFrom-Json
    }
    Else {        
        Write-Verbose "No user settings found in '$settingsFilePath'."
        New-Object -TypeName UserSettings
    }
}

<#
.SYNOPSIS
Uses the specified settings as a fallback for each parameter that's null, empty or whitespace.
The intent is to provide a mechanism for overriding saved values while minimizing the need for mandatory parameters.

.EXAMPLE
Merge-ParametersAndUserSettings -Settings @{webrootOutputPath = "C:\Website\www"} -WebrootOutputPath $Null
Returns @{webrootOutputPath = "C:\Website\www"}

Merge-ParametersAndUserSettings -Settings @{webrootOutputPath = "C:\Website\www"} -WebrootOutputPath "C:\SomeOtherFolder\www"
Returns @{webrootOutputPath = "C:\SomeOtherFolder\www"}
#>
Function Merge-ParametersAndUserSettings {
    [CmdletBinding()]
    [OutputType([UserSettings])]
    Param (
        [Parameter(Mandatory = $True)]
        [UserSettings]$Settings,

        [Parameter(Mandatory = $False)]
        [string]$WebrootOutputPath,

        [Parameter(Mandatory = $False)]
        [string]$DataOutputPath,

        [Parameter(Mandatory = $False)]
        [string]$BuildConfiguration
    )

    If ([System.String]::IsNullOrWhiteSpace($WebrootOutputPath)) {
        Write-Verbose "`$WebrootOutputPath is null or empty. Using setting value '$($Settings.webrootOutputPath)'."
    }
    Else {
        $Settings.webrootOutputPath = $WebrootOutputPath        
    }

    If ([System.String]::IsNullOrWhiteSpace($DataOutputPath)) {
        Write-Verbose "`$DataOutputPath is null or empty. Using setting value '$($Settings.dataOutputPath)'."
    }
    Else {
        $Settings.dataOutputPath = $DataOutputPath
    }

    If ([System.String]::IsNullOrWhiteSpace($BuildConfiguration)) {
        Write-Verbose "`$BuildConfiguration is null or empty. Using setting value '$($Settings.buildConfiguration)'."
    }
    Else {
        $Settings.buildConfiguration = $BuildConfiguration        
    }
    
    $Settings
}

<#
.SYNOPSIS
1. Loads the settings found in "$SolutionRootPath\.pentia\user-settings.json", and uses them as a fallback values for each parameter that's null, empty or whitespace.
The intent is to provide a mechanism for overriding saved values while minimizing the need for mandatory parameters.

2. The merged settings are saved to "$SolutionRootPath\.pentia\user-settings.json".

3. Returns a settings object.

.EXAMPLE
$currentSettings = Get-MergedParametersAndUserSettings -SolutionRootPath "D:\Projects\SI\" -WebrootOutputPath "D:\MyNewOutputPath"
Returns the settings found in "D:\Projects\SI\.pentia\user-settings.json", with the $WebrootOutputPath overwritten to "D:\MyNewOutputPath", and saves these changed settings.
#>
Function Get-MergedParametersAndUserSettings {
    [CmdletBinding()]
    [OutputType([UserSettings])]
    Param (
        [Parameter(Mandatory = $True)]
        [string]$SolutionRootPath,

        [Parameter(Mandatory = $False)]
        [string]$WebrootOutputPath,

        [Parameter(Mandatory = $False)]
        [string]$DataOutputPath,

        [Parameter(Mandatory = $False)]
        [string]$BuildConfiguration
    )

    $userSettings = Get-UserSettings -SolutionRootPath $SolutionRootPath
    $mergedSettings = Merge-ParametersAndUserSettings -Settings $userSettings -WebrootOutputPath $WebrootOutputPath -DataOutputPath $DataOutputPath -BuildConfiguration $BuildConfiguration
    If ([string]::IsNullOrWhiteSpace($mergedSettings.webrootOutputPath)) {
        $mergedSettings.webrootOutputPath = Read-Host "Enter value for `$WebrootOutputPath"
    }
    If ([string]::IsNullOrWhiteSpace($mergedSettings.dataOutputPath)) {
        $mergedSettings.dataOutputPath = Read-Host "Enter value for `$DataOutputPath"
    }
    If ([string]::IsNullOrWhiteSpace($mergedSettings.buildConfiguration)) {
        $mergedSettings.buildConfiguration = Read-Host "Enter value for `$BuildConfiguration"
    }
    Set-UserSettings -SolutionRootPath $SolutionRootPath -Settings $mergedSettings
    $mergedSettings
}

Class UserSettings {
    [string]$webrootOutputPath
    [string]$dataOutputPath
    [string]$buildConfiguration
}

Export-ModuleMember -Function Get-UserSettingsFilePath, Get-UserSettings, Set-UserSettings, Merge-ParametersAndUserSettings, Get-MergedParametersAndUserSettings

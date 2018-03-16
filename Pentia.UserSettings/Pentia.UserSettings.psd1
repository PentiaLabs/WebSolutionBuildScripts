@{

    # Script module or binary module file associated with this manifest.
    RootModule        = 'Pentia.UserSettings.psm1'

    # Version number of this module.
    ModuleVersion     = '2.0.0'

    # ID used to uniquely identify this module
    GUID              = '124f394a-8328-4f0e-9aa0-e6c027a02e2b'

    # Author of this module
    Author            = 'Pentia Developers'

    # Company or vendor of this module
    CompanyName       = 'Pentia A/S'

    # Copyright statement for this module
    Copyright         = '(c) 2018 Pentia A/S. All rights reserved.'

    # Description of the functionality provided by this module
    Description       = 'Store and retrieve user specific settings.'

    # Modules that must be imported into the global environment prior to importing this module
    RequiredModules   = @()

    # Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.

    FunctionsToExport = @('Get-UserSettingsFilePath', 'Get-UserSettings', 'Set-UserSettings', 'Merge-ParametersAndUserSettings', 'Get-MergedParametersAndUserSettings')

    # Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
    CmdletsToExport   = @()

    # Variables to export from this module
    VariablesToExport = @()

    # Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
    AliasesToExport   = @()

    PrivateData       = @{
 
        PSData = @{
     
            # Tags applied to this module. These help with module discovery in online galleries.
            Tags       = @('pentia', 'PowerShell', 'build-scripts')
     
            # A URL to the license for this module.
            LicenseUri = ''
     
            # A URL to the main website for this project.
            ProjectUri = 'https://github.com/PentiaLabs/WebSolutionBuildScripts'
     
            # A URL to an icon representing this module.
            IconUri    = 'https://raw.githubusercontent.com/PentiaLabs/Pentia.NuGetPackageIcons/master/Pentia/logo.64x64.png'
        }
    }
}

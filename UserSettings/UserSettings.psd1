@{

    # Script module or binary module file associated with this manifest.
    RootModule        = 'UserSettings.psm1'

    # Version number of this module.
    ModuleVersion     = '0.3.0'

    # ID used to uniquely identify this module
    GUID              = '124f394a-8328-4f0e-9aa0-e6c027a02e2b'

    # Author of this module
    Author            = 'Pentia Developers'

    # Company or vendor of this module
    CompanyName       = 'Pentia A/S'

    # Copyright statement for this module
    Copyright         = '(c) 2017 Pentia A/S. All rights reserved.'

    # Description of the functionality provided by this module
    Description       = 'Store and retrieve user specific settings.'

    # Modules that must be imported into the global environment prior to importing this module
    RequiredModules   = @()

    # Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.

    FunctionsToExport = @('Get-UserSettings', 'Set-UserSettings', 'Merge-ParametersAndUserSettings')

    # Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
    CmdletsToExport   = @()

    # Variables to export from this module
    VariablesToExport = @()

    # Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
    AliasesToExport   = @()

}

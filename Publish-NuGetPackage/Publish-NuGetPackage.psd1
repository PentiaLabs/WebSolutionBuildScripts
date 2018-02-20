@{

    # Script module or binary module file associated with this manifest.
    RootModule        = 'Publish-NuGetPackage.psm1'

    # Version number of this module.
    ModuleVersion     = '1.0.0'

    # ID used to uniquely identify this module
    GUID              = 'df34c7b7-7748-40b7-8c8a-bd90c60cd8af'

    # Author of this module
    Author            = 'Pentia Developers'

    # Company or vendor of this module
    CompanyName       = 'Pentia A/S'

    # Copyright statement for this module
    Copyright         = '(c) 2018 Pentia A/S. All rights reserved.'

    # Description of the functionality provided by this module
    Description       = 'Used to install nuget.exe and restore NuGet packages.'

    # Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
    FunctionsToExport = @('Install-NuGetExe', 'Restore-NuGetPackage', 'Install-NuGetPackage', 'Publish-NuGetPackage')

    # Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
    CmdletsToExport   = @()

    # Variables to export from this module
    VariablesToExport = @()

    # Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
    AliasesToExport   = @()

}

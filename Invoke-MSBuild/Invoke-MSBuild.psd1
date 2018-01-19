@{

    # Script module or binary module file associated with this manifest.
    RootModule        = 'Invoke-MSBuild.psm1'

    # Version number of this module.
    ModuleVersion     = '1.0.0'

    # ID used to uniquely identify this module
    GUID              = '41268f87-c705-4481-aad8-9e9c6c05ae2c'

    # Author of this module
    Author            = 'Pentia Developers'

    # Company or vendor of this module
    CompanyName       = 'Pentia A/S'

    # Copyright statement for this module
    Copyright         = '(c) 2017 Pentia A/S. All rights reserved.'

    RequiredModules   = @(@{ModuleName = 'Get-MSBuild'; ModuleVersion = '1.0.0'; Guid = '3d2a79b9-7b42-4c20-b2c3-03b3e492ff32'})

    # Description of the functionality provided by this module
    Description       = 'Convenience script for invoking MSBuild.'

    # Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
    FunctionsToExport = @('Invoke-MSBuild')

    # Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
    CmdletsToExport   = @()

    # Variables to export from this module
    VariablesToExport = @()

    # Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
    AliasesToExport   = @()

}

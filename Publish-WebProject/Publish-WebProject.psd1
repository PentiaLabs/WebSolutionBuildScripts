@{

    # Script module or binary module file associated with this manifest.
    RootModule        = 'Publish-WebProject.psm1'

    # Version number of this module.
    ModuleVersion     = '0.2.2'

    # ID used to uniquely identify this module
    GUID              = '0180313a-e7a1-401f-a9a6-5150c41eccc9'

    # Author of this module
    Author            = 'Pentia Developers'

    # Company or vendor of this module
    CompanyName       = 'Pentia A/S'

    # Copyright statement for this module
    Copyright         = '(c) 2017 Pentia A/S. All rights reserved.'

    # Description of the functionality provided by this module
    Description       = 'Publishes web projects using MSBuild.'

    # Modules that must be imported into the global environment prior to importing this module
    RequiredModules   = @( @{ModuleName = 'Get-MSBuild'; ModuleVersion = '0.2.2'; Guid = '3d2a79b9-7b42-4c20-b2c3-03b3e492ff32'; })

    # Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
    FunctionsToExport = @('Publish-WebProject')

    # Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
    CmdletsToExport   = @()

    # Variables to export from this module
    VariablesToExport = @()

    # Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
    AliasesToExport   = @()

}

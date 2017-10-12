@{

    # Script module or binary module file associated with this manifest.
    RootModule        = 'Invoke-ConfigurationTransform.psm1'

    # Version number of this module.
    ModuleVersion     = '0.5.0'

    # ID used to uniquely identify this module
    GUID              = '6277b189-3478-4e86-9e3b-782d74a70758'

    # Author of this module
    Author            = 'Pentia Developers'

    # Company or vendor of this module
    CompanyName       = 'Pentia A/S'

    # Copyright statement for this module
    Copyright         = '(c) 2017 Pentia A/S. All rights reserved.'

    # Description of the functionality provided by this module
    Description       = 'Used to apply configuration transforms (XDTs) on configuration files.'

    # Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
    FunctionsToExport = @('Get-PathOfFileToTransform', 'Invoke-ConfigurationTransform')

    # Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
    CmdletsToExport   = @()

    # Variables to export from this module
    VariablesToExport = @()

    # Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
    AliasesToExport   = @()
}

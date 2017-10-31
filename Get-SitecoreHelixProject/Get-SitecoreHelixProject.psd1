@{

    # Script module or binary module file associated with this manifest.
    RootModule = 'Get-SitecoreHelixProject.psm1'

    # Version number of this module.
    ModuleVersion     = '0.5.2'

    # ID used to uniquely identify this module
    GUID              = 'a1c045f3-e740-4979-81f4-ac81ee39e5f0'

    # Author of this module
    Author            = 'Pentia Developers'

    # Description of the functionality provided by this module
    Description       = 'Get web projects stored in a Sitecore Helix-compliant solution layout.'
    
    # Company or vendor of this module
    CompanyName       = 'Pentia A/S'

    # Copyright statement for this module
    Copyright         = '(c) 2017 Pentia A/S. All rights reserved.'

    # Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
    FunctionsToExport = @('Get-SitecoreHelixProject')

    # Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
    CmdletsToExport   = @()

    # Variables to export from this module
    VariablesToExport = @()

    # Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
    AliasesToExport   = @()

}

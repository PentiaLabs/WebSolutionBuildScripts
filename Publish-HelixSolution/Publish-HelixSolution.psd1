@{

    # Script module or binary module file associated with this manifest.
    RootModule        = 'Publish-HelixSolution.psm1'

    # Version number of this module.
    ModuleVersion     = '0.2.3'

    # ID used to uniquely identify this module
    GUID              = '8eef74e7-2440-4a00-b2ec-bfc56a7c6297'

    # Author of this module
    Author            = 'Pentia Developers'

    # Description of the functionality provided by this module
    Description       = 'Executes all required steps to publish a Sitecore Helix-compliant solution.'

    # Company or vendor of this module
    CompanyName       = 'Pentia A/S'

    # Copyright statement for this module
    Copyright         = '(c) 2017 Pentia A/S. All rights reserved.'

    # Modules that must be imported into the global environment prior to importing this module
    RequiredModules   = @( 
        @{ModuleName = 'Get-RuntimeDependencyPackage'; ModuleVersion = '0.2.3'; Guid = '7e75a068-6847-4142-adb0-cf51e2ff8c21'},
        @{ModuleName = 'Publish-RuntimeDependencyPackage'; ModuleVersion = '0.2.3'; Guid = '04c76ad8-7c85-43cc-a1c4-765fc61b6100'},
        @{ModuleName = 'Get-SitecoreHelixProject'; ModuleVersion = '0.2.3'; Guid = 'a1c045f3-e740-4979-81f4-ac81ee39e5f0'}, 
        @{ModuleName = 'Publish-WebProject'; ModuleVersion = '0.2.3'; Guid = '0180313a-e7a1-401f-a9a6-5150c41eccc9'},
        @{ModuleName = 'Get-ConfigurationTransformFile'; ModuleVersion = '0.2.3'; Guid = '87e9e091-cb36-40fa-8e3f-b7a54cc8c892'}, 
        @{ModuleName = 'Invoke-ConfigurationTransform'; ModuleVersion = '0.2.3'; Guid = '6277b189-3478-4e86-9e3b-782d74a70758' })

    # Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
    FunctionsToExport = @('Publish-HelixSolution')

    # Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
    CmdletsToExport   = @()

    # Variables to export from this module
    VariablesToExport = @()

    # Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
    AliasesToExport   = @()

}

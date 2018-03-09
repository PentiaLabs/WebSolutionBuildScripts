@{

    # Script module or binary module file associated with this manifest.
    RootModule        = 'Publish-WebSolution.psm1'

    # Version number of this module.
    ModuleVersion     = '1.9.0'

    # ID used to uniquely identify this module
    GUID              = '8eef74e7-2440-4a00-b2ec-bfc56a7c6297'

    # Author of this module
    Author            = 'Pentia Developers'

    # Description of the functionality provided by this module
    Description       = 'Executes all required steps to publish a web solution.'

    # Company or vendor of this module
    CompanyName       = 'Pentia A/S'

    # Copyright statement for this module
    Copyright         = '(c) 2018 Pentia A/S. All rights reserved.'

    # Modules that must be imported into the global environment prior to importing this module
    RequiredModules   = @( 
        @{ModuleName = 'Get-MSBuild'; ModuleVersion = '1.0.0'; Guid = '3d2a79b9-7b42-4c20-b2c3-03b3e492ff32'},
        @{ModuleName = 'Get-RuntimeDependencyPackage'; ModuleVersion = '1.0.0'; Guid = '7e75a068-6847-4142-adb0-cf51e2ff8c21'},
        @{ModuleName = 'Publish-RuntimeDependencyPackage'; ModuleVersion = '1.0.2'; Guid = '04c76ad8-7c85-43cc-a1c4-765fc61b6100'},
        @{ModuleName = 'Get-WebProject'; ModuleVersion = '1.1.0'; Guid = 'a1c045f3-e740-4979-81f4-ac81ee39e5f0'}, 
        @{ModuleName = 'Publish-WebProject'; ModuleVersion = '1.3.0'; Guid = '0180313a-e7a1-401f-a9a6-5150c41eccc9'},
        @{ModuleName = 'Get-ConfigurationTransformFile'; ModuleVersion = '1.1.0'; Guid = '87e9e091-cb36-40fa-8e3f-b7a54cc8c892'}, 
        @{ModuleName = 'Invoke-ConfigurationTransform'; ModuleVersion = '1.1.3'; Guid = '6277b189-3478-4e86-9e3b-782d74a70758' }, 
        @{ModuleName = 'UserSettings'; ModuleVersion = '1.0.2'; Guid = '124f394a-8328-4f0e-9aa0-e6c027a02e2b' }, 
        @{ModuleName = 'Assert-WebProjectConsistency'; ModuleVersion = '1.3.0'; Guid = '3c3eabeb-7ac7-41b3-a1f9-74596966cfcb' }, 
        @{ModuleName = 'Publish-NuGetPackage'; ModuleVersion = '1.0.0'; Guid = 'df34c7b7-7748-40b7-8c8a-bd90c60cd8af' })

    # Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
    FunctionsToExport = @('Publish-ConfiguredWebSolution', 'Publish-UnconfiguredWebSolution', 'Set-WebSolutionConfiguration', 'Publish-AllRuntimeDependencies')

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

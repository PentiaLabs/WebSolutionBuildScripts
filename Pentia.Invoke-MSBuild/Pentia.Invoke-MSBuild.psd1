@{

    # Script module or binary module file associated with this manifest.
    RootModule        = 'Pentia.Invoke-MSBuild.psm1'

    # Version number of this module.
    ModuleVersion     = '2.2.0'

    # ID used to uniquely identify this module
    GUID              = '41268f87-c705-4481-aad8-9e9c6c05ae2c'

    # Author of this module
    Author            = 'Pentia Developers'

    # Company or vendor of this module
    CompanyName       = 'Pentia A/S'

    # Copyright statement for this module
    Copyright         = '(c) 2018 Pentia A/S. All rights reserved.'

    RequiredModules   = @(
        @{ModuleName = 'Pentia.Get-MSBuild'; ModuleVersion = '2.1.0'; Guid = '3d2a79b9-7b42-4c20-b2c3-03b3e492ff32'}
    )

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

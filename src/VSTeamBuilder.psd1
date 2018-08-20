#
# Module manifest for module 'VSTeamBuilder'
#
# Generated by: JS Clifford
#
# Generated on: 6/11/2018
#

@{

# Script module or binary module file associated with this manifest.
RootModule = 'VSTeamBuilder.psm1'

# Version number of this module.
ModuleVersion = '0.7.3'

# Supported PSEditions
# CompatiblePSEditions = @()

# ID used to uniquely identify this module
GUID = '698282cf-f034-4476-a875-8f6591ed45d2'

# Author of this module
Author = 'JS Clifford'

# Company or vendor of this module
CompanyName = ''

# Copyright statement for this module
Copyright = '(c) 2018 JS Clifford. All rights reserved.'

# Description of the functionality provided by this module
Description = 'Powershell Module that automates VSTS/TFS project creation and configuration for large project setups.'

# Minimum version of the Windows PowerShell engine required by this module
# PowerShellVersion = ''

# Name of the Windows PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the Windows PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# CLRVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
RequiredModules = @(
    #@{ModuleName = 'VSTeam'; ModuleVersion = '4.0.0'}#,
    #@{ModuleName = 'TFSCmdlets'; ModuleVersion = '1.0.0.864'}
    # @{ModuleName = 'TFSCmdlets'; ModuleVersion = '1.0.184'}
)

# Assemblies that must be loaded prior to importing this module
# RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
#ScriptsToProcess = @('Startup.ps1')

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
# FormatsToProcess = @()

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
# NestedModules = @()

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = @(
    'New-TBOrg',
    'Remove-TBOrg',
    'New-TBTeam',
    'Remove-TBTeam',
    'New-TBSecurityGroup',
    'Get-TBSecurityGroup',
    'Remove-TBSecurityGroup',
    'Add-TBSecurityGroupMember',
    'Remove-TBSecurityGroupMember',
    'Set-TBTeamAreaSetting',
    'Get-TBTeamAreaSetting',
    'Set-TBTeamIterationSetting',
    'Get-TBTeamIterationSetting',
    'Add-TBTeamIteration',
    'Get-TBTeamIteration',
    'Set-TBPermission',
    'Get-TBTokenCollection',
    'Get-TBNamespaceCollection',
    'Get-TBToken',
    'Add-TBConnection',
    'Remove-TBConnection',
    'Set-TBDefaultProject'
)

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = '*'

# Variables to export from this module
VariablesToExport = '*'

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = '*'

# DSC resources to export from this module
# DscResourcesToExport = @()

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = @('VSTeamBuilder','VSTS', 'TFS', 'DevOps', 'VisualStudio', 'TeamServices', 'Team')

        # A URL to the license for this module.
        LicenseUri = 'https://github.com/jsclifford/VSTeamBuilder/blob/master/LICENSE'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/jsclifford/VSTeamBuilder'

        # A URL to an icon representing this module.
        # IconUri = ''

        # ReleaseNotes of this module
        ReleaseNotes = 'Alpha Release
Added SkipExistingTeam to New-TBOrg
Changed TeamGroups parameter to include ability to specify group permissions on New-TBTeam
Fixed progress bar.
Made New/Remove-TBOrg TFSVC aware.
Added Verbose reporting in New-TBTeam and Remove-TBTeam
Added API Version aware on Area and Iteration functions
Build Process Bug
https://github.com/jsclifford/VSTeamBuilder/blob/master/ReleaseNotes.md'

        # TFS Client Version
        #TfsClientVersion = '${TfsOmNugetVersion}'

        #External dependent modules of this module
        # ExternalModuleDependencies = ''

    } # End of PSData hashtable

} # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}



# Dot source this script in any Pester test script that requires the module to be imported.

$RootDir = Split-Path (Split-Path -Path $PSScriptRoot -Parent) -Parent
$ModuleManifestName = 'VSTeamBuilder.psd1'
$ModuleManifestPath = "$RootDir\src\$ModuleManifestName"

if (!$SuppressImportModule) {
    # -Scope Global is needed when running tests from inside of psake, otherwise
    # the module's functions cannot be found in the VSTeamBuilder\ namespace
    Import-Module $ModuleManifestPath -Scope Global -Force
}
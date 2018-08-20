#Installs all required modules for appveyor build.
if($null -ne $env:APPVEYOR_BUILD_FOLDER){
    $buildfolder = $env:APPVEYOR_BUILD_FOLDER
}
Install-PackageProvider -Name NuGet -Force
Write-Verbose -Message "PowerShell version $($PSVersionTable.PSVersion)" -Verbose
$moduleData = Import-PowerShellDataFile "$($buildfolder)\src\VSTeamBuilder.psd1"
#$moduleData.RequiredModules | ForEach-Object { Install-Module $PSItem.ModuleName -RequiredVersion $PSItem.ModuleVersion -Repository PSGallery -Scope CurrentUser -Force -SkipPublisherCheck }
$moduleData.RequiredModules | ForEach-Object { Install-Module $PSItem -Repository PSGallery -Scope CurrentUser -Force -SkipPublisherCheck }
Install-Module pester -SkipPublisherCheck -Force -Scope CurrentUser
Install-Module psake,psscriptanalyzer,platyPS -Scope CurrentUser -Force

Import-Module Pester,Psake,PSScriptAnalyzer

. $PSScriptRoot\appveyor.install-dotnet.ps1 -Version '2.0.0.0'


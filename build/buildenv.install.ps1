[cmdletbinding()]
param()

#Installs all required modules for appveyor build.
if($null -ne $env:APPVEYOR_BUILD_FOLDER){
    $buildfolder = $env:APPVEYOR_BUILD_FOLDER
    Write-Verbose "This is an Appveyor Build"
}else{
    $buildfolder = $Env:BUILD_SOURCESDIRECTORY
    Write-Verbose "This is an VSTS Build"
}
Install-PackageProvider -Name NuGet -Force -Scope CurrentUser
Write-Verbose -Message "PowerShell version $($PSVersionTable.PSVersion)" -Verbose
$moduleData = Import-PowerShellDataFile "$($buildfolder)\src\VSTeamBuilder.psd1"
#$moduleData.RequiredModules | ForEach-Object { Install-Module $PSItem.ModuleName -RequiredVersion $PSItem.ModuleVersion -Repository PSGallery -Scope CurrentUser -Force -SkipPublisherCheck }
$moduleData.RequiredModules | ForEach-Object { Install-Module $PSItem -Repository PSGallery -Scope CurrentUser -Force }
Install-Module pester -Force -Scope CurrentUser -SkipPublisherCheck
Install-Module psake,psscriptanalyzer,platyPS -Scope CurrentUser -Force

Import-Module Pester,Psake,PSScriptAnalyzer


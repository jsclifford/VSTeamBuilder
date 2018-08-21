[cmdletbinding()]
param()

$seperator = @'

------------------------------------

'@

#Installs all required modules for appveyor build.
if($null -ne $env:APPVEYOR_BUILD_FOLDER){
    $buildfolder = $env:APPVEYOR_BUILD_FOLDER
    Write-Verbose "This is an Appveyor Build"
}else{
    $buildfolder = $Env:BUILD_SOURCESDIRECTORY
    Write-Verbose "This is an VSTS Build"
}

Write-Verbose -Message "PowerShell version $($PSVersionTable.PSVersion)" -Verbose

Write-Verbose $seperator

Install-PackageProvider -Name NuGet -Force -Scope CurrentUser

$moduleData = Import-PowerShellDataFile "$($buildfolder)\src\VSTeamBuilder.psd1"
#$moduleData.RequiredModules | ForEach-Object { Install-Module $PSItem.ModuleName -RequiredVersion $PSItem.ModuleVersion -Repository PSGallery -Scope CurrentUser -Force -SkipPublisherCheck }
Write-Verbose "Installing Required Modules in psd1 file."
$moduleData.RequiredModules | ForEach-Object { Install-Module $PSItem -Repository PSGallery -Scope CurrentUser -Force }


Install-Module psake,psscriptanalyzer,platyPS -Scope CurrentUser -Force

if($null -ne $env:APPVEYOR_BUILD_FOLDER){
    Install-Module pester -Scope CurrentUser -Force -SkipPublisherCheck
}else{
    Install-Module pester -Scope CurrentUser -Force
}

Write-Verbose $seperator
Write-Verbose "Getting current module versions."
Get-InstalledModule | Where Name -notlike '*Azure*' | Select Name,Version,Type,InstalledLocation | Format-Table -AutoSize

Write-Verbose $seperator

Import-Module Pester,Psake

Write-Verbose $seperator

Write-Verbose "Loading Required Modules."

Import-Module $($moduleData.RequiredModules)

Write-Verbose $seperator


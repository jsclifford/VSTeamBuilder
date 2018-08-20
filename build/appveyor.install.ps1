#Installs all required modules for appveyor build.
Install-PackageProvider -Name NuGet -Force
Write-Verbose -Message "PowerShell version $($PSVersionTable.PSVersion)" -Verbose
$moduleData = Import-PowerShellDataFile "$($env:APPVEYOR_BUILD_FOLDER)\src\VSTeamBuilder.psd1"
$moduleData.RequiredModules | ForEach-Object { Install-Module $PSItem.ModuleName -RequiredVersion $PSItem.ModuleVersion -Repository PSGallery -Scope CurrentUser -Force }
Install-Module pester -SkipPublisherCheck -Force -Scope CurrentUser
Install-Module psake,psscriptanalyzer,platyPS -Scope CurrentUser -Force

Import-Module Pester,Psake,PSScriptAnalyzer


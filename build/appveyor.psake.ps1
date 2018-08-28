Import-Module PSake

#Installs all required modules for appveyor build.
if($null -ne $env:APPVEYOR_BUILD_FOLDER){
    $defaultTests = $env:default_tests
    Write-Verbose "This is an Appveyor Build"
}else{
    $defaultTests = $env:default_tests
    Write-Verbose "This is an VSTS Build"
}

if($defaultTests -eq 'y'){
    # Builds the module by invoking psake on the build.psake.ps1 script.
    Write-Verbose "Running Psake task TestDefault"
    Invoke-psake $PSScriptRoot\build.psake.ps1 -taskList TestDefault -Verbose
}else{
    # Builds the module by invoking psake on the build.psake.ps1 script.
    Write-Verbose "Running Psake task Tes"
    Invoke-psake $PSScriptRoot\build.psake.ps1 -taskList Test -Verbose
}


if ($psake.build_success -eq $false){
    Add-AppveyorMessage -Message "Unit Test Failed"
    Update-AppveyorTest -Name "PSake Unitest" -Outcome Failed -ErrorMessage $psake.error_message -Framework NUnit
    throw "Psake Build Failed"
}else{
    Update-AppveyorTest -Name "PSake Unitest" -Outcome Passed -Framework NUnit
}
Import-Module PSake

if($env:default_tests -eq 'y'){
    # Builds the module by invoking psake on the build.psake.ps1 script.
    Write-Verbose "Running Psake task TestDefault"
    Invoke-psake $PSScriptRoot\build.psake.ps1 -taskList TestDefault -Verbose
}else{
    # Builds the module by invoking psake on the build.psake.ps1 script.
    Write-Verbose "Running Psake task Test"
    Invoke-psake $PSScriptRoot\build.psake.ps1 -taskList Test -Verbose
}


if ($psake.build_success -eq $false){
    Add-AppveyorMessage -Message "Unit Test Failed"
    Update-AppveyorTest -Name "PSake Unitest" -Outcome Failed -ErrorMessage $psake.error_message -Framework NUnit
    throw "Psake Build Failed"
}else{
    Update-AppveyorTest -Name "PSake Unitest" -Outcome Passed -Framework NUnit
}
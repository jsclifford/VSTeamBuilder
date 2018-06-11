[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '', Scope='*', Target='SuppressImportModule')]
$SuppressImportModule = $true
. $PSScriptRoot\Shared.ps1

#region Global Test Variables
# Put Variables here that you want all tests to use.
#endregion

Describe 'Module Manifest Tests' {
    It 'Passes Test-ModuleManifest' {
        Test-ModuleManifest -Path $ModuleManifestPath
        $? | Should Be $true
    }
}

Describe 'New-TBOrg' {
    It 'Passes ' {
        New-TBOrg -Paramater1 "test" -Paramater2 "test2" -Paramater3 "test3" -Paramater4 "test4"
        True | Should Be True
    }
}
Describe 'Remove-TBOrg' {
    It 'Passes ' {
        Remove-TBOrg -Paramater1 "test" -Paramater2 "test2" -Paramater3 "test3" -Paramater4 "test4"
        True | Should Be True
    }
}
Describe 'New-TBTeam' {
    It 'Passes ' {
        New-TBTeam -Paramater1 "test" -Paramater2 "test2" -Paramater3 "test3" -Paramater4 "test4"
        True | Should Be True
    }
}
Describe 'Remove-TBTeam' {
    It 'Passes ' {
        Remove-TBTeam -Paramater1 "test" -Paramater2 "test2" -Paramater3 "test3" -Paramater4 "test4"
        True | Should Be True
    }
}
Describe 'New-TBSecurityGroup' {
    It 'Passes ' {
        New-TBSecurityGroup -Paramater1 "test" -Paramater2 "test2" -Paramater3 "test3" -Paramater4 "test4"
        True | Should Be True
    }
}
Describe 'Get-TBSecurityGroup' {
    It 'Passes ' {
        Get-TBSecurityGroup -Paramater1 "test" -Paramater2 "test2" -Paramater3 "test3" -Paramater4 "test4"
        True | Should Be True
    }
}
Describe 'Add-TBSecurityGroupMember' {
    It 'Passes ' {
        Add-TBSecurityGroupMember -Paramater1 "test" -Paramater2 "test2" -Paramater3 "test3" -Paramater4 "test4"
        True | Should Be True
    }
}
Describe 'Remove-TBSecurityGroupMember' {
    It 'Passes ' {
        Remove-TBSecurityGroupMember -Paramater1 "test" -Paramater2 "test2" -Paramater3 "test3" -Paramater4 "test4"
        True | Should Be True
    }
}
Describe 'Set-TBTeamAreaSetting' {
    It 'Passes ' {
        Set-TBTeamAreaSetting -Paramater1 "test" -Paramater2 "test2" -Paramater3 "test3" -Paramater4 "test4"
        True | Should Be True
    }
}
Describe 'Get-TBTeamAreaSetting' {
    It 'Passes ' {
        Get-TBTeamAreaSetting -Paramater1 "test" -Paramater2 "test2" -Paramater3 "test3" -Paramater4 "test4"
        True | Should Be True
    }
}
Describe 'Set-TBTeamIterationSetting' {
    It 'Passes ' {
        Set-TBTeamIterationSetting -Paramater1 "test" -Paramater2 "test2" -Paramater3 "test3" -Paramater4 "test4"
        True | Should Be True
    }
}
Describe 'Get-TBTeamIterationSetting' {
    It 'Passes ' {
        Get-TBTeamIterationSetting -Paramater1 "test" -Paramater2 "test2" -Paramater3 "test3" -Paramater4 "test4"
        True | Should Be True
    }
}
Describe 'Add-TBTeamIteration' {
    It 'Passes ' {
        Add-TBTeamIteration -Paramater1 "test" -Paramater2 "test2" -Paramater3 "test3" -Paramater4 "test4"
        True | Should Be True
    }
}
Describe 'Get-TBTeamIteration' {
    It 'Passes ' {
        Get-TBTeamIteration -Paramater1 "test" -Paramater2 "test2" -Paramater3 "test3" -Paramater4 "test4"
        True | Should Be True
    }
}
Describe 'Set-TBPermission' {
    It 'Passes ' {
        Set-TBPermission -Paramater1 "test" -Paramater2 "test2" -Paramater3 "test3" -Paramater4 "test4"
        True | Should Be True
    }
}
Describe 'Get-TBTokenCollection' {
    It 'Passes ' {
        Get-TBTokenCollection -Paramater1 "test" -Paramater2 "test2" -Paramater3 "test3" -Paramater4 "test4"
        True | Should Be True
    }
}
Describe 'Get-TBNamespaceCollection' {
    It 'Passes ' {
        Get-TBNamespaceCollection -Paramater1 "test" -Paramater2 "test2" -Paramater3 "test3" -Paramater4 "test4"
        True | Should Be True
    }
}
Describe 'Get-TBToken' {
    It 'Passes ' {
        Get-TBToken -Paramater1 "test" -Paramater2 "test2" -Paramater3 "test3" -Paramater4 "test4"
        True | Should Be True
    }
}
Describe 'Use-TBConnection' {
    It 'Passes ' {
        Use-TBConnection -Paramater1 "test" -Paramater2 "test2" -Paramater3 "test3" -Paramater4 "test4"
        True | Should Be True
    }
}


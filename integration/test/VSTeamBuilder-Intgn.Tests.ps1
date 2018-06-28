[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '', Scope='*', Target='SuppressImportModule')]
$SuppressImportModule = $false
. $PSScriptRoot\Shared.ps1

#region Global Test Variables
# Put Variables here that you want all tests to use.  Can also have env variables used in build/test process of CI.
$CollectionName = "MyDefaulCollection"
$ServerURL = "https://mydemo-tfsserver"
$ProjectName = "MyTestProject"
Add-TBConnection -CollectionName $Collectionname -ServerURL $ServerURL
#endregion

Describe 'Module Manifest Tests' {
    It 'Passes Test-ModuleManifest' {
        Test-ModuleManifest -Path $ModuleManifestPath
        $? | Should Be $true
    }
}

Describe 'New-TBOrg' {
    It 'Passes New-TBOrg' {
        #New-TBOrg -Paramater1 "test" -Paramater2 "test2" -Paramater3 "test3" -Paramater4 "test4"
        $True | Should Be True
    }
}
Describe 'Remove-TBOrg' {
    It 'Passes Remove-TBOrg' {
        #Remove-TBOrg -Paramater1 "test" -Paramater2 "test2" -Paramater3 "test3" -Paramater4 "test4"
        $True | Should Be True
    }
}
Describe 'New-TBTeam' {
    It 'Passes New-TBTeam' {
        New-TBTeam -Paramater1 "test" -Paramater2 "test2" -Paramater3 "test3" -Paramater4 "test4"
        True | Should Be True
    }
}
Describe 'Remove-TBTeam' {
    It 'Passes Remove-TBTeam' {
        Remove-TBTeam -Paramater1 "test" -Paramater2 "test2" -Paramater3 "test3" -Paramater4 "test4"
        True | Should Be True
    }
}
Describe 'TFS Security Group' {
    $TeamName = "MyTestTeam2"
    $TeamCode = "MTT2"
    $TeamDescription = "The best Test of a new team"
    It 'Creates new TFS Security Group - New-TBSecurityGroup' {
        $createIt = New-TBSecurityGroup -Name "$Teamcode-Contributors" -ProjectName $ProjectName -Description $TeamDescription
        $result = Get-TBSecurityGroup -Name "$Teamcode-Contributors" -ProjectName $ProjectName
        $($result.DisplayName) -like "*$Teamcode-Contributors" | Should Be True
    }

    It 'Gets TFS Security Group Get-TBSecurityGroup' {
        $result = Get-TBSecurityGroup -Name "$Teamcode-Contributors" -ProjectName $ProjectName
        $($result.DisplayName) -like "*$Teamcode-Contributors" | Should Be True
    }
}
Describe 'Add-TBSecurityGroupMember' {
    It 'Passes Add-TBSecurityGroupMember' {
        Add-TBSecurityGroupMember -Paramater1 "test" -Paramater2 "test2" -Paramater3 "test3" -Paramater4 "test4"
        True | Should Be True
    }
}
Describe 'Remove-TBSecurityGroupMember' {
    It 'Passes Remove-TBSecurityGroupMember' {
        Remove-TBSecurityGroupMember -Paramater1 "test" -Paramater2 "test2" -Paramater3 "test3" -Paramater4 "test4"
        True | Should Be True
    }
}

Describe 'Team Area' {
    $TeamName = "MyTestTeam"
    $AreaPath = "MTT"
    It 'Sets Team Area Default Setting - Set-TBTeamAreaSetting' {
        $result = Set-TBTeamAreaSetting -AreaPath $AreaPath -TeamName $TeamName -ProjectName $ProjectName
        $($result.defaultValue) -like "*$AreaPath" | Should Be True
    }

    It 'Gets Team Area Default Setting - Get-TBTeamAreaSetting' {
        $result = Get-TBTeamAreaSetting -TeamName $TeamName -ProjectName $ProjectName
        $($result.defaultValue) -like "*$AreaPath" | Should Be True
    }
}

Describe 'Team Iteration' {
    $TeamName = "MyTestTeam"
    $IterationName = "MTT"
    It 'Sets Team Iteration Default Setting - Set-TBTeamIterationSetting' {
        $result = Set-TBTeamIterationSetting -IterationName $IterationName -TeamName $TeamName -ProjectName $ProjectName
        $($result.backlogIteration.name) -eq $IterationName | Should Be True
    }

    It 'Gets Team Iteration Default Setting - Get-TBTeamIterationSetting' {
        $result = Get-TBTeamIterationSetting -TeamName $TeamName -ProjectName $ProjectName
        $($result.backlogIteration.id) -ne $null -or $($result.backlogIteration.id) -ne "00000000-0000-0000-0000-000000000000" | Should Be True
    }

    It 'Adds Team Iterations - Add-TBTeamIteration' {
        $IterationSub = "$IterationName\MTT-Iteration1"
        $result = Add-TBTeamIteration -IterationName $IterationName -TeamName $TeamName -ProjectName $ProjectName
        $($result.path) -like "*$IterationSub" | Should Be True
    }

    It 'Gets Team Iterations - Get-TBTeamIteration' {
        $result = Get-TBTeamIteration -TeamName $TeamName -ProjectName $ProjectName
        $($result.value) -ne $null | Should Be True
    }
}
Describe 'TFS Permissions' {
    $TeamCode = "MTT"
    It 'Sets TFS Permission on Git Repo - Set-TBPermission' {
        $gitRepo = Get-VSTeamGitRepository -ProjectName $ProjectName -Name "$ProjectName"
        $token = Get-TBToken -ObjectId $gitRepo.Id -ProjectName $ProjectName
        $result = Set-TBPermission -TokenObject $token -GroupName "$TeamCode-Contributors" -AllowValue 118 -ProjectName $ProjectName
        $result.count -gt 0 | Should Be True
    }

    It 'Sets TFS Permission on Team Iteration - Set-TBPermission' {
        $iteration = Get-TFSIteration -Iteration "$Teamcode" -ProjectName $ProjectName -Collection $CollectionName
        $token = Get-TBToken -ObjectId $iteration.Id -ProjectName $ProjectName
        $result = Set-TBPermission -TokenObject $token -GroupName "$TeamCode-Contributors" -AllowValue 7 -ProjectName $ProjectName
        $result.count -gt 0 | Should Be True
    }
}

Describe 'TFS Token and Namespace' {
    It 'Gets Namespce Collection - Get-TBNamespaceCollection' {
        $namespaces = Get-TBNamespaceCollection
        $namespaces.length -gt 0 | Should Be True
    }

    It 'Get Token Collection - Get-TBTokenCollection' {
        $namespaces = Get-TBNamespaceCollection
        $tokens = Get-TBTokenCollection -NamespaceId $($namespaces[0].id)
        $tokens.length -gt 0 | Should Be True
    }

    It 'Get Token - Get-TBToken' {
        $token = Get-TBToken -ObjectId $objectId -NsName "Git Repositories" -ProjectName $ProjectName
        $token.token -ne $null | Should Be True
    }
}
Describe 'TBConnection' {


    It 'Connects to TFS Server - Add-TBConnection' {
        Add-TBConnection -CollectionName $Collectionname -ServerURL $ServerURL | Should Be True
    }

    It 'Disconnects TFS Server - Remove-TBConnection' {
        Remove-TBConnection -AllVariables | Should Be True
    }

    It 'Sets Default Project' {
        Set-TBDefaultProject -ProjectName $ProjectName
        $Global:VSTBConn.DefaultProject | Should Be $ProjectName
    }
}


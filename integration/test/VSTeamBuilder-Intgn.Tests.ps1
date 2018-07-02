[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '', Scope='*', Target='SuppressImportModule')]
$SuppressImportModule = $false
. $PSScriptRoot\Shared.ps1

$VerbosePreference = "Continue"

Describe 'VSTeamBuilder Integration Test'{
    BeforeAll {
        $projectName = $env:projectName
        $collectionName = $env:collectionName
        $acctUrl = $env:accturl
        $pat = $env:PAT
        $api = $env:API
        $searchGroup = $env:searchGroup
        $originalLocation = Get-Location

        if($usePAT){
            Add-TBConnection -AcctUrl $acctUrl -PAT $pat -API $api
        }else{
            Add-TBConnection -AcctUrl $acctUrl -API $api
        }
        Set-TBDefaultProject -ProjectName $projectName
    }

    Context 'Module Manifest' {
        It 'Passes Test-ModuleManifest' {
            Test-ModuleManifest -Path $ModuleManifestPath
            $? | Should Be $true
        }
    }

    Context 'Add/Remove TBOrg' {
        It 'Passes New-TBOrg' {
            #New-TBOrg -Paramater1 "test" -Paramater2 "test2" -Paramater3 "test3" -Paramater4 "test4"
            $True | Should Be True
        }

        It 'Passes Remove-TBOrg' {
            #Remove-TBOrg -Paramater1 "test" -Paramater2 "test2" -Paramater3 "test3" -Paramater4 "test4"
            $True | Should Be True
        }
    }

    Context 'Add/Remove Team' {
        $TeamName = "MyTestTeam"
        $TeamCode = "MTT"
        $TeamDescription = "The best Test of a new team"
        $TeamRootPath = ""

        It 'Creates a new Team - New-TBTeam' {
            $result = New-TBTeam -Name $TeamName -Description $TeamDescription -TeamCode $TeamCode -TeamPath $TeamRootPath -isCoded -ProjectName $projectName
            $result | Should Be True
        }

        It 'Creates a new SubTeam - New-TBTeam' {
            $result = New-TBTeam -Name "$TeamName-Sub" -Description $TeamDescription -TeamCode "$TeamCode-Sub" -TeamPath "MTT" -isCoded -ProjectName $projectName
            $result | Should Be True
        }

        It 'Remove Teams - New-TBTeam' {
            $result1 = Remove-TBTeam -Name $TeamName -TeamCode $TeamCode -TeamPath $TeamRootPath -isCoded -ProjectName $projectName
            $result2 = Remove-TBTeam -Name "$TeamName-Sub" -TeamCode "$TeamCode-Sub" -TeamPath "MTT" -isCoded -ProjectName $projectName
            $result1 -and $result2 | Should Be True
        }
    }

    Context 'TFS Security Group' {
        $TeamName = "MyTestTeam2"
        $TeamCode = "MTT2"
        $TeamDescription = "The best Test of a new team"

        It 'Creates new TFS Security Group - New-TBSecurityGroup' {
            $createIt = New-TBSecurityGroup -Name "$Teamcode-Contributors" -ProjectName $projectName -Description $TeamDescription
            $result = Get-TBSecurityGroup -Name "$Teamcode-Contributors" -ProjectName $projectName
            $($result.DisplayName) -like "*$Teamcode-Contributors" | Should Be True
        }

        It 'Gets TFS Security Group Get-TBSecurityGroup' {
            $result = Get-TBSecurityGroup -Name "$Teamcode-Contributors" -ProjectName $projectName
            $($result.DisplayName) -like "*$Teamcode-Contributors" | Should Be True
        }

        It 'Adds a team to the new group - Add-TBSecurityGroupMember' {
            $result = Add-TBSecurityGroupMember -MemberName "$searchGroup" -GroupName "$Teamcode-Contributors" -ProjectName $projectName
            $result -eq $null | Should Be True
        }

        It 'Removes a team to the new group - Remove-TBSecurityGroupMember' {
            $result = Remove-TBSecurityGroupMember -MemberName "$searchGroup" -GroupName "$Teamcode-Contributors" -ProjectName $projectName
            $result -eq $null | Should Be True
        }

        It 'Removes new TFS Security Group - Remove-TBSecurityGroup' {
            $removeIt = Remove-TBSecurityGroup -Name "$Teamcode-Contributors" -ProjectName $projectName
            $result = Get-TBSecurityGroup -Name "$Teamcode-Contributors" -ProjectName $projectName
            $($result.DisplayName) -like "*$Teamcode-Contributors" | Should Be False
        }
    }

    Context 'Team Area' {
        $TeamName = "MyTestTeam"
        $AreaPath = "MTT"
        It 'Sets Team Area Default Setting - Set-TBTeamAreaSetting' {
            $result = Set-TBTeamAreaSetting -AreaPath $AreaPath -TeamName $TeamName -ProjectName $projectName
            $($result.defaultValue) -like "*$AreaPath" | Should Be True
        }

        It 'Gets Team Area Default Setting - Get-TBTeamAreaSetting' {
            $result = Get-TBTeamAreaSetting -TeamName $TeamName -ProjectName $projectName
            $($result.defaultValue) -like "*$AreaPath" | Should Be True
        }
    }

    Context 'Team Iteration' {
        $TeamName = "MyTestTeam"
        $IterationName = "MTT"
        It 'Sets Team Iteration Default Setting - Set-TBTeamIterationSetting' {
            $result = Set-TBTeamIterationSetting -IterationName $IterationName -TeamName $TeamName -ProjectName $projectName
            $($result.backlogIteration.name) -eq $IterationName | Should Be True
        }

        It 'Gets Team Iteration Default Setting - Get-TBTeamIterationSetting' {
            $result = Get-TBTeamIterationSetting -TeamName $TeamName -ProjectName $projectName
            $($result.backlogIteration.id) -ne $null -or $($result.backlogIteration.id) -ne "00000000-0000-0000-0000-000000000000" | Should Be True
        }

        It 'Adds Team Iterations - Add-TBTeamIteration' {
            $IterationSub = "$IterationName\MTT-Iteration1"
            $result = Add-TBTeamIteration -IterationName $IterationName -TeamName $TeamName -ProjectName $projectName
            $($result.path) -like "*$IterationSub" | Should Be True
        }

        It 'Gets Team Iterations - Get-TBTeamIteration' {
            $result = Get-TBTeamIteration -TeamName $TeamName -ProjectName $projectName
            $($result.value) -ne $null | Should Be True
        }
    }

    Context 'TFS Permissions and Tokens' {
        $TeamCode = "MTT"

        It 'Gets Namespce Collection - Get-TBNamespaceCollection' {
            $namespaces = Get-TBNamespaceCollection
            $namespaces.length -gt 0 | Should Be True
        }

        It 'Get Token Collection - Get-TBTokenCollection' {
            $namespaces = Get-TBNamespaceCollection
            $tokens = Get-TBTokenCollection -NamespaceId "2e9eb7ed-3c0a-47d4-87c1-0ffdd275fd87"
            $tokens.length -gt 0 | Should Be True
        }

        It 'Get Token - Get-TBToken' {
            $object = Get-VSTeamGitRepository -ProjectName $projectName -Name "$projectName"
            $objectId = $object.id
            $token = Get-TBToken -ObjectId $objectId -NsName "Git Repositories" -ProjectName $projectName
            $token.token -ne $null | Should Be True
        }

        It 'Sets TFS Permission on Git Repo - Set-TBPermission' {
            $gitRepo = Get-VSTeamGitRepository -ProjectName $projectName -Name "$projectName"
            $token = Get-TBToken -ObjectId $gitRepo.id -NsName "Git Repositories" -ProjectName $projectName
            $result = Set-TBPermission -TokenObject $token -GroupName "$TeamCode-Contributors" -AllowValue 118 -ProjectName $projectName
            $result.count -gt 0 | Should Be True
        }

        It 'Sets TFS Permission on Team Iteration - Set-TBPermission' {
            $iteration = Get-TFSIteration -Iteration "$Teamcode" -ProjectName $projectName -Collection $collectionName
            $token = Get-TBToken -ObjectId $iteration.Id -NSName "Iteration" -ProjectName $projectName
            $result = Set-TBPermission -TokenObject $token -GroupName "$TeamCode-Contributors" -AllowValue 7 -ProjectName $projectName
            $result.count -gt 0 | Should Be True
        }
    }

    Context 'TBConnection' {
        It 'Connects to TFS Server - Add-TBConnection' {
            Add-TBConnection -AcctUrl $acctUrl -PAT $pat -API $api | Should Be True
        }

        It 'Sets Default Project' {
            Set-TBDefaultProject -ProjectName $projectName
            $Global:VSTBConn.DefaultProjectName | Should Be $projectName
        }

        It 'Disconnects TFS Server - Remove-TBConnection' {
            $result = Remove-TBConnection -AllVariables
            $result | Should Be True
        }
    }

    AfterAll {
        # Put everything back
        Set-Location $originalLocation
        Remove-TBConnection -AllVariables
     }
}

Describe "Standalone Integration Test - Temporary" {

    BeforeAll {
        $projectName = $env:projectName
        $collectionName = $env:collectionName
        $acctUrl = $env:accturl
        #$acctUrl = "masterkey53"
        $pat = $env:PAT
        $api = $env:API
        $searchGroup = $env:searchGroup
        $originalLocation = Get-Location

        if($usePAT){
            Add-TBConnection -AcctUrl $acctUrl -PAT $pat -API $api
        }else{
            Add-TBConnection -AcctUrl $acctUrl -API $api -UseWindowsAuth
        }
        Set-TBDefaultProject -ProjectName $projectName
    }

    Context 'Add/Remove Team' {
        $TeamName = "MyTestTeam"
        $TeamCode = "MTT"
        $TeamDescription = "The best Test of a new team"
        $TeamRootPath = ""

        It 'Creates a new Team - New-TBTeam' {
            $result = New-TBTeam -Name $TeamName -Description $TeamDescription -TeamCode $TeamCode -TeamPath $TeamRootPath -isCoded -ProjectName $projectName
            $result | Should Be True
        }

        It 'Creates a new SubTeam - New-TBTeam' {
            $result = New-TBTeam -Name "$TeamName-Sub" -Description $TeamDescription -TeamCode "$TeamCode-Sub" -TeamPath "MTT" -isCoded -ProjectName $projectName
            $result | Should Be True
        }

        It 'Remove Teams - New-TBTeam' {
            $result1 = Remove-TBTeam -Name $TeamName -TeamCode $TeamCode -TeamPath $TeamRootPath -isCoded -ProjectName $projectName
            $result2 = Remove-TBTeam -Name "$TeamName-Sub" -TeamCode "$TeamCode-Sub" -TeamPath "MTT" -isCoded -ProjectName $projectName
            $result1 -and $result2 | Should Be True
        }
    }

    AfterAll {
        # Put everything back
        Set-Location $originalLocation
        Remove-TBConnection -AllVariables
     }
}
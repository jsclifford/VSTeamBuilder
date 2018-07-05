[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '', Scope='*', Target='SuppressImportModule')]
$SuppressImportModule = $false
. $PSScriptRoot\Shared.ps1

Describe "Manifest & xml validation" {
    Context 'Module Manifest' {
        It 'Passes Test-ModuleManifest' {
            Test-ModuleManifest -Path $ModuleManifestPath
            $? | Should Be $true
        }
    }
}

InModuleScope VSTeamBuilder {

    Describe 'Team Area' {
        BeforeAll {
            $projectName = "VSTeamBuilderDemo"
            $TeamName = "MyTestTeam"
            $AreaPath = "MTT"
        }

        Mock Invoke-VSTeamRequest { return @{"defaultValue" = "$AreaPath"} }
        Mock _testConnection { return $true }
        $testUrl = "$($VSTBConn.AccountUrl)/$projectName/$TeamName/_apis/work/teamsettings/teamfieldvalues?api-version=3.0"

        Context 'Set-TBTeamAreaSetting' {
            #Mock Invoke-VSTeamRequest { return @{"defaultValue" = "$AreaPath"} }
            It 'Sets Team Area Default Setting - Set-TBTeamAreaSetting' {
                $result = Set-TBTeamAreaSetting -AreaPath $AreaPath -TeamName $TeamName -ProjectName $projectName
                $($result.defaultValue) -like "*$AreaPath" | Should Be True

                # Make sure it was called with the correct values
                Assert-MockCalled Invoke-VSTeamRequest -Exactly 1 -ParameterFilter {
                    $Url -eq $testUrl -and $ContentType -eq "application/json" -and $Method -eq "Patch"
                }
            }
        }

        Context 'Get-TBTeamAreaSetting' {

            It 'Gets Team Area Default Setting - Get-TBTeamAreaSetting' {
                $result = Get-TBTeamAreaSetting -TeamName $TeamName -ProjectName $projectName
                $($result.defaultValue) -like "*$AreaPath" | Should Be True

                # Make sure it was called with the correct values
                Assert-MockCalled Invoke-VSTeamRequest -Exactly 1 -ParameterFilter {
                    $Url -eq $testUrl  -and $Method -eq "Get"
                }
            }
        }
    }

    Describe 'Team Iteration Settings' {
        BeforeAll {
            $projectName = "VSTeamBuilderDemo"
            $TeamName = "MyTestTeam"
            $TeamPath = "MTT"
            $IterationName = "MTT"
            $Global:VSTBConn = @{ "AccountUrl" = "https://myproject.visualstudio.com"}
        }

        Mock _testConnection { return $true }
        Mock Get-TfsIteration { return @{"Uri" = "123123/Node/123123"}}

        Context 'Team Iteration' {
            $testUrl = "$($VSTBConn.AccountUrl)/$projectName/$TeamName/_apis/work/teamsettings?api-version=3.0"
            Mock Invoke-VSTeamRequest { return @{"backlogIteration" = @{ "name" ="$IterationName"; "id" = "1234"} } }

            It 'Sets Team Iteration Default Setting - Set-TBTeamIterationSetting' {
                $result = Set-TBTeamIterationSetting -IterationName $IterationName -TeamName $TeamName -ProjectName $projectName
                $($result.backlogIteration.name) -eq $IterationName | Should Be True

                # Make sure it was called with the correct values
                Assert-MockCalled Invoke-VSTeamRequest -Exactly 1 -ParameterFilter {
                    $Url -eq $testUrl -and $ContentType -eq "application/json" -and $Method -eq "Patch"
                }
            }

            It 'Gets Team Iteration Default Setting - Get-TBTeamIterationSetting' {
                $result = Get-TBTeamIterationSetting -TeamName $TeamName -ProjectName $projectName
                $($result.backlogIteration.id) -ne $null -or $($result.backlogIteration.id) -ne "00000000-0000-0000-0000-000000000000" | Should Be True

                # Make sure it was called with the correct values
                Assert-MockCalled Invoke-VSTeamRequest -Exactly 1 -ParameterFilter {
                    $Url -eq $testUrl  -and $Method -eq "Get"
                }
            }
        }

        Context 'Add Team Iterations to team' {
            $testUrl = "$($VSTBConn.AccountUrl)/$projectName/$TeamName/_apis/work/teamsettings/iterations?api-version=3.0"
            Mock Invoke-VSTeamRequest { return @{"path" = "$IterationName\MTT-Iteration1"} }

            It 'Adds Team Iterations - Add-TBTeamIteration' {
                $IterationSub = "$IterationName\MTT-Iteration1"
                $result = Add-TBTeamIteration -IterationName $IterationName -TeamName $TeamName -ProjectName $projectName
                $($result.path) -like "*$IterationSub" | Should Be True

                # Make sure it was called with the correct values
                Assert-MockCalled Invoke-VSTeamRequest -Exactly 1 -ParameterFilter {
                    $Url -eq $testUrl -and $ContentType -eq "application/json" -and $Method -eq "Post"
                }
            }

            It 'Gets Team Iterations - Get-TBTeamIteration' {
                $result = Get-TBTeamIteration -TeamName $TeamName -ProjectName $projectName
                $($result.path) -ne $null | Should Be True

                # Make sure it was called with the correct values
                Assert-MockCalled Invoke-VSTeamRequest -Exactly 1 -ParameterFilter {
                    $Url -eq $testUrl  -and $Method -eq "Get"
                }
            }
        }

        AfterAll{
            $Global:VSTBConn = $null
        }
    }

    Describe 'TFS Permissions and Tokens' {
        BeforeAll {
            $projectName = "VSTeamBuilderDemo"
            $TeamName = "MyTestTeam"
            $TeamPath = "MTT"
            $Global:VSTBConn = @{ "AccountUrl" = "https://myproject.visualstudio.com" }
            $TeamCode = "MTT"
        }

        Mock _testConnection { return $true }

        Mock Invoke-VSTeamRequest {
            #region NamspaceCollection
            $props = @{
                "namespaceId" = "2e9eb7ed-3c0a-47d4-87c1-0ffdd275fd87";
                "name"        = "Git Repositories";
                "displayName" = "Git Repositories"
            }

            $props2 = @{
                "namespaceId" = "bf7bfa03-b2b7-47db-8113-fa2e002cc5b1";
                "name"        = "Iteration";
                "displayName" = "Iteration"
            }

            $namespacers = [PSCustomObject]@{
                Count = 2
                Value = @($(new-object -TypeName psobject -property $props),$(new-object -TypeName psobject -property $props2))
            }
            #endregion

            #region Repo Token Collection
            $props3 = @{
                "inheritPermissions" = $true;
                "token"        = "repoV2/ee61f49b-415d-4171-8ecd-59ff98e951e1/6c48366b-9615-4bd8-a6af-907db7cc8d7e";
                "acesDictionary" = @("Microsoft.IdentityModel.Claims.ClaimsIdentity";"S-1-9-1551374245-1204400969-2402986413-2179408616")
            }

            $props4 = @{
                "inheritPermissions" = $true;
                "token"        = "repoV2/efe839bb-501e-4b8b-bf9f-a99762e88fe4/456c059d-340c-488d-ac8f-ec11b8547123";
                "acesDictionary" = @("Microsoft.IdentityModel.Claims.ClaimsIdentity";"S-1-9-1551374245-1204400969-2402986413-2179408616")
            }

            $repoTokenObject = [PSCustomObject]@{
                Count = 2
                Value = @($(new-object -TypeName psobject -property $props3),$(new-object -TypeName psobject -property $props4))
            }
            #endregion

            #region Iteration Token Collection
            $props5 = @{
                "inheritPermissions" = $true;
                "token"        = "vstfs:///Classification/Node/a031c740-6c8e-4fd5-a81c-062766a6d181";
                "acesDictionary" = @("Microsoft.IdentityModel.Claims.ClaimsIdentity";"S-1-9-1551374245-1204400969-2402986413-2179408616")
            }

            $props6 = @{
                "inheritPermissions" = $true;
                "token"        = "vstfs:///Classification/Node/eb847e29-46e7-4433-9ee8-32baf1191280:vstfs:///Classification/Node/54a18dcc-1111-40c6-2222-1727130c1de6";
                "acesDictionary" = @("Microsoft.IdentityModel.Claims.ClaimsIdentity";"S-1-9-1551374245-1204400969-2402986413-2179408616")
            }

            $iterationTokenObject = [PSCustomObject]@{
                Count = 2
                Value = @($(new-object -TypeName psobject -property $props5),$(new-object -TypeName psobject -property $props6))
            }
            #endregion

            $result = $null
            if($area -eq 'securitynamespaces'){
                $result = $namespacers
            }elseif($area -eq 'accesscontrollists'){
                if($resource -eq '2e9eb7ed-3c0a-47d4-87c1-0ffdd275fd87'){
                    $result = $repoTokenObject
                }else{
                    $result = $iterationTokenObject
                }
            }else{
                $result = @('Permission','Array')
            }
            return $result
        }

        Mock Get-VSTeamGitRepository { $newrepo = [PSCustomObject]@{
            id = '456c059d-340c-488d-ac8f-ec11b8547123'
            name = $projectName
            }
            return $newrepo
        }

        Context 'Namespace' {

            It 'Gets Namespace Collection - Get-TBNamespaceCollection' {
                $namespaces = Get-TBNamespaceCollection
                $namespaces.length -gt 0 | Should Be True
            }

            It 'Get Token Collection - Get-TBTokenCollection' {
                $tokens = Get-TBTokenCollection -NamespaceId "2e9eb7ed-3c0a-47d4-87c1-0ffdd275fd87"
                $tokens.length -gt 0 | Should Be True
            }

            It 'Get Token - Get-TBToken' {
                $object = Get-VSTeamGitRepository -ProjectName $projectName -Name "$projectName"
                $objectId = $object.id
                $token = Get-TBToken -ObjectId $objectId -NsName "Git Repositories" -ProjectName $projectName
                $token.token -ne $null | Should Be True
            }
        }

        Context 'Permissions' {

            Mock Get-TBSecurityGroup {
                $mySecGroup = [PSCustomObject]@{
                    Descriptor = [PSCustomObject]@{
                        Identifier = 'S-1-9-1551374245-3141134575-507595019-3213911895-1659408356-1-3998242047-824170319-3175886546-38988226'
                        IdentityType = 'Microsoft.TeamFoundation.Identity'
                    }
                }
                return $mySecGroup
            }

            It 'Sets TFS Permission on Git Repo - Set-TBPermission' {
                $gitRepo = Get-VSTeamGitRepository -ProjectName $projectName -Name "$projectName"
                $token = Get-TBToken -ObjectId $gitRepo.id -NsName "Git Repositories" -ProjectName $projectName
                $result = Set-TBPermission -TokenObject $token -GroupName "$TeamCode-Contributors" -AllowValue 118 -ProjectName $projectName
                $result.count -gt 0 | Should Be True
            }

            Mock Get-TfsIteration { $newiteration = [PSCustomObject]@{
                    uri = 'vstfs:///Classification/Node/54a18dcc-1111-40c6-2222-1727130c1de6'
                    name = "$TeamCode"
                }
                return $newiteration
            }

            It 'Sets TFS Permission on Team Iteration - Set-TBPermission' {
                $iteration = Get-TFSIteration -Iteration "$Teamcode" -Project $projectName -Collection $collectionName
                $iterationId = ($iteration.uri -split 'Node/')[1]
                $token = Get-TBToken -ObjectId $iterationId -NSName "Iteration" -ProjectName $projectName
                $result = Set-TBPermission -TokenObject $token -GroupName "$TeamCode-Contributors" -AllowValue 7 -ProjectName $projectName
                $result.count -gt 0 | Should Be True
            }
        }
    }

    Describe 'TBConnection'{
        BeforeAll {
            $projectName = "VSTeamBuilderDemo"
            $acctUrl = "https://masterkey53.visualstudio.com"
            $pat = "qqqqqqqqqqwwwwwwwwwweeeeeeeeeerrrrrrrrrrtttttttttt1234"
            $api = "VSTS"
        }

        Context 'Add-TBConnection' {
            Mock Add-VSTeamAccount { return "VSTeam Connected to VSTS" }
            Mock Connect-TfsTeamProjectCollection { return "TfsCmdlets connected"}
            It 'Connects to TFS Server - Add-TBConnection' {
                Add-TBConnection -AcctUrl $acctUrl -PAT $pat -API $api | Should Be True
            }

            It 'Sets Default Project' {
                Set-TBDefaultProject -ProjectName $projectName
                $Global:VSTBConn.DefaultProjectName | Should Be $projectName
            }

            It '_testConnection' {
                _testConnection | Should Be True
            }
        }

        Context 'Remove-TBConnection' {
            Mock Remove-VSTeamAccount { return "VSTeamaccount removed to VSTS" }
            Mock Disconnect-TfsTeamProjectCollection { return "TfsCmdlets disconnected"}

            It 'Disconnects TFS Server - Remove-TBConnection' {
                $env:TEAM_ACCT = "TEAM1234"
                $Global:TfsTpcConnection = @("test")
                Remove-TBConnection -AllVariables | Should Be True
            }

            It '_testConnection' {
                _testConnection | Should Be False
            }
        }

        AfterAll {

        }
    }
}


Describe "Not Complete Tests" {
    Context 'Add/Remove TBOrg' {
        It 'Creates new project and uses CSV as template - New-TBOrg' {
            #$result = New-TBOrg -ProjectName "$projectName-csv" -ProjectDescription "The Best Project Ever" -ImportFile "$PSScriptRoot\VSTBImportFile.csv" -NewProject
            $result | Should Be True
        }

        It 'Removes team project structure from csv file - Remove-TBOrg' {
            #$result = Remove-TBOrg -ProjectName "$projectName-csv" -ImportFile "$PSScriptRoot\VSTBImportFile.csv"
            $result | Should Be True
        }

        #Not implemented yet.
        # It 'Creates new project from xml file - New-TBOrg' {
        #     #$result = New-TBOrg -ProjectName "$projectName-xml" -ProjectDescription "The Best Project Ever" -ImportFile "$PSScriptRoot\VSTBImportFile.xml" -NewProject
        #     $result | Should Be True
        # }

        # It 'Removes team project structure from xml file - Remove-TBOrg' {
        #     #$result = Remove-TBOrg -ProjectName "$projectName-xml" -ImportFile "$PSScriptRoot\VSTBImportFile.xml"
        #     $result | Should Be True
        # }

        It 'Creates csv Template File - New-TBOrg' {
            #$result = New-TBOrg -ProjectName $projectName -ImportFile "$PSScriptRoot\VSTBImportTemplate.csv" -GenerateImportFile
            $result | Should Be True
        }

        It 'Creates xml Template File - New-TBOrg' {
            #$result = New-TBOrg -ProjectName $projectName -ImportFile "$PSScriptRoot\VSTBImportTemplate.xml" -GenerateImportFile
            $result | Should Be True
        }
    }

    Context 'Add/Remove and Test Team Settings CSV Basic Version' {
        $TeamName = "MyTestTeam"
        $TeamCode = "MTT"
        $TeamDescription = "The best Test of a new team"
        $TeamRootPath = ""

        It 'Creates a new Team - New-TBTeam' {
            #$result = New-TBTeam -Name $TeamName -Description $TeamDescription -TeamCode $TeamCode -TeamPath $TeamRootPath -isCoded -ProjectName $projectName
            $result | Should Be True
        }

        It 'Creates a new SubTeam - New-TBTeam' {
            #$result = New-TBTeam -Name "$TeamName-Sub" -Description $TeamDescription -TeamCode "$TeamCode-Sub" -TeamPath "MTT" -isCoded -ProjectName $projectName
            $result | Should Be True
        }

        It 'Team Check - New-TBTeam' {
            #$team = Get-VSTeam -Name "$TeamName" -ProjectName $projectName
            $team -ne $null | Should Be True
        }

        It 'Team Area Check - New-TBTeam' {
            #$area = Get-TfsArea -Area "$TeamCode" -ProjectName $projectName -Collection $acctUrl
            $area -ne $null | Should Be True
        }

        It 'Team Security Group Check - New-TBTeam' {
            #$teamGroups = @("Contributors","CodeReviewers","Readers")
            # $exists = $false
            # foreach($group in $teamGroups){
            #     $result = (Get-TBSecurityGroup -Name "$TeamCode-$group" -ProjectName $projectName).DisplayName
            #     if($result -like "*$TeamCode-$group"){
            #         $exists = $true
            #     }
            # }
            $exists | Should Be True
        }

        It 'Team Repo Check - New-TBTeam' {
            #$repo = Get-VSTeamGitRepository -Name "$TeamCode" -ProjectName $projectName
            $repo -ne $null | Should Be True
        }

        It 'Team Iteration Check - New-TBTeam' {
            #$iteration = Get-TfsIteration -Iteration "$TeamCode" -ProjectName $projectName -Collection $acctUrl
            $iteration -ne $null | Should Be True
        }

        It 'Remove Teams - New-TBTeam' {
            #$result1 = Remove-TBTeam -Name $TeamName -TeamCode $TeamCode -TeamPath $TeamRootPath -isCoded -ProjectName $projectName
            #$result2 = Remove-TBTeam -Name "$TeamName-Sub" -TeamCode "$TeamCode-Sub" -TeamPath "MTT" -isCoded -ProjectName $projectName
            $result1 -and $result2 | Should Be True
        }
    }

}

Describe 'TFS Security Group' {
    BeforeAll {
        $projectName = "VSTeamBuilderDemo"
        $TeamName = "MyTestTeam"
        $TeamCode = "MTT"
        $Global:VSTBConn = @{ "TeamExplorerConnection" = "https://myproject.visualstudio.com"}
    }

    Mock _testConnection { return $true }

    Context 'Create Group' {
        $TeamName = "MyTestTeam2"
        $TeamCode = "MTT2"
        $TeamDescription = "The best Test of a new team"

        It 'Creates new TFS Security Group - New-TBSecurityGroup' {
            # $createIt = New-TBSecurityGroup -Name "$Teamcode-Contributors" -ProjectName $projectName -Description $TeamDescription
            # $result = Get-TBSecurityGroup -Name "$Teamcode-Contributors" -ProjectName $projectName
            $($result.DisplayName) -like "*$Teamcode-Contributors" | Should Be True
        }

        It 'Gets TFS Security Group Get-TBSecurityGroup' {
            # $result = Get-TBSecurityGroup -Name "$Teamcode-Contributors" -ProjectName $projectName
            $($result.DisplayName) -like "*$Teamcode-Contributors" | Should Be True
        }
    }

    Context 'Security Group Member' {
        It 'Adds a team to the new group - Add-TBSecurityGroupMember' {
            # $result = Add-TBSecurityGroupMember -MemberName "$searchGroup" -GroupName "$Teamcode-Contributors" -ProjectName $projectName
            $result -eq $null | Should Be True
        }

        It 'Removes a team to the new group - Remove-TBSecurityGroupMember' {
            # $result = Remove-TBSecurityGroupMember -MemberName "$searchGroup" -GroupName "$Teamcode-Contributors" -ProjectName $projectName
            $result -eq $null | Should Be True
        }

    }

    Context 'Remove Security Group'{
        It 'Removes new TFS Security Group - Remove-TBSecurityGroup' {
            # $removeIt = Remove-TBSecurityGroup -Name "$Teamcode-Contributors" -ProjectName $projectName
            # $result = Get-TBSecurityGroup -Name "$Teamcode-Contributors" -ProjectName $projectName
            $($result.DisplayName) -like "*$Teamcode-Contributors" | Should Be False
        }
    }
}


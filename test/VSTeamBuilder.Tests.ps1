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

        Context 'Set-TBTeamAreaSetting' {
            #Mock Invoke-VSTeamRequest { return @{"defaultValue" = "$AreaPath"} }
            It 'Sets Team Area Default Setting - Set-TBTeamAreaSetting' {
                $result = Set-TBTeamAreaSetting -AreaPath $AreaPath -TeamName $TeamName -ProjectName $projectName
                $($result.defaultValue) -like "*$AreaPath" | Should Be True

                # Make sure it was called with the correct values
                Assert-MockCalled Invoke-VSTeamRequest -Exactly 1 -ParameterFilter {
                    $ProjectName -eq $projectName -and $Area -eq $TeamName -and $Method -eq "Patch"
                }
            }
        }

        Context 'Get-TBTeamAreaSetting' {

            It 'Gets Team Area Default Setting - Get-TBTeamAreaSetting' {
                $result = Get-TBTeamAreaSetting -TeamName $TeamName -ProjectName $projectName
                $($result.defaultValue) -like "*$AreaPath" | Should Be True

                # Make sure it was called with the correct values
                Assert-MockCalled Invoke-VSTeamRequest -Exactly 1 -ParameterFilter {
                    $ProjectName -eq $projectName -and $Area -eq $TeamName -and $Method -eq "Get"
                }
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

    Context 'TFS Security Group' {
        $TeamName = "MyTestTeam2"
        $TeamCode = "MTT2"
        $TeamDescription = "The best Test of a new team"

        It 'Creates new TFS Security Group - New-TBSecurityGroup' {
            #$createIt = New-TBSecurityGroup -Name "$Teamcode-Contributors" -ProjectName $projectName -Description $TeamDescription
            #$result = Get-TBSecurityGroup -Name "$Teamcode-Contributors" -ProjectName $projectName
            $($result.DisplayName) -like "*$Teamcode-Contributors" | Should Be True
        }

        It 'Gets TFS Security Group Get-TBSecurityGroup' {
            #$result = Get-TBSecurityGroup -Name "$Teamcode-Contributors" -ProjectName $projectName
            $($result.DisplayName) -like "*$Teamcode-Contributors" | Should Be True
        }

        It 'Adds a team to the new group - Add-TBSecurityGroupMember' {
            #$result = Add-TBSecurityGroupMember -MemberName "$searchGroup" -GroupName "$Teamcode-Contributors" -ProjectName $projectName
            $result -eq $null | Should Be True
        }

        It 'Removes a team to the new group - Remove-TBSecurityGroupMember' {
            #$result = Remove-TBSecurityGroupMember -MemberName "$searchGroup" -GroupName "$Teamcode-Contributors" -ProjectName $projectName
            $result -eq $null | Should Be True
        }

        It 'Removes new TFS Security Group - Remove-TBSecurityGroup' {
            #$removeIt = Remove-TBSecurityGroup -Name "$Teamcode-Contributors" -ProjectName $projectName
            #$result = Get-TBSecurityGroup -Name "$Teamcode-Contributors" -ProjectName $projectName
            $($result.DisplayName) -like "*$Teamcode-Contributors" | Should Be False
        }
    }



    Context 'Team Iteration' {
        $TeamName = "MyTestTeam"
        $IterationName = "MTT"
        It 'Sets Team Iteration Default Setting - Set-TBTeamIterationSetting' {
            #$result = Set-TBTeamIterationSetting -IterationName $IterationName -TeamName $TeamName -ProjectName $projectName
            $($result.backlogIteration.name) -eq $IterationName | Should Be True
        }

        It 'Gets Team Iteration Default Setting - Get-TBTeamIterationSetting' {
            #$result = Get-TBTeamIterationSetting -TeamName $TeamName -ProjectName $projectName
            $($result.backlogIteration.id) -ne $null -or $($result.backlogIteration.id) -ne "00000000-0000-0000-0000-000000000000" | Should Be True
        }

        It 'Adds Team Iterations - Add-TBTeamIteration' {
            #$IterationSub = "$IterationName\MTT-Iteration1"
            #$result = Add-TBTeamIteration -IterationName $IterationName -TeamName $TeamName -ProjectName $projectName
            $($result.path) -like "*$IterationSub" | Should Be True
        }

        It 'Gets Team Iterations - Get-TBTeamIteration' {
            #$result = Get-TBTeamIteration -TeamName $TeamName -ProjectName $projectName
            $($result.value) -ne $null | Should Be True
        }
    }

    Context 'TFS Permissions and Tokens' {
        $TeamCode = "MTT"

        It 'Gets Namespce Collection - Get-TBNamespaceCollection' {
            #$namespaces = Get-TBNamespaceCollection
            $namespaces.length -gt 0 | Should Be True
        }

        It 'Get Token Collection - Get-TBTokenCollection' {
            #$namespaces = Get-TBNamespaceCollection
            #$tokens = Get-TBTokenCollection -NamespaceId "2e9eb7ed-3c0a-47d4-87c1-0ffdd275fd87"
            $tokens.length -gt 0 | Should Be True
        }

        It 'Get Token - Get-TBToken' {
            #$object = Get-VSTeamGitRepository -ProjectName $projectName -Name "$projectName"
            #$objectId = $object.id
            #$token = Get-TBToken -ObjectId $objectId -NsName "Git Repositories" -ProjectName $projectName
            $token.token -ne $null | Should Be True
        }

        It 'Sets TFS Permission on Git Repo - Set-TBPermission' {
            # $gitRepo = Get-VSTeamGitRepository -ProjectName $projectName -Name "$projectName"
            # $token = Get-TBToken -ObjectId $gitRepo.id -NsName "Git Repositories" -ProjectName $projectName
            # $result = Set-TBPermission -TokenObject $token -GroupName "$TeamCode-Contributors" -AllowValue 118 -ProjectName $projectName
            $result.count -gt 0 | Should Be True
        }

        It 'Sets TFS Permission on Team Iteration - Set-TBPermission' {
            # $iteration = Get-TFSIteration -Iteration "$Teamcode" -ProjectName $projectName -Collection $collectionName
            # $token = Get-TBToken -ObjectId $iteration.Id -NSName "Iteration" -ProjectName $projectName
            # $result = Set-TBPermission -TokenObject $token -GroupName "$TeamCode-Contributors" -AllowValue 7 -ProjectName $projectName
            $result.count -gt 0 | Should Be True
        }
    }
}


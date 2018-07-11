class mTfsTeamProjectCollection{
    [object]GetService([string]$service){
       $resultObject = $null
        switch ($service) {
            "Microsoft.TeamFoundation.Framework.Client.IIdentityManagementService" { $resultObject = New-Object mIIdentitymanagementService }
            "Microsoft.TeamFoundation.Server.ICommonStructureService3" { $resultObject = New-Object mICommonStructureService3 }
        }
        return $resultObject
    }
}

class mICommonStructureService3{
    [object]GetProjectFromName([string]$projectName){
        $projectObject = [PSCustomObject]@{
            Uri = "vstfs:///Classification/TeamProject/efe839bb-501e-4b8b-bf9f-a99762e77gt3"
        }
        return $projectObject
    }
}

class mIIdentitymanagementService{
    [string]CreateApplicationGroup([string]$projectId,[string]$name,[string]$description){
        return "Group Created. Group Name: $name"
    }

    [string]DeleteApplicationGroup([string]$groupSid){
        return "GroupSid Deleted: $groupSid"
    }

    [object]ReadIdentities([object]$SearchFactor,[string]$groupName,[object]$Expanded,[object]$TrueSid){

        $groupArr = @(
            @(
                [PSCustomObject]@{
                    IsContainer = $true
                    UniqueName = vstfs:///Classification/TeamProject/efe839bb-501e-4b8b-bf9f-a99762e88fe4\$groupname
                    Descriptor = [PSCustomObject]@{
                        Identifier = "S-1-9-1551374245-3141145675-508595019-3214911895-1659678356-1-2187896479-2513455524-3216817848-116679711"
                        IdentityType = "Microsoft.TeamFoundation.Identity"
                    }
                    DisplayName = "[MyNeatProject]\$groupName"
                    IsActive = $true
                    TeamFoundationId = "79733bd3-e1fe-473f-863d-d57e058bd237"
                }
            )
        )
        return $groupArr
    }

    [string]AddMemberToApplicationGroup([string]$groupDescriptor,[string]$memberToAddDescriptor){
        return "Added member to group.  Group: $groupDescriptor ---  Member: $memberToAddDescriptor"
    }

    [string]RemoveMemberFromApplicationGroup([string]$groupDescriptor,[string]$memberToRemoveDescriptor){
        return "Added member to group.  Group: $groupDescriptor ---  Member: $memberToRemoveDescriptor"
    }
}
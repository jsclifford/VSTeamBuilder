<#          License
    GNU GENERAL PUBLIC LICENSE
     Version 3, 29 June 2007
        See License.txt
#>

function New-TBOrg
{
    [cmdletbinding(SupportsShouldProcess = $true, ConfirmImpact = "Medium")]
    Param(

        # Parameter help description
        [Parameter(Mandatory = $true)]
        [string]
        $ParameterName1,

        # Parameter help description
        [Parameter(Mandatory = $true)]
        [string]
        $ParameterName2,

        # Parameter help description
        [Parameter(Mandatory = $true)]
        [string]
        $ParameterName3,

        # Parameter help description
        [Parameter(Mandatory = $true)]
        [string]
        $ParameterName4
    )
     if($PSCmdlet.ShouldProcess("Processing section 1.")){
        #Process something here.
    }
    <#
        .SYNOPSIS
            New-TBOrg will do something wonderful.
        .DESCRIPTION
            New-TBOrg will do something wonderful.
        .EXAMPLE
            New-TBOrg -Paramater1 "test" -Paramater2 "test2" -Paramater3 "test3" -Paramater4 "test4"
    #>
}
function Remove-TBOrg
{
    [cmdletbinding(SupportsShouldProcess = $true, ConfirmImpact = "Medium")]
    Param(

        # Parameter help description
        [Parameter(Mandatory = $true)]
        [string]
        $ParameterName1,

        # Parameter help description
        [Parameter(Mandatory = $true)]
        [string]
        $ParameterName2,

        # Parameter help description
        [Parameter(Mandatory = $true)]
        [string]
        $ParameterName3,

        # Parameter help description
        [Parameter(Mandatory = $true)]
        [string]
        $ParameterName4
    )
     if($PSCmdlet.ShouldProcess("Processing section 1.")){
        #Process something here.
    }
    <#
        .SYNOPSIS
            Remove-TBOrg will do something wonderful.
        .DESCRIPTION
            Remove-TBOrg will do something wonderful.
        .EXAMPLE
            Remove-TBOrg -Paramater1 "test" -Paramater2 "test2" -Paramater3 "test3" -Paramater4 "test4"
    #>
}
function New-TBTeam
{
    [cmdletbinding(SupportsShouldProcess = $true, ConfirmImpact = "Medium")]
    [OutputType([boolean])]
    Param(

        # TFS Team Name
        [Parameter(Mandatory = $true)]
        [string]
        $Name,

        # TFS Team Description
        [Parameter(Mandatory = $true)]
        [string]
        $Description,

        # TFS TeamCode - Used for Repo, Area, and Iteration Names
        [Parameter(Mandatory = $true)]
        [string]
        $TeamCode,

        # TFS Team Iteration/Area Root Path - Nested paths must not have leading back slash. Required back slash as a seperator.
        [Parameter(Mandatory = $false)]
        [string]
        $TeamPath = "",

        # TFS RepoList - List of repo names to generate.  Default is the TeamCode
        [Parameter(Mandatory = $false)]
        [string[]]
        $RepoList = @('{TeamCode}'),

        # TFS IterationList - List of iteration names to generate.  Default is the TeamCode
        [Parameter(Mandatory = $false)]
        [string[]]
        $IterationList = @('{TeamCode}'),

        # TFS Team Security Groups - List of Application Security Groups to create.  Default is "{TeamCode}-Contributors","{TeamCode}-CodeReviewers","{TeamCode}-Readers"
        [Parameter(Mandatory = $false)]
        [string[]]
        $TeamGroups = @("Contributors","CodeReviewers","Readers"),

        # TFS TeamCode - Used for Repo, Area, and Iteration Names
        [Parameter(Mandatory = $false)]
        [string]
        $ProjectName,

        # isCoded switch will make Version Control Repos if set.
        [switch]
        $IsCoded
    )

    #region global connection Variables
    $projectNameLocal = $null
    $VSTBConn = $Global:VSTBConn
    if(! (_testConnection)){
        Write-Verbose "There is no connection made to the server.  Run Add-TBConnection to connect."
        return
    }
    if($null -eq $ProjectName){
        if($null -eq $VSTBConn.DefaultProjectName){
            Write-Verbose "No ProjectName specified."
            throw "No Default ProjectName or ProjectName Variable specified.  Set the default project or pass the project name."
        }else{
            $projectNameLocal = $VSTBConn.DefaultProjectName
        }
    }else{
        $projectNameLocal = $ProjectName
    }

    $result = $null
    #endregion

    #region Create Team Area
    if($PSCmdlet.ShouldProcess("Create Team Area.")){
        $areaExists = Get-TFSArea -Area "$TeamPath\$TeamCode" -Project $projectNameLocal -Collection $($VSTBConn.AccountUrl)
        if($null -eq $areaExists){
            $holder = New-TfsArea -Area "$TeamPath\$TeamCode" -Project $projectNameLocal -Collection $($VSTBConn.AccountUrl)
            Write-Verbose "Created Area: $TeamPath\$TeamCode"
        }else{
            Write-Verbose "Area already exists: $TeamPath\$TeamCode"
        }
    }
    #endregion

    #region Create Team Application Security Groups
    if($PSCmdlet.ShouldProcess("Create Team Application Security Groups.")){
        foreach($group in $TeamGroups){
            $holder = New-TBSecurityGroup -Name "$TeamCode-$group" -Description "$TeamCode-$group" -ProjectName $projectNameLocal
            Write-Verbose "Created TFS Application Security Group: $TeamCode-$group"
        }
    }
    #endregion

    #region Create Team and set default area.
    if($PSCmdlet.ShouldProcess("Create Team and set default area.")){
        $teamExists = $null
        try{
            $teamExists = Get-VSTeam -Name $Name -Project $projectNameLocal -ErrorAction SilentlyContinue
        }catch{
            $teamExists = $null
        }
        if($null -eq $teamExists){
            $holder = Add-VSTeam -TeamName $Name -Description $Description -ProjectName $projectNameLocal
            Write-Verbose "Created Team: $Name"
        }

        #Setting Default Area.
        $holder = Set-TBTeamAreaSetting -TeamName $Name -AreaPath "$TeamPath\$TeamCode" -ProjectName $projectNameLocal
        Write-Verbose "Set team Area $TeamPath\$TeamCode to team $Name"
    }
    #endregion

    #TODO
    #region Add Team Lead and team members
    if($PSCmdlet.ShouldProcess("Processing section 1.")){
        #Process something here.
    }
    #endregion

    #region Create Version Control Repos
    if($IsCoded){
        if($PSCmdlet.ShouldProcess("Create Version Control Repos")){
            foreach($repoName in $RepoList){
                $FullReponame = "$TeamCode-$repoName"
                if($repoName -eq '{TeamCode}'){
                    $FullReponame = "$TeamCode"
                }
                $repoExists = $null
                try {
                    $repoExists = Get-VSTeamGitRepository -ProjectName $ProjectName -Name "$FullRepoName"
                }
                catch {
                    $repoExists = $null
                }

                if($null -eq $repoExists){
                    #Creating Repo
                    $holder = Add-VSTeamGitRepository -Name "$FullRepoName" -ProjectName $projectNameLocal
                    #$holder = New-TFSGitRepository -Name "$FullRepoName" -Project $projectNameLocal -Collection $($VSTBConn.AccountUrl)
                    Write-Verbose "$FullReponame Repo Created."
                }else{
                    Write-Verbose "$FullReponame Repo already exists.  "
                }
                $repoExists = $null
            }
        }
    }else{
        Write-Verbose "This team is Non-Coded.  No Version Control Repos will be created."
    }
    #endregion

    #region Create Team Iterations and set default iteration for the team.
    $teamIterationRootPath = "$TeamPath\$TeamCode"
    if($PSCmdlet.ShouldProcess("Create Team Iterations and set default iteration for the team.")){
        foreach($iteration in $IterationList){
            if($iteration -eq '{TeamCode}'){
               $iteration = $teamIterationRootPath
            }else{
                $iteration = "$teamIterationRootPath\$iteration"
            }
            $iterationExists = Get-TFSIteration -Iteration "$iteration" -Project $projectNameLocal -Collection $($VSTBConn.AccountUrl)
            if($null -eq $iterationExists){
                #Creating Repo
                $holder = New-TFSIteration -Iteration "$iteration" -Project $projectNameLocal -Collection $($VSTBConn.AccountUrl)
                Write-Verbose "$iteration Iteration Created."

                if($iteration -eq $teamIterationRootPath){
                    $holder = Set-TBTeamIterationSetting -IterationName $iteration -TeamName $Name -ProjectName $projectNameLocal
                    Write-Verbose "Set Default Backlog Iteration to Team: $Name. Iteration Set: $iteration"
                }else{
                    $holder = Add-TBTeamIteration -IterationName $iteration -TeamName $Name -ProjectName $projectNameLocal
                    Write-Verbose "Added iteration $iteration to Team: $Name"
                }
            }else{
                Write-Verbose "$teamIterationRootPath\$iteration Iteration already exists.  "
            }
            $repoExists = $null
        }
    }
    #endregion

    #TODO
    #region Create Team Work Item Query Folder and Work Item Query
    if($PSCmdlet.ShouldProcess("Processing section 1.")){
        #Process something here.
    }
    #endregion

    #TODO
    #region Create Build Folder and default build definition
    if($PSCmdlet.ShouldProcess("Processing section 1.")){
        #Process something here.
    }
    #endregion

    #region Assign TFS Application Groups permissions to objects.
    #region Permissions for VersionControl Repos
    if($PSCmdlet.ShouldProcess("Assign Version Control Permissions.")){
        foreach($repoName in $RepoList){
            $FullReponame = "$TeamCode-$repoName"
            if($repoName -eq '{TeamCode}'){
                $FullReponame = "$TeamCode"
            }
            try{
                $repo = Get-VSTeamGitRepository -Name $FullReponame -ProjectName $projectNameLocal
            }catch{
                $repo = $null
            }

            if($null -eq $repo){
                continue
            }

            $repoToken = Get-TBToken -ObjectId $repo.id -NsName "Git Repositories" -ProjectName $projectNameLocal
            try{
                #TODO Need to add foreach loop to process through TeamGroups Variable.
                $holder = Set-TBPermission -TokenObject $repoToken -GroupName "$TeamCode-Contributors" -AllowValue 118 -ProjectName $projectNameLocal
                $holder = Set-TBPermission -TokenObject $repoToken -GroupName "$TeamCode-Readers" -AllowValue 2 -ProjectName $projectNameLocal
            }catch{
                Write-Verbose "There was an error in setting permissions.  $_"
                $result  = $false
            }
            $repo = $null
        }
    }
    #endregion

    #region Permissions for Iterations
    if($PSCmdlet.ShouldProcess("Assign Iteration Permissions.")){
        $iterationDefault = Get-TFSIteration -Iteration "$teamIterationRootPath" -Project $projectNameLocal -Collection $($VSTBConn.AccountUrl)
        $iterationId = ($iterationDefault.Uri -split "Node/")[1]

        $iterationToken = Get-TBToken -ObjectId $iterationId -NsName "Iteration" -ProjectName $projectNameLocal
        try{
            #TODO Need to add foreach loop to process through TeamGroups Variable.
            $holder = Set-TBPermission -TokenObject $iterationToken -GroupName "$TeamCode-Contributors" -AllowValue 7 -ProjectName $projectNameLocal
            $holder = Set-TBPermission -TokenObject $iterationToken -GroupName "$TeamCode-Readers" -AllowValue 1 -ProjectName $projectNameLocal
        }catch{
            Write-Verbose "There was an error in setting permissions.  $_"
            $result = $false
        }

    }
    #endregion Permissions for Iterations

    #region Permissions for Areas
    if($PSCmdlet.ShouldProcess("Assign Area Permissions.")){
        $areaDefault = Get-TFSArea -Area "$TeamPath\$Teamcode" -Project $projectNameLocal -Collection $($VSTBConn.AccountUrl)
        $areaId = ($areaDefault.Uri -split "Node/")[1]

        $areaToken = Get-TBToken -ObjectId $areaId -NsName "CSS" -ProjectName $projectNameLocal
        try{
            #TODO Need to add foreach loop to process through TeamGroups Variable.
            $holder = Set-TBPermission -TokenObject $areaToken -GroupName "$TeamCode-Contributors" -AllowValue 49 -ProjectName $projectNameLocal
            $holder = Set-TBPermission -TokenObject $areaToken -GroupName "$TeamCode-Readers" -AllowValue 17 -ProjectName $projectNameLocal
        }catch{
            Write-Verbose "There was an error in setting permissions.  $_"
            $result = $false
        }

    }
    #endregion Permissions for Areas

    #region Permissions for Project
    if($PSCmdlet.ShouldProcess("Assign Project Permissions.")){
        $namespaceId = (Get-TBNamespaceCollection | Where-Object -Property name -eq "Project").namespaceId
        $projectObject = Get-TFSTeamProject -Project $projectNameLocal -Collection $($VSTBConn.AccountUrl)
        $projectToken = "`$PROJECT:$($projectObject.Uri)"
        $props = @{
            "namespaceId" = $namespaceId
            "token" = $projectToken
        }
        $projectTokenObject = New-Object -TypeName PSObject -Property $props
        try{
            #TODO Need to add foreach loop to process through TeamGroups Variable.
            $holder = Set-TBPermission -TokenObject $projectTokenObject -GroupName "$TeamCode-Contributors" -AllowValue 513 -ProjectName $projectNameLocal
            $holder = Set-TBPermission -TokenObject $projectTokenObject -GroupName "$TeamCode-Readers" -AllowValue 513 -ProjectName $projectNameLocal
        }catch{
            Write-Verbose "There was an error in setting permissions.  $_"
            $result = $false
        }

    }
    #endregion Permissions for Project
    #endregion Assign TFS Application Groups permissions to objects.

    #region Add Team to TFS application security group
    if($PSCmdlet.ShouldProcess("Add Team to contributors group.")){
        $holder = Add-TBSecurityGroupMember -MemberName "$Name" -GroupName "$TeamCode-Contributors" -ProjectName $projectNameLocal
        Write-Verbose "Added Team: $Name to group $TeamCode-Contributors"
    }
    #endregion

    return $result

    <#
        .SYNOPSIS
            New-TBTeam will create a TFS Team with associated Repos, Areas, Iterations, and TFS Application Security Groups (with assigned permissions)
        .DESCRIPTION
            New-TBTeam will create a TFS Team with associated Repos, Areas, Iterations, and TFS Application Security Groups (with assigned permissions)
        .EXAMPLE
            New-TBTeam -Name "My Team" -Description "My Best Team" -Teamcode "My-Team" -TeamPath "ParentTeam\MY-TEAM" -ProjectName "MyProject" -IsCoded
    #>
}
function Remove-TBTeam
{
    [cmdletbinding(SupportsShouldProcess = $true, ConfirmImpact = "Medium")]
    Param(

        # TFS Team Name
        [Parameter(Mandatory = $true)]
        [string]
        $Name,

        # TFS TeamCode - Used for Repo, Area, and Iteration Names
        [Parameter(Mandatory = $true)]
        [string]
        $TeamCode,

        # TFS Team Iteration/Area Root Path - Nested paths must not have leading back slash. Required back slash as a seperator.
        [Parameter(Mandatory = $false)]
        [string]
        $TeamPath = "",

        # TFS RepoList - List of repo names to remove.  Default is the TeamCode
        [Parameter(Mandatory = $false)]
        [string[]]
        $RepoList = @('{TeamCode}'),

        # TFS IterationList - List of iteration names to remove.  Default is the TeamCode
        [Parameter(Mandatory = $false)]
        [string[]]
        $IterationList = @('{TeamCode}'),

        # TFS Team Security Groups - List of Application Security Groups to remove.  Default is "{TeamCode}-Contributors","{TeamCode}-CodeReviewers","{TeamCode}-Readers"
        [Parameter(Mandatory = $false)]
        [string[]]
        $TeamGroups = @("Contributors","CodeReviewers","Readers"),

        # TFS TeamCode - Used for Repo, Area, and Iteration Names
        [Parameter(Mandatory = $false)]
        [string]
        $ProjectName,

        # isCoded switch will make Version Control Repos if set.
        [switch]
        $IsCoded
    )

    #region global connection Variables
    $projectNameLocal = $null
    $VSTBConn = $Global:VSTBConn
    if(! (_testConnection)){
        Write-Verbose "There is no connection made to the server.  Run Add-TBConnection to connect."
        return
    }
    if($null -eq $ProjectName){
        if($null -eq $VSTBConn.DefaultProjectName){
            Write-Verbose "No ProjectName specified."
            throw "No Default ProjectName or ProjectName Variable specified.  Set the default project or pass the project name."
        }else{
            $projectNameLocal = $VSTBConn.DefaultProjectName
        }
    }else{
        $projectNameLocal = $ProjectName
    }

    $result = $null
    #endregion

    #region Remove Version Control Repos
    if($IsCoded){
        if($PSCmdlet.ShouldProcess("Remove Version Control Repos")){
            foreach($repoName in $RepoList){
                $FullReponame = "$TeamCode-$repoName"
                if($repoName -eq '{TeamCode}'){
                    $FullReponame = "$TeamCode"
                }
                $repoExists = Get-VSTeamGitRepository -ProjectName $ProjectName -Name "$FullRepoName"
                if($null -ne $repoExists){
                    #Creating Repo
                    $holder = Remove-VSTeamGitRepository -Name "$FullRepoName" -ProjectName $projectNameLocal
                    #$holder = New-TFSGitRepository -Name "$FullRepoName" -Project $projectNameLocal -Collection $($VSTBConn.AccountUrl)
                    Write-Verbose "$FullReponame Repo removed."
                }else{
                    Write-Verbose "$FullReponame Repo already removed.  "
                }
                $repoExists = $null
            }
        }
    }
    #endregion

    #region Remove Team Iterations.
    $teamIterationRootPath = "$TeamPath\$TeamCode"

    foreach($iteration in $IterationList){
        if($iteration -eq '{TeamCode}'){
            $iteration = $teamIterationRootPath
        }else{
            $iteration = "$teamIterationRootPath\$iteration"
        }
        $iterationExists = Get-TFSIteration -Iteration "$iteration" -Project $projectNameLocal -Collection $($VSTBConn.AccountUrl)
        if($null -ne $iterationExists){
            if($PSCmdlet.ShouldProcess("Remove Team Iteration. Iteration Name: $iteration")){
                #Creating Repo
                $holder = Remove-TFSIteration -Iteration "$iteration" -Project $projectNameLocal -Collection $($VSTBConn.AccountUrl)
                Write-Verbose "$iteration Iteration Created."
            }
        }else{
            Write-Verbose "$teamIterationRootPath\$iteration Iteration already removed.  "
        }
        $repoExists = $null
    }

    #endregion

    #region Delete Team Area
    if($PSCmdlet.ShouldProcess("Remove Team Area.")){
        $areaExists = Get-TFSArea -Area "$TeamPath\$TeamCode" -Project $projectNameLocal -Collection $($VSTBConn.AccountUrl)
        if($null -ne $areaExists){
            $holder = Remove-TfsArea -Area "$TeamPath\$TeamCode" -Project $projectNameLocal -Collection $($VSTBConn.AccountUrl)
            Write-Verbose "Removed Area: $TeamPath\$TeamCode"
        }else{
            Write-Verbose "Area already removed: $TeamPath\$TeamCode"
        }
    }
    #endregion

    #region Remove Team Application Security Groups
    if($PSCmdlet.ShouldProcess("Remove Team Application Security Groups.")){
        foreach($group in $TeamGroups){
            $holder = Remove-TBSecurityGroup -Name "$TeamCode-$group" -ProjectName $projectNameLocal
            Write-Verbose "Removed TFS Application Security Group: $TeamCode-$group"
        }
    }
    #endregion

    #region Remove Team
    if($PSCmdlet.ShouldProcess("Remove Team.")){
        $teamExists = Get-VSTeam -Team $Name -Project $projectNameLocal
        if($null -ne $teamExists){
            $holder = Remove-VSTeam -Team $Name -Project $projectNameLocal
            Write-Verbose "Removed Team: $Name"
        }
    }
    #endregion
    <#
        .SYNOPSIS
            Remove-TBTeam will remove all team security groups,areas,inerations,VersionControl Repos.
        .DESCRIPTION
            Remove-TBTeam will remove all team security groups,areas,inerations,VersionControl Repos
        .EXAMPLE
            Remove-TBTeam -Name "My Team" -Teamcode "My-Team" -TeamPath "ParentTeam\MY-TEAM" -ProjectName "MyProject" -IsCoded
    #>
}
function New-TBSecurityGroup
{
    [cmdletbinding(SupportsShouldProcess = $true, ConfirmImpact = "Medium")]
    Param(

       # Security Group Name
       [Parameter(Mandatory = $true)]
       [string]
       $Name,

       # Security group description
       [Parameter(Mandatory = $false)]
       [string]
       $Description,

       # Parameter help description
       [Parameter(Mandatory = $false)]
       [string]
       $ProjectName
    )

    #region global connection Variables
    $projectNameLocal = $null
    $VSTBConn = $Global:VSTBConn
    if(! (_testConnection)){
        Write-Verbose "There is no connection made to the server.  Run Add-TBConnection to connect."
        return
    }
    if($null -eq $ProjectName){
        if($null -eq $VSTBConn.DefaultProjectName){
            Write-Verbose "No ProjectName specified."
            throw "No Default ProjectName or ProjectName Variable specified.  Set the default project or pass the project name."
        }else{
            $projectNameLocal = $VSTBConn.DefaultProjectName
        }
    }else{
        $projectNameLocal = $ProjectName
    }

    $result = $null
    #endregion

    #region Connect to TFS/VSTS with TeamFoundation Client DLL class.
    #Team Explorer Connection
    $tExConn = $null

    try{
        $tExConn = $VSTBConn.TeamExplorerConnection
        #$tExConn.EnsureAuthenticated()
    }
    catch
    {
        Write-verbose "There was an error connection to the TFS/VSTS server. $_"
        return $null
    }
    #endregion

    #region Get TFS Project ID
    $cssService = $tExConn.GetService("Microsoft.TeamFoundation.Server.ICommonStructureService3")
    $project = $cssService.GetProjectFromName($projectNameLocal)
    $projectId = ($project.Uri -split "TeamProject/")[1]
    if($null -eq $projectId){
        Write-Verbose "Could not find project $projectNameLocal in Collection.  Exiting Function."
        return
    }else{
        Write-Verbose "Found project id: $projectNameLocal : $projectId"
    }
    #endregion

    if($PSCmdlet.ShouldProcess("Creating New team Security Group.  TeamName: $Name")){
        $idService = $tExConn.GetService("Microsoft.TeamFoundation.Framework.Client.IIdentitymanagementService")
        $group = Get-TBSecurityGroup -Name $Name -ProjectName $projectNameLocal

        if($null -eq $group.DisplayName){
            try {
                $result = $idService.CreateApplicationGroup($projectId, $Name, $Description)
                Write-Verbose "Creating new security group. Name: $Name"
                Write-Verbose "Security Group Creation Output.  $result"
            }
            catch {
                Write-Verbose "Group already exists or there was an error creating the group. Error: $_"
            }
        }

    }

    return $result


    <#
        .SYNOPSIS
            New-TBSecurityGroup will create a new TFS/VSTS Security group.
        .DESCRIPTION
            New-TBSecurityGroup will create a new TFS/VSTS Security group.
        .EXAMPLE
            New-TBSecurityGroup -Name "MySecurityGroup" -ProjectName "MyFirstProject" -Description "The best Security group."
    #>
}
function Remove-TBSecurityGroup
{
    [cmdletbinding(SupportsShouldProcess = $true, ConfirmImpact = "Medium")]
    Param(

       # Security Group Name
       [Parameter(Mandatory = $true)]
       [string]
       $Name,

       # Parameter help description
       [Parameter(Mandatory = $false)]
       [string]
       $ProjectName
    )

    #region global connection Variables
    $projectNameLocal = $null
    $VSTBConn = $Global:VSTBConn
    if(! (_testConnection)){
        Write-Verbose "There is no connection made to the server.  Run Add-TBConnection to connect."
        return
    }
    if($null -eq $ProjectName){
        if($null -eq $VSTBConn.DefaultProjectName){
            Write-Verbose "No ProjectName specified."
            throw "No Default ProjectName or ProjectName Variable specified.  Set the default project or pass the project name."
        }else{
            $projectNameLocal = $VSTBConn.DefaultProjectName
        }
    }else{
        $projectNameLocal = $ProjectName
    }

    $result = $null
    #endregion

    #region Connect to TFS/VSTS with TeamFoundation Client DLL class.
    #Team Explorer Connection
    $tExConn = $null

    try{
        $tExConn = $VSTBConn.TeamExplorerConnection
        #$tExConn.EnsureAuthenticated()
    }
    catch
    {
        Write-verbose "There was an error connection to the TFS/VSTS server. $_"
        return $null
    }
    #endregion

    #region Get TFS Project ID
    # $cssService = $tExConn.GetService("Microsoft.TeamFoundation.Server.ICommonStructureService3")
    # $project = $cssService.GetProjectFromName($projectNameLocal)
    # $projectId = ($project.Uri -split "TeamProject/")[1]
    # if($null -eq $projectId){
    #     Write-Verbose "Could not find project $projectNameLocal in Collection.  Exiting Function."
    #     return
    # }else{
    #     Write-Verbose "Found project id: $projectNameLocal : $projectId"
    # }
    #endregion

    if($PSCmdlet.ShouldProcess("Remove team Security Group.  GroupName: $Name")){
        $idService = $tExConn.GetService("Microsoft.TeamFoundation.Framework.Client.IIdentitymanagementService")
        $group = Get-TBSecurityGroup -Name $Name -ProjectName $projectNameLocal

        if($group.DisplayName -like "*$Name"){
            try {
                $groupSID = $group.Descriptor
                $result = $idService.DeleteApplicationGroup($groupSID)
                Write-Verbose "Removing security group. Name: $Name"
                Write-Verbose "Security Group Removal Output.  $result"
            }
            catch {
                Write-Verbose "Group doesn't exists or there was an error removing the group. error: $_"
            }
        }

    }

    return $result


    <#
        .SYNOPSIS
            Remove-TBSecurityGroup will remove a TFS/VSTS Security group.
        .DESCRIPTION
            Remove-TBSecurityGroup will remove a TFS/VSTS Security group.
        .EXAMPLE
            Remove-TBSecurityGroup -Name "MySecurityGroup" -ProjectName "MyFirstProject"
    #>
}
function Get-TBSecurityGroup
{
    [cmdletbinding()]
    Param(

        # Security Group Name
        [Parameter(Mandatory = $true)]
        [string]
        $Name,

        # Project Name
        [Parameter(Mandatory = $false)]
        [string]
        $ProjectName
    )

    #region global connection Variables
    $projectNameLocal = $null
    $VSTBConn = $Global:VSTBConn
    if(! (_testConnection)){
        Write-Verbose "There is no connection made to the server.  Run Add-TBConnection to connect."
        return
    }
    if($null -eq $ProjectName){
        if($null -eq $VSTBConn.DefaultProjectName){
            Write-Verbose "No ProjectName specified."
            throw "No Default ProjectName or ProjectName Variable specified.  Set the default project or pass the project name."
        }else{
            $projectNameLocal = $VSTBConn.DefaultProjectName
        }
    }else{
        $projectNameLocal = $ProjectName
    }
    #endregion

    #region Connect to TFS/VSTS with TeamFoundation Client DLL class.
    #Team Explorer Connection
    $tExConn = $null

    try{
        $tExConn = $VSTBConn.TeamExplorerConnection
        #$tExConn.EnsureAuthenticated()
    }
    catch
    {
        Write-verbose "There was an error connection to the TFS/VSTS server. $_"
        return $null
    }
    #endregion

    $tfsSecGroup = ""

    $idService = $tExConn.GetService("Microsoft.TeamFoundation.Framework.Client.IIdentityManagementService")
    $groupArr = $null
    try{
        $groupArr = $idService.ReadIdentities([Microsoft.TeamFoundation.Framework.Common.IdentitySearchFactor]::AccountName,
            "[$projectNameLocal]\$Name",
            [Microsoft.TeamFoundation.Framework.Common.MembershipQuery]::Expanded,
            [Microsoft.TeamFoundation.Framework.Common.ReadIdentityOptions]::TrueSid)

        $tfsSecGroup = $groupArr[0][0]
    }catch{
        Write-Verbose "There was an error with the query. Error: $_"
    }

    Write-Verbose "Security Group Found.  Name: $Name"

    return $tfsSecGroup

    <#
        .SYNOPSIS
            Get-TBSecurityGroup outputs the TFS security group object.
        .DESCRIPTION
            Get-TBSecurityGroup outputs the TFS security group object.
        .EXAMPLE
            Get-TBSecurityGroup -Name "MySecurityGroup" -ProjectName "MyFirstProject"
    #>
}
function Add-TBSecurityGroupMember
{
    [cmdletbinding(SupportsShouldProcess = $true, ConfirmImpact = "Medium")]
    Param(

        # TFS Member Name
        [Parameter(Mandatory = $true)]
        [string]
        $MemberName,

        # GroupName to apply member to.
        [Parameter(Mandatory = $true)]
        [string]
        $GroupName,

        # Project Name.
        [Parameter(Mandatory = $false)]
        [string]
        $ProjectName
    )

    #region global connection Variables
    $projectNameLocal = $null
    $VSTBConn = $Global:VSTBConn
    if(! (_testConnection)){
        Write-Verbose "There is no connection made to the server.  Run Add-TBConnection to connect."
        return
    }
    if($null -eq $ProjectName){
        if($null -eq $VSTBConn.DefaultProjectName){
            Write-Verbose "No ProjectName specified."
            throw "No Default ProjectName or ProjectName Variable specified.  Set the default project or pass the project name."
        }else{
            $projectNameLocal = $VSTBConn.DefaultProjectName
        }
    }else{
        $projectNameLocal = $ProjectName
    }

    $result = $null
    #endregion

    #region Connect to TFS/VSTS with TeamFoundation Client DLL class.
    #Team Explorer Connection
    $tExConn = $null

    try{
        $tExConn = $VSTBConn.TeamExplorerConnection
        #$tExConn.EnsureAuthenticated()
    }
    catch
    {
        Write-verbose "There was an error connection to the TFS/VSTS server. $_"
        return $null
    }
    #endregion

    if($PSCmdlet.ShouldProcess("Add Member to Security Group")){
        $idService = $tExConn.GetService("Microsoft.TeamFoundation.Framework.Client.IIdentityManagementService")
        $group = Get-TBSecurityGroup -Name $GroupName -ProjectName $projectNameLocal
        $memberToAdd = Get-TBSecurityGroup -Name $MemberName -ProjectName $projectNameLocal
        if($null -ne $group.Descriptor -and $null -ne $memberToAdd.Descriptor){
            try{
                $result = $idService.AddMemberToApplicationGroup(
                    $($group.Descriptor),
                    $($memberToAdd.Descriptor)
                )
                Write-Verbose "Added member: $MemberName to GroupName: $GroupName successfully."
                Write-Verbose "Result output. $result"
            }
            catch
            {
                Write-Verbose "There was and error adding member to group.  Error: $_"
            }
        }
    }

    return $result
    <#
        .SYNOPSIS
            Add-TBSecurityGroupMember will add a TFS member to a TFS Application Security Group.
        .DESCRIPTION
            Add-TBSecurityGroupMember will add a TFS member to a TFS Application Security Group.
        .EXAMPLE
            Add-TBSecurityGroupMember -MemberName "JoeFunny" -GroupName "MyTestGroup" -ProjectName "MyFirstProject"
    #>
}
function Remove-TBSecurityGroupMember
{
    [cmdletbinding(SupportsShouldProcess = $true, ConfirmImpact = "Medium")]
    Param(

         # TFS Member Name
         [Parameter(Mandatory = $true)]
         [string]
         $MemberName,

         # GroupName to apply member to.
         [Parameter(Mandatory = $true)]
         [string]
         $GroupName,

         # Project Name.
         [Parameter(Mandatory = $false)]
         [string]
         $ProjectName
    )
     #region global connection Variables
    $projectNameLocal = $null
    $VSTBConn = $Global:VSTBConn
    if(! (_testConnection)){
        Write-Verbose "There is no connection made to the server.  Run Add-TBConnection to connect."
        return
    }
    if($null -eq $ProjectName){
        if($null -eq $VSTBConn.DefaultProjectName){
            Write-Verbose "No ProjectName specified."
            throw "No Default ProjectName or ProjectName Variable specified.  Set the default project or pass the project name."
        }else{
            $projectNameLocal = $VSTBConn.DefaultProjectName
        }
    }else{
        $projectNameLocal = $ProjectName
    }

    $result = $null
    #endregion

    #region Connect to TFS/VSTS with TeamFoundation Client DLL class.
    #Team Explorer Connection
    $tExConn = $null

    try{
        $tExConn = $VSTBConn.TeamExplorerConnection
        #$tExConn.EnsureAuthenticated()
    }
    catch
    {
        Write-verbose "There was an error connection to the TFS/VSTS server. $_"
        return $null
    }
    #endregion

    if($PSCmdlet.ShouldProcess("Add Member to Security Group")){
        $idService = $tExConn.GetService("Microsoft.TeamFoundation.Framework.Client.IIdentityManagementService")
        $group = Get-TBSecurityGroup -Name $GroupName -ProjectName $projectNameLocal
        $memberToRemove = Get-TBSecurityGroup -Name $MemberName -ProjectName $projectNameLocal
        if($null -ne $group.Descriptor -and $null -ne $memberToRemove.Descriptor){
            try{
                $result = $idService.RemoveMemberFromApplicationGroup(
                    $($group.Descriptor),
                    $($memberToRemove.Descriptor)
                )
                Write-Verbose "Removed member: $MemberName to GroupName: $GroupName successfully."
                Write-Verbose "Result output. $result"
            }
            catch
            {
                Write-Verbose "There was and error removing member to group.  Error: $_"
            }
        }
    }

    return $result
    <#
        .SYNOPSIS
            Remove-TBSecurityGroupMember will remove a TFS member to a TFS Application Security Group.
        .DESCRIPTION
            Remove-TBSecurityGroupMember will remove a TFS member to a TFS Application Security Group.
        .EXAMPLE
            Remove-TBSecurityGroupMember -MemberName "JoeFunny" -GroupName "MyTestGroup" -ProjectName "MyFirstProject"
    #>
}
function Set-TBTeamAreaSetting
{
    [cmdletbinding(SupportsShouldProcess = $true, ConfirmImpact = "Medium")]
    Param(

        # Default Area Path for the team.
        [Parameter(Mandatory = $true)]
        [string]
        $AreaPath,

        # TFS Team Name
        [Parameter(Mandatory = $true)]
        [string]
        $TeamName,

        # TFS Project Name
        [Parameter(Mandatory = $false)]
        [string]
        $ProjectName
    )

    #region global connection Variables
    $projectNameLocal = $null
    $VSTBConn = $Global:VSTBConn
    if(! (_testConnection)){
        Write-Verbose "There is no connection made to the server.  Run Add-TBConnection to connect."
        return
    }
    if($null -eq $ProjectName){
        if($null -eq $VSTBConn.DefaultProjectName){
            Write-Verbose "No ProjectName specified."
            throw "No Default ProjectName or ProjectName Variable specified.  Set the default project or pass the project name."
        }else{
            $projectNameLocal = $VSTBConn.DefaultProjectName
        }
    }else{
        $projectNameLocal = $ProjectName
    }

    $result = $null
    #endregion

    if($AreaPath -notlike "$Projectname*"){
        $AreaPath = "$ProjectName\$AreaPath"
    }

    $props = @{
        "defaultValue"  =   "$AreaPath";
        "values"        =   @(
            @{
                "value"             =   "$AreaPath";
                "includeChildren"   =   $true;
            }
        )
    }
    $JSONObject = New-Object -TypeName PSObject -Property $props
    $JSON = ConvertTo-Json $JSONObject

    try{
        if($PSCmdlet.ShouldProcess("Adding IterationID: $iterationId to team: $TeamName")){
            $result = Invoke-VSTeamRequest -ProjectName $projectNameLocal -area "$Teamname" -resource "_apis/work/teamsettings/teamfieldvalues" -method Patch -body $JSON -ContentType "application/json" -version 2.0-preview.1
        }
    }
    catch
    {
        Write-Verbose "There was an error: $_"
    }

    return $result

    <#
        .SYNOPSIS
            Set-TBTeamAreaSetting will set the default area for the team.
        .DESCRIPTION
            Set-TBTeamAreaSetting will set the default area for the team.
        .EXAMPLE
            Set-TBTeamAreaSetting -AreaPath "Team1-AreaPath" -Teamname "MyFavoriteTeam" -ProjectName "MyFirstProject"
    #>
}
function Get-TBTeamAreaSetting
{
    [cmdletbinding()]
    Param(

         # TFS Team Name
         [Parameter(Mandatory = $true)]
         [string]
         $TeamName,

         # TFS Project Name
         [Parameter(Mandatory = $false)]
         [string]
         $ProjectName
    )

    #region global connection Variables
    $projectNameLocal = $null
    $VSTBConn = $Global:VSTBConn
    if(! (_testConnection)){
        Write-Verbose "There is no connection made to the server.  Run Add-TBConnection to connect."
        return
    }
    if($null -eq $ProjectName){
        if($null -eq $VSTBConn.DefaultProjectName){
            Write-Verbose "No ProjectName specified."
            throw "No Default ProjectName or ProjectName Variable specified.  Set the default project or pass the project name."
        }else{
            $projectNameLocal = $VSTBConn.DefaultProjectName
        }
    }else{
        $projectNameLocal = $ProjectName
    }

    $result = $null
    #endregion

    try{
        $result = Invoke-VSTeamRequest -ProjectName $projectNameLocal -area "$Teamname" -resource "_apis/work/teamsettings/teamfieldvalues" -method Get -version 2.0-preview.1
    }
    catch
    {
        Write-Verbose "There was an error: $_"
    }

    return $result

    <#
        .SYNOPSIS
            Get-TBTeamAreaSetting will get default team area.
        .DESCRIPTION
            Get-TBTeamAreaSetting will get default team area.
        .EXAMPLE
            Get-TBTeamAreaSetting -TeamName "MyTeam" -ProjectName "MyFirstProject"
    #>
}
function Set-TBTeamIterationSetting
{
    [cmdletbinding(SupportsShouldProcess = $true, ConfirmImpact = "Medium")]
    Param(

        # Adding Iteration to Team.
        [Parameter(Mandatory = $true)]
        [string]
        $IterationName,

        # TFS Team Name
        [Parameter(Mandatory = $true)]
        [string]
        $TeamName,

        # TFS Project Name
        [Parameter(Mandatory = $false)]
        [string]
        $ProjectName
    )

    #region global connection Variables
    $projectNameLocal = $null
    $VSTBConn = $Global:VSTBConn
    if(! (_testConnection)){
        Write-Verbose "There is no connection made to the server.  Run Add-TBConnection to connect."
        return
    }
    if($null -eq $ProjectName){
        if($null -eq $VSTBConn.DefaultProjectName){
            Write-Verbose "No ProjectName specified."
            throw "No Default ProjectName or ProjectName Variable specified.  Set the default project or pass the project name."
        }else{
            $projectNameLocal = $VSTBConn.DefaultProjectName
        }
    }else{
        $projectNameLocal = $ProjectName
    }

    $result = $null
    #endregion

    #region Get Iteration ID
    # Eventually replace this with VSTeam API Call instead of TFSCmdlets Module function.
    $iterationId = ""
    $iteration = Get-TfsIteration -Iteration $IterationName -Project $ProjectName -Collection $VSTBConn.AccountUrl
    $iterationId = ($iteration.Uri -split "Node/")[1]
    #endregion

    $props = @{
        "bugsBehavior"      =   "AsTasks";
        "workingDays"       =   @(
            "monday",
            "tuesday",
            "wednesday",
            "thursday",
            "friday"
        );
        "defaultIteration"  =   "$iterationId"
        "backlogIteration"  =   "$iterationId"
    }
    $JSONObject = New-Object -TypeName PSObject -Property $props
    $JSON = ConvertTo-Json $JSONObject

    try{
        if($PSCmdlet.ShouldProcess("Adding IterationID: $iterationId to team: $TeamName")){
            $result = Invoke-VSTeamRequest -ProjectName $projectNameLocal -area "$Teamname" -resource "_apis/work/teamsettings" -method Patch -body $JSON -ContentType "application/json" -version 2.0-preview.1
        }
    }
    catch
    {
        Write-Verbose "There was an error: $_"
    }

    return $result

    <#
        .SYNOPSIS
            Set-TBTeamIterationSetting set default iteration settings.
        .DESCRIPTION
            Set-TBTeamIterationSetting set default iteration settings.
        .EXAMPLE
            Set-TBTeamIterationSetting -IterationName "Team1-Iteration1" -Teamname "MyFavoriteTeam" -ProjectName "MyFirstProject"
    #>
}
function Get-TBTeamIterationSetting
{
    [cmdletbinding()]
    Param(

        # TFS Team Name
        [Parameter(Mandatory = $true)]
        [string]
        $TeamName,

        # TFS Project Name
        [Parameter(Mandatory = $false)]
        [string]
        $ProjectName
    )

    #region global connection Variables
    $projectNameLocal = $null
    $VSTBConn = $Global:VSTBConn
    if(! (_testConnection)){
        Write-Verbose "There is no connection made to the server.  Run Add-TBConnection to connect."
        return
    }
    if($null -eq $ProjectName){
        if($null -eq $VSTBConn.DefaultProjectName){
            Write-Verbose "No ProjectName specified."
            throw "No Default ProjectName or ProjectName Variable specified.  Set the default project or pass the project name."
        }else{
            $projectNameLocal = $VSTBConn.DefaultProjectName
        }
    }else{
        $projectNameLocal = $ProjectName
    }

    $result = $null
    #endregion

    try{
        $result = Invoke-VSTeamRequest -ProjectName $projectNameLocal -area "$Teamname" -resource "_apis/work/teamsettings" -method Get -version 2.0-preview.1
    }
    catch
    {
        Write-Verbose "There was an error: $_"
    }

    return $result

    <#
        .SYNOPSIS
            Get-TBTeamIterationSetting gets the Team iteration settings.
        .DESCRIPTION
            Get-TBTeamIterationSetting gets the Team iteration settings.
        .EXAMPLE
            Get-TBTeamIterationSetting -TeamName "MyTeam" -ProjectName "MyFirstProject"
    #>
}
function Add-TBTeamIteration
{
    [cmdletbinding(SupportsShouldProcess = $true, ConfirmImpact = "Medium")]
    Param(

        # Adding Iteration to Team.
        [Parameter(Mandatory = $true)]
        [string]
        $IterationName,

        # TFS Team Name
        [Parameter(Mandatory = $true)]
        [string]
        $TeamName,

        # TFS Project Name
        [Parameter(Mandatory = $false)]
        [string]
        $ProjectName
    )

    #region global connection Variables
    $projectNameLocal = $null
    $VSTBConn = $Global:VSTBConn
    if(! (_testConnection)){
        Write-Verbose "There is no connection made to the server.  Run Add-TBConnection to connect."
        return
    }
    if($null -eq $ProjectName){
        if($null -eq $VSTBConn.DefaultProjectName){
            Write-Verbose "No ProjectName specified."
            throw "No Default ProjectName or ProjectName Variable specified.  Set the default project or pass the project name."
        }else{
            $projectNameLocal = $VSTBConn.DefaultProjectName
        }
    }else{
        $projectNameLocal = $ProjectName
    }

    $result = $null
    #endregion

    #region Get Iteration ID
    # Eventually replace this with VSTeam API Call instead of TFSCmdlets Module function.
    $iterationId = ""
    $iteration = Get-TfsIteration -Iteration $IterationName -Project $ProjectName -Collection $VSTBConn.AccountUrl
    $iterationId = ($iteration.Uri -split "Node/")[1]
    #endregion

    $props = @{
        "id" = "$iterationId"
    }
    $JSONObject = New-Object -TypeName PSObject -Property $props
    $JSON = ConvertTo-Json $JSONObject

    try{
        if($PSCmdlet.ShouldProcess("Adding IterationID: $iterationId to team: $TeamName")){
            $result = Invoke-VSTeamRequest -ProjectName $projectNameLocal -area "$Teamname" -resource "_apis/work/teamsettings/iterations" -method Post -body $JSON -ContentType "application/json" -version 2.0-preview.1
        }
    }
    catch
    {
        Write-Verbose "There was an error: $_"
    }

    return $result

    <#
        .SYNOPSIS
            Add-TBTeamIteration adds an iteration to a team.
        .DESCRIPTION
            Add-TBTeamIteration adds an iteration to a team.
        .EXAMPLE
            Add-TBTeamIteration -IterationName "Team1-Iteration1" -Teamname "MyFavoriteTeam" -ProjectName "MyFirstProject"
    #>
}
function Get-TBTeamIteration
{
    [cmdletbinding()]
    Param(

        # TFS Team Name
        [Parameter(Mandatory = $true)]
        [string]
        $TeamName,

        # TFS Project Name
        [Parameter(Mandatory = $false)]
        [string]
        $ProjectName
    )

    #region global connection Variables
    $projectNameLocal = $null
    $VSTBConn = $Global:VSTBConn
    if(! (_testConnection)){
        Write-Verbose "There is no connection made to the server.  Run Add-TBConnection to connect."
        return
    }
    if($null -eq $ProjectName){
        if($null -eq $VSTBConn.DefaultProjectName){
            Write-Verbose "No ProjectName specified."
            throw "No Default ProjectName or ProjectName Variable specified.  Set the default project or pass the project name."
        }else{
            $projectNameLocal = $VSTBConn.DefaultProjectName
        }
    }else{
        $projectNameLocal = $ProjectName
    }

    $result = $null
    #endregion

    try{
        $result = Invoke-VSTeamRequest -ProjectName $projectNameLocal -area "$Teamname" -resource "_apis/work/teamsettings/iterations" -method Get -version 2.0-preview.1
    }
    catch
    {
        Write-Verbose "There was an error: $_"
    }

    return $result
    <#
        .SYNOPSIS
            Get-TBTeamIteration Retrieves teh Team Iteration object.
        .DESCRIPTION
            Get-TBTeamIteration Retrieves teh Team Iteration object.
        .EXAMPLE
            Get-TBTeamIteration -TeamName "MyTeam" -ProjectName "MyFirstProject"
    #>
}
function Set-TBPermission
{
    [cmdletbinding(SupportsShouldProcess = $true, ConfirmImpact = "Medium")]
    Param(

        # TFS Token Object
        [Parameter(Mandatory = $true)]
        [Object]
        $TokenObject,

        # Group Name to assign permission to.
        [Parameter(Mandatory = $true)]
        [string]
        $GroupName,

        # NamespaceID obtained from TFS API guide or Get-TBNamespaceCollection
        # [Parameter(Mandatory = $true)]
        # [string]
        # $NamespaceId,

        # Allow Permission value.  Allow Permission values are added together like linux unix file permissions.
        [Parameter(Mandatory = $false)]
        [int]
        $AllowValue = 0,

        # Deny Permission value.  Deny Permission values are added together like linux unix file permissions.
        [Parameter(Mandatory = $false)]
        [int]
        $DenyValue = 0,

        # Will not merge settings and wipe permissions of token
        [switch]
        $NoMerge,

        # TFS/VSTS Project Name
        [Parameter(Mandatory = $false)]
        [string]
        $ProjectName
    )

    #region global connection Variables
    $projectNameLocal = $null
    $VSTBConn = $Global:VSTBConn
    if(! (_testConnection)){
        Write-Verbose "There is no connection made to the server.  Run Add-TBConnection to connect."
        return
    }
    if($null -eq $ProjectName){
        if($null -eq $VSTBConn.DefaultProjectName){
            Write-Verbose "No ProjectName specified."
            throw "No Default ProjectName or ProjectName Variable specified.  Set the default project or pass the project name."
        }else{
            $projectNameLocal = $VSTBConn.DefaultProjectName
        }
    }else{
        $projectNameLocal = $ProjectName
    }

    $result = $null
    #endregion

    $SecurityGroup = Get-TBSecurityGroup -Name $GroupName -ProjectName $projectNameLocal
    if($null -ne $SecurityGroup){
        $Descriptor = "$($SecurityGroup.Descriptor.IdentityType);$($SecurityGroup.Descriptor.Identifier)"

        $merge = $true
        if($NoMerge){
            $merge = $false
        }

        $props = @{
            "token"                 =   "$($TokenObject.token)";
            "merge"                 =   $merge;
            "accessControllEntries" =   @(
                @{
                    "descriptor"    =   "$Descriptor";
                    "allow"         =   $AllowValue;
                    "deny"          =   $DenyValue;
                    "extendedinfo"  =   @{}
                }
            )
        }

        $JSONObject = New-Object -TypeName PSObject -Property $props
        $JSON = Convertto-Json $JSONObject -Depth 20
        try{
            if($PSCmdlet.ShouldProcess("Setting permission on token $TFSToken for Group name $GroupName")){
                $result = Invoke-VSTeamRequest -area "accesscontrolentries" -resource $($TokenObject.namespaceId) -method Post -body $JSON -ContentType "application/json" -version 1.0
            }
        }
        catch
        {
            Write-Verbose "There was an error: $_"
        }

    }

    return $result
    <#
        .SYNOPSIS
            Set-TBPermission sets a tfs permission for a tfs token object.
        .DESCRIPTION
            Set-TBPermission sets a tfs permission for a tfs token object.
        .EXAMPLE
            Set-TBPermission -TokenObject $gitRepoToken.token -GroupName "MyTFSSecurityGroup" -AllowValue 7 -ProjectName "MyFirstProject"
            --Deprecated -- Set-TBPermission -TokenObject $gitRepoToken.token -GroupName "MyTFSSecurityGroup" -NamespaceId "00-000" -AllowValue 7 -ProjectName "MyFirstProject"
    #>
}
function Get-TBTokenCollection
{
    [cmdletbinding()]
    Param(

        # TFS Namespace ID
        [Parameter(Mandatory = $true)]
        [string]
        $NamespaceId,

        # Force Refresh of Token Collection
        [switch]
        $ForceRefresh
    )
    #region global connection Variables
    $VSTBConn = $Global:VSTBConn
    if(! (_testConnection)){
        Write-Verbose "There is no connection made to the server.  Run Add-TBConnection to connect."
        return
    }
    #endregion

    $TokenCollection = $null
    if($null -eq $Global:VSTBTokencollection)
    {
        $Global:VSTBTokencollection = @{}
        $TokenCollection = $Global:VSTBTokencollection
    }else{
        $TokenCollection = $Global:VSTBTokencollection
    }

    if($null -eq $TokenCollection[$NamespaceId] -or $ForceRefresh){
        try{
            $acls = Invoke-VSTeamRequest -area "accesscontrollists" -resource $NamespaceId -method Get -version 1.0
            $TokenCollection.Remove($NamespaceId)
            $TokenCollection.Add("$NamespaceId",$($acls.value))
        }catch{
            Write-Verbose "There was an error processing this request. $_"
        }

    }
    $Global:VSTBTokencollection = $TokenCollection
    $namespaceTokens = $TokenCollection[$NamespaceId]

    return $namespaceTokens

    <#
        .SYNOPSIS
            Get-TBTokenCollection retrieves all the tokens for a specific namespace and project.
        .DESCRIPTION
            Get-TBTokenCollection retrieves all the tokens for a specific namespace and project.
        .EXAMPLE
            Get-TBTokenCollection -NamespaceId "000"
            Outputs TFS Token Collection and sets global variable VSTBTokencollection
    #>
}
function Get-TBNamespaceCollection
{
    [cmdletbinding()]
    Param(

        # Refresh the Collection object in memory
        [switch]
        $ForceRefresh
    )

    #region global connection Variables
    $VSTBConn = $Global:VSTBConn
    if(! (_testConnection)){
        Write-Verbose "There is no connection made to the server.  Run Add-TBConnection to connect."
        return
    }
    #endregion

    if($null -eq $Global:VSTBNamespaceCollection -or $ForceRefresh){
        $namespaces = Invoke-VSTeamRequest -area "securitynamespaces" -resource "00000000-0000-0000-0000-000000000000" -method Get -version 1.0
        $Global:VSTBNamespaceCollection = $namespaces.value
        return $namespaces.value
    }else{
        return $Global:VSTBNamespaceCollection
    }
    <#
        .SYNOPSIS
            Get-TBNamespaceCollection pulls all namespaces from TFS for permission identification.
        .DESCRIPTION
            Get-TBNamespaceCollection pulls all namespaces from TFS for permission identification.  This is primarily used in Set-TBPermission.  This functions
            sets the variable $Global:VSTBNamespaceCollection.
        .EXAMPLE
            Get-TBNamespaceCollection
        .EXAMPLE
            Get-TBNamespaceCollection -ForceRefresh
            This refreshes the Global variable $Global:VSTBNamespaceCollection
    #>
}
function Get-TBToken
{
    [OutputType([PSObject])]
    [cmdletbinding()]
    Param(

        # TFS ObjectID (Group Name)
        [Parameter(Mandatory = $true)]
        [string]
        $ObjectId,

        #NamespaceName
        [Parameter(Mandatory = $false)]
        [string]
        $NsName,

        # Team Project to search from
        [Parameter(Mandatory = $false)]
        [string]
        $ProjectName
    )
    #region global connection Variables
    $projectNameLocal = $null
    $tokenCollection = $null
    $VSTBConn = $Global:VSTBConn
    if(! (_testConnection)){
        Write-Verbose "There is no connection made to the server.  Run Add-TBConnection to connect."
        return
    }
    if($null -eq $ProjectName){
        if($null -eq $VSTBConn.DefaultProjectName){
            Write-Verbose "No ProjectName specified."
            throw "No Default ProjectName or ProjectName Variable specified.  Set the default project or pass the project name."
        }else{
            $projectNameLocal = $VSTBConn.DefaultProjectName
        }
    }else{
        $projectNameLocal = $ProjectName
    }
    #endregion

    #region Get Namespaceid from name

    if($null -eq $Global:VSTBNamespaceCollection){
        $holder = Get-TBNamespaceCollection
    }

    $nameSpaceId = ($Global:VSTBNamespaceCollection | Where-Object -Property name -eq $NsName).Namespaceid

    if($null -eq $nameSpaceId){
        Write-Verbose "Could not find namespace id. Exiting."
        return
    }else{
        Write-Verbose "Found Namespace Id: $nameSpaceId"
    }
    #endregion

    #region Get VSTB Token Collection
    $tokenCollection = $null
    if($null -eq $Global:VSTBTokencollection){
        $tokenCollection = Get-TBTokenCollection -NamespaceId $nameSpaceId
    }else{
        if($Global:VSTBTokencollection.ContainsKey($nameSpaceId)){
            $tokenCollection = $Global:VSTBTokencollection[$nameSpaceId]
        }else{
            $tokenCollection = Get-TBTokenCollection -NamespaceId $nameSpaceId -Project $projectNameLocal
        }
    }
    #endregion

    $token = $tokenCollection | Where-Object -Property Token -match "^.*$ObjectId$"

    if($null -eq $token){
        $updateTokencollection = Get-TBTokenCollection -NamespaceId $nameSpaceId -Project $projectNameLocal -ForceRefresh
        $token = $updateTokencollection | Where-Object -Property Token -match "^.*$ObjectId$"
    }

    $props = @{
        "namespaceId" = $namespaceid
        "token" = $token.token
    }
    $returnObj = New-Object -TypeName PSObject -Property $props

    return $returnObj

    <#
        .SYNOPSIS
            Get-TBToken return a token object with namespaceid and token id
        .DESCRIPTION
            Get-TBToken return a token object with namespaceid and token id
        .EXAMPLE
            Get-TBToken -ObjectId "group1" -ProjectName "myproject"
            -- Deprecated -- Get-TBToken -ObjectId "group1" -NsName "security" -ProjectName "myproject"
    #>
}
function Add-TBConnection
{
    [OutputType([boolean])]
    [cmdletbinding()]
    Param(

        # TFS/VSTS AccountUrl -  For TFS this is the TFS Server url + the collectionname.
        [Parameter(Mandatory = $true)]
        [string]
        $AcctUrl,

        # PAT Token
        [Parameter(Mandatory = $false)]
        [string]
        $PAT,

        # Server Type
        [Parameter(Mandatory = $true)]
        [ValidateSet('TFS2017', 'TFS2018', 'VSTS')]
        [string]
        $API,

        # Use Windows Authentication
        [switch]
        $UseWindowsAuth
    )

    $Success = $true
    $VSTBConn = $Global:VSTBConn

    if($null -eq $VSTBConn){
        $props = @{
            "AccountUrl" = $AcctUrl
            "TeamExplorerConnection" = $null
            "DefaultProjectName" = $null
            "VSTeamAccount" = $false
            "TFSCmdletsConnection" = $false
        }

        $VSTBConn = New-Object -TypeName psobject -Property $props
    }else{
        $VSTBConn.AccountUrl = $AcctUrl
    }

    #region VSTeam Module connection
    if($null -eq $env:TEAM_ACCT){
        if($UseWindowsAuth){
            $holder = Add-VSTeamAccount -Account $AcctUrl -UseWindowsAuthentication
            $VSTBConn.VSTeamAccount = $true
            Write-Verbose "Successfully connected TFS VSTeam to: $AcctUrl"
        }elseif($null -ne $PAT){
            Add-VSTeamProfile -Account $AcctUrl -PersonalAccessToken $PAT -Version "$API" -Name tb
            Add-VSTeamAccount -Profile tb -Version $API
            $VSTBConn.VSTeamAccount = $true
            Write-Verbose "Successfully connected TFS VSTeam to: $AcctUrl"
        }else{
            Write-Verbose "No valid credentials passed.  Please set UseWindowsAuth or provide PAT token."
            $Success = $false
        }
    }else{
        Write-Verbose "Already Connected to VSTeam"
    }
    #endregion

    #region TFSCmdlets Module connection
    if ($null -eq $Global:TfsTpcConnection)
    {
        if($UseWindowsAuth){
            Connect-TfsTeamProjectCollection -Collection $AcctUrl
            $VSTBConn."TFSCmdletsConnection" = $true
            Write-Verbose "TfsCmdlets Successfully Connected to: $AcctUrl"
        }elseif($null -ne $PAT){
            $patCred = Get-TfsCredential -PersonalAccessToken $PAT
            Connect-TfsTeamProjectCollection -Collection $AcctUrl -Credential $patCred
            $VSTBConn."TFSCmdletsConnection" = $true
            Write-Verbose "TfsCmdlets Successfully Connected to: $AcctUrl"
        }else{
            Write-Verbose "No valid credentials passed.  Please set UseWindowsAuth or provide PAT token."
            $Success = $false
        }
        $VSTBConn.TeamExplorerConnection = $Global:TfsTpcConnection
    }
    else
    {
        Write-Verbose "TfsCmdlets Already Connected to Project Collection: $AcctUrl"
    }
    #endregion

    #region Team Explorer Object Model connection.
    #Looking to deprecate DLL requirement by querying RESTAPI for TFS Security groups.
    # if($null -eq $($VSTBConn.TeamExplorerConnection)){
    #     try{
    #         if($UseWindowsAuth){
    #             $tfs = [Microsoft.TeamFoundation.Client.TfsTeamProjectCollectionFactory]::GetTeamProjectCollection($AcctUrl)
    #             $VSTBconn.TeamExplorerConnection = $tfs
    #             Write-Verbose "Successfully conected TFS client DLL to: $AcctUrl"
    #         }elseif($null -ne $PAT){
    #             $netCred = New-Object 'System.Net.NetworkCredential' -ArgumentList 'dummy-pat-user', $PAT
    #             $fedCred = New-Object 'Microsoft.TeamFoundation.Client.BasicAuthCredential' -ArgumentList $netCred
    #             #$winCred = New-Object 'Microsoft.TeamFoundation.Client.WindowsCredential' -ArgumentList $netCred

    #             #$tfs = [Microsoft.TeamFoundation.Client.TfsTeamProjectCollectionFactory]::GetTeamProjectCollection($fedCred,[uri]$AcctUrl)

    #             $tfs = New-Object 'Microsoft.TeamFoundation.Client.TfsTeamProjectCollection' -ArgumentList $AcctUrl, $fedCred
    #             $VSTBconn.TeamExplorerConnection = $tfs
    #             Write-Verbose "Successfully conected TFS client DLL to: $AcctUrl"
    #         }else{
    #             Write-Verbose "No valid credentials passed.  Please set UseWindowsAuth or provide PAT token."
    #             $Success = $false
    #         }
    #     }catch{
    #         Write-Verbose "There was an error $_"
    #         $Success = $false
    #     }
    # }else{
    #     Write-Verbose "Already Connected to TFOM."
    # }
    #endregion

    $Global:VSTBConn = $VSTBConn

    return $Success

    <#
        .SYNOPSIS
            Add-TBConnection will add TB Connection to current session.
        .DESCRIPTION
            Add-TBConnection will add TB Connection to current session.  Windows Credentials and PAT tokens are only supported
            at this time.
        .EXAMPLE
            Add-TBConnection -AcctUrl "http://mywebsite.com/tfs"
    #>
}

function Remove-TBConnection
{
    [OutputType([boolean])]
    [cmdletbinding()]
    Param(
        # All Variables switch does nothing.
        [switch]
        $AllVariables
    )

    $Success = $true
    $VSTBConn = $Global:VSTBConn

    if($null -ne $VSTBConn){
        try{
            $Global:VSTBConn = $null
        }catch{
            Write-Verbose "There was an error $_"
            $Success = $false
        }
    }
    if($null -ne $env:TEAM_ACCT){
        $holder = Remove-VSTeamAccount
        $holder = Get-VSTeamProfile | Remove-VSTeamProfile -Force
    }

    if($null -ne $Global:TfsTpcConnection){
        try{
            $holder = Disconnect-TfsTeamProjectCollection -Collection $VSTBConn.AccountUrl
            Write-Verbose "TFSCmdlets Disconnected to TFS Collection"
            $Global:TFSConnectionProps = $null
        }catch{
            Write-Verbose "There was an error $_"
        }

    }

    $Global:VSTBNamespaceCollection = $null
    $Global:VSTBTokencollection = $null

    if($Success){
        Write-Verbose "Successfully Disconnected"
    }else{
        Write-Verbose "There was an error disconnecting."
    }

    return $Success
    <#
        .SYNOPSIS
            Remove-TBConnection will remove Global Variable for this module.
        .DESCRIPTION
            Remove-TBConnection will remove Global Variable for this module.
        .EXAMPLE
            Remove-TBConnection
    #>
}

function _testConnection
{
    [OutputType([boolean])]
    [cmdletbinding()]
    Param(
        # Test all variables
        [switch]
        $TestAll
    )

    $VSTBConn = $Global:VSTBConn
    if($null -eq $VSTBConn.AccountUrl -and $null -eq $VSTBConn.TeamExplorerConnection){
        return $false
    }else{
        return $true
    }
    <#
        .SYNOPSIS
            _testTBConnection tests if TFS connection is made.
        .DESCRIPTION
            _testTBConnection tests if TFS connection is made.
        .EXAMPLE
            _testTBConnection
    #>
}

function Set-TBDefaultProject
{
    [cmdletbinding()]
    Param(

        # TFS/VSTS Project
        [Parameter(Mandatory = $true)]
        [string]
        $ProjectName
    )
    $VSTBConn = $null
    if($null -eq $Global:VSTBConn){
        $props = @{
            "AccountUrl" = $null
            "TeamExplorerConnection" = $null
            "DefaultProjectName" = $ProjectName
            "VSTeamAccount" = $false
            "TFSCmdletsConnection" = $false
        }

        $VSTBConn = New-Object -TypeName psobject -Property $props
        $Global:VSTBConn = $VSTBConn
    }else{
        $Global:VSTBConn.DefaultProjectName = $ProjectName
    }
    <#
        .SYNOPSIS
            Set-TBDefaultProject will add the project name to the $VSTBVersionTable Object.
        .DESCRIPTION
            Set-TBDefaultProject will add the project name to the $VSTBVersionTable Object and have all other
            functions use it.
        .EXAMPLE
            Set-TBDefaultProject -ProjectName "MyProjectName"
    #>
}

# Export only the functions using PowerShell standard verb-noun naming.
Export-ModuleMember -Function *-*


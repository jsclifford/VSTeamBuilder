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
            New-TBTeam will do something wonderful.
        .DESCRIPTION
            New-TBTeam will do something wonderful.
        .EXAMPLE
            New-TBTeam -Paramater1 "test" -Paramater2 "test2" -Paramater3 "test3" -Paramater4 "test4"
    #>
}
function Remove-TBTeam
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
            Remove-TBTeam will do something wonderful.
        .DESCRIPTION
            Remove-TBTeam will do something wonderful.
        .EXAMPLE
            Remove-TBTeam -Paramater1 "test" -Paramater2 "test2" -Paramater3 "test3" -Paramater4 "test4"
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
        $tExConn.EnsureAuthenticated()
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
                Write-Verbose "Group already exists or there was an error creating the group."
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
        $tExConn.EnsureAuthenticated()
    }
    catch
    {
        Write-verbose "There was an error connection to the TFS/VSTS server. $_"
        return $null
    }
    #endregion

    $tfsSecGroup = ""

    $idService = $tExConn.GetService("Microsoft.TeamFoundation.Framework.Client.IIdentitymanagementService")
    $groupArr = $idService.ReadIdentities(
                    [Microsoft.TeamFoundation.Framework.Common.IdentitySearchFactor]::AcccountName,
                    "[$projectNameLocal]\$Name",
                    [Microsoft.TeamFoundation.Framework.Common.MembershipQuery]::Expanded,
                    [Microsoft.TeamFoundation.Framework.Common.ReadIdentityOptions]::TrueSid
                )

    $tfsSecGroup = $groupArr[0][0]

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
            Add-TBSecurityGroupMember will do something wonderful.
        .DESCRIPTION
            Add-TBSecurityGroupMember will do something wonderful.
        .EXAMPLE
            Add-TBSecurityGroupMember -Paramater1 "test" -Paramater2 "test2" -Paramater3 "test3" -Paramater4 "test4"
    #>
}
function Remove-TBSecurityGroupMember
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
            Remove-TBSecurityGroupMember will do something wonderful.
        .DESCRIPTION
            Remove-TBSecurityGroupMember will do something wonderful.
        .EXAMPLE
            Remove-TBSecurityGroupMember -Paramater1 "test" -Paramater2 "test2" -Paramater3 "test3" -Paramater4 "test4"
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
    $iteration = Get-TfsIteration -Iteration $IterationName -Project $ProjectName -Collection $VSTBConn.CollectionName
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
    $iteration = Get-TfsIteration -Iteration $IterationName -Project $ProjectName -Collection $VSTBConn.CollectionName
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
        [string]
        $TFStoken,

        # Group Name to assign permission to.
        [Parameter(Mandatory = $true)]
        [string]
        $GroupName,

        # NamespaceID obtained from TFS API guide or Get-TBNamespaceCollection
        [Parameter(Mandatory = $true)]
        [string]
        $NamespaceId,

        # Allow Permission value.  Allow Permission values are added together like linux unix file permissions.
        [Parameter(Mandatory = $false)]
        [int]
        $AllowValue = 0,

        # Deny Permission value.  Deny Permission values are added together like linux unix file permissions.
        [Parameter(Mandatory = $false)]
        [int]
        $DenyValue,

        # Will not merge settings and wipe permissions of token
        [Parameter(Mandatory = $true)]
        [switch]
        $NoMerge,

        # TFS/VSTS Project Name
        [Parameter(Mandatory = $true)]
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
            "token"                 =   "$TFSToken";
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
                $result = Invoke-VSTeamRequest -area "accesscontrolentries" -resource $NamespaceId -method Post -body $JSON -ContentType "application/json" -version 1.0
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
            Set-TBPermission -TFSToken $gitRepoToken.token -GroupName "MyTFSSecurityGroup" -NamespaceId "00-000" -AllowValue 7 -ProjectName "MyFirstProject"
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
    if($null -eq $Global:TFSTokenCollection)
    {
        $Global:TFSTokenCollection = @{}
        $TokenCollection = $Global:TFSTokenCollection
    }else{
        $TokenCollection = $Global:TFSTokenCollection
    }

    if($null -eq $TokenCollection[$NamespaceId] -or $ForceRefresh){
        $acls = Invoke-VSTeamRequest -area "accesscontrollists" -resource $NamespaceId -method Get -version 1.0
        $TokenCollection.Remove($NamespaceId)
        $TokenCollection.Add("$NamespaceId",$($acls.value))
    }
    $Global:TFSTokenCollection = $TokenCollection
    $namespaceTokens = $TokenCollection[$NamespaceId]

    return $namespaceTokens

    <#
        .SYNOPSIS
            Get-TBTokenCollection retrieves all the tokens for a specific namespace and project.
        .DESCRIPTION
            Get-TBTokenCollection retrieves all the tokens for a specific namespace and project.
        .EXAMPLE
            Get-TBTokenCollection -NamespaceId "000"
            Outputs TFS Token Collection and sets global variable TFSTokenCollection
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

    if($null -eq $Global:TFSnamespaceCollection -or $ForceRefresh){
        $namespaces = Invoke-VSTeamRequest -area "securitynamespaces" -resource "00000000-0000-0000-000000000000" -method -Get -version 1.0
        $Global:TFSnamespaceCollection = $namespaces.value
        return $namespaces.value
    }else{
        return $Global:TFSnamespaceCollection
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

        # NamespaceName
        [Parameter(Mandatory = $true)]
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
        $tokenCollection = Get-TBTokenCollection -NamespaceId $nameSpaceId -Project $projectNameLocal
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
        "namespaceId" = $nameSpaceId
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
            Get-TBToken -ObjectId "group1" -NsName "security" -ProjectName "myproject"
    #>
}
function Add-TBConnection
{
    [OutputType([boolean])]
    [cmdletbinding()]
    Param(

        # TFS/VSTS Collection Name
        [Parameter(Mandatory = $true)]
        [string]
        $CollectionName,

        # TFS/VSTS Server URL or domain
        [Parameter(Mandatory = $true)]
        [string]
        $ServerURL,

        # PAT Token
        [Parameter(Mandatory = $false)]
        [string]
        $PAT
    )

    $Success = $true
    $CollectionUrl = "$ServerUrl/$CollectionName"
    $VSTBConn = $Global:VSTBConn

    if($null -eq $VSTBConn){
        # if($ServerURL -eq $null -or $ServerURL -eq ''){
        #     $ErrorState = $true
        #     throw "No ServerURL parameter available."
        # }
        $props = @{
            "ServerURL" = $ServerURL
            "CollectionName" = $CollectionName
            "TeamExplorerConnection" = $null
            "DefaultProjectName" = $null
            "VSTeamAccount" = $false
        }

        $VSTBConn = New-Object -TypeName psobject -Property $props
    }
    if($null -eq $($VSTBConn.TeamExplorerConnection)){
        try{
            #$TFSCmdletsModuleBase = (Get-Module -ListAvailable TfsCmdlets).ModuleBase

            $tfs = [Microsoft.TeamFoundation.Client.TfsTeamProjectCollectionFactory]::GetTeamProjectcollection($CollectionUrl)
            $VSTBconn.TeamExplorerConnection = $tfs
            Write-Verbose "Successfully conected TFS client DLL to: $CollectionName"
        }catch{
            Write-Verbose "There was an error $_"
            $Success = $false
        }
    }else{
        Write-Verbose "Already Connected to TFOM."
    }

    if($null -eq $env:TEAM_ACCT){
        Add-VSTeamAccount -Account $CollectionUrl -UseWindowsAuthentication
        $VSTBConn.VSTeamAccount = $true
        Write-Verbose "Successfully connected TFS VSTeam to: $CollectionName"
    }else{
        Write-Verbose "Already Connected to VSTeam"
    }

    $Global:VSTBConn = $VSTBConn

    return $Success

    <#
        .SYNOPSIS
            Add-TBConnection will add TB Connection to current session.
        .DESCRIPTION
            Add-TBConnection will add TB Connection to current session.
        .EXAMPLE
            Add-TBConnection -CollectionName "test" -ServerUrl "http://mywebsite.com/tfs"
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
        Remove-VSTeamAccount
    }
    $Global:VSTBNamespaceCollection = $null
    $Global:VSTBTokencollection = $null


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
    if($null -eq $VSTBConn.ServerURL -and $null -eq $VSTBConn.CollectionName -and $null -eq $VSTBConn.TeamExplorerConnection){
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

    $VSTBVersionTable.DefaultProject = $ProjectName
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


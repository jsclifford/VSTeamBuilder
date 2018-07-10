---
Module Name: VSTeamBuilder
Module Guid: 698282cf-f034-4476-a875-8f6591ed45d2
Download Help Link: {{Please enter FwLink manually}}
Help Version: 0.4.3
Locale: en-US
---

# VSTeamBuilder Module
## Description
Powershell Module that automates VSTS/TFS project creation and configuration for large project setups.

## VSTeamBuilder Cmdlets
### [Add-TBConnection](Add-TBConnection.md)
Add-TBConnection will add TB Connection to current session. Windows Credentials and PAT tokens are only supported at this time.

### [Add-TBSecurityGroupMember](Add-TBSecurityGroupMember.md)
Add-TBSecurityGroupMember will add a TFS member to a TFS Application Security Group.

### [Add-TBTeamIteration](Add-TBTeamIteration.md)
Add-TBTeamIteration adds an iteration to a team.

### [Get-TBNamespaceCollection](Get-TBNamespaceCollection.md)
Get-TBNamespaceCollection pulls all namespaces from TFS for permission identification. This is primarily used in Set-TBPermission. This functions sets the variable $Global:VSTBNamespaceCollection.

### [Get-TBSecurityGroup](Get-TBSecurityGroup.md)
Get-TBSecurityGroup outputs the TFS security group object.

### [Get-TBTeamAreaSetting](Get-TBTeamAreaSetting.md)
Get-TBTeamAreaSetting will get default team area.

### [Get-TBTeamIteration](Get-TBTeamIteration.md)
Get-TBTeamIteration Retrieves teh Team Iteration object.

### [Get-TBTeamIterationSetting](Get-TBTeamIterationSetting.md)
Get-TBTeamIterationSetting gets the Team iteration settings.

### [Get-TBToken](Get-TBToken.md)
Get-TBToken return a token object with namespaceid and token id

### [Get-TBTokenCollection](Get-TBTokenCollection.md)
Get-TBTokenCollection retrieves all the tokens for a specific namespace and project.

### [New-TBOrg](New-TBOrg.md)
New-TBOrg will create TFS/VSTS Project and Team structure from an associated CSV or XML file.

### [New-TBSecurityGroup](New-TBSecurityGroup.md)
New-TBSecurityGroup will create a new TFS/VSTS Security group.

### [New-TBTeam](New-TBTeam.md)
New-TBTeam will create a TFS Team with associated Repos, Areas, Iterations, and TFS Application Security Groups (with assigned permissions)

### [Remove-TBConnection](Remove-TBConnection.md)
Remove-TBConnection will remove Global Variable for this module.

### [Remove-TBOrg](Remove-TBOrg.md)
Remove-TBOrg will remove TFS/VSTS Project structure define in associated template file.

### [Remove-TBSecurityGroup](Remove-TBSecurityGroup.md)
Remove-TBSecurityGroup will remove a TFS/VSTS Security group.

### [Remove-TBSecurityGroupMember](Remove-TBSecurityGroupMember.md)
Remove-TBSecurityGroupMember will remove a TFS member to a TFS Application Security Group.

### [Remove-TBTeam](Remove-TBTeam.md)
Remove-TBTeam will remove all team security groups,areas,inerations,VersionControl Repos.

### [Set-TBDefaultProject](Set-TBDefaultProject.md)
Set-TBDefaultProject will add the project name to the $VSTBVersionTable Object.

### [Set-TBPermission](Set-TBPermission.md)
Set-TBPermission sets a tfs permission for a tfs token object.

### [Set-TBTeamAreaSetting](Set-TBTeamAreaSetting.md)
Set-TBTeamAreaSetting will set the default area for the team.

### [Set-TBTeamIterationSetting](Set-TBTeamIterationSetting.md)
Set-TBTeamIterationSetting set default iteration settings.
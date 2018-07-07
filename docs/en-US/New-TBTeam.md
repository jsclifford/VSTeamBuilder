---
external help file: VSTeamBuilder-help.xml
Module Name: VSTeamBuilder
online version:
schema: 2.0.0
---

# New-TBTeam

## SYNOPSIS
New-TBTeam will create a TFS Team with associated Repos, Areas, Iterations, and TFS Application Security Groups (with assigned permissions)

## SYNTAX

```
New-TBTeam [-Name] <String> [-Description] <String> [-TeamCode] <String> [[-TeamPath] <String>]
 [[-RepoList] <String[]>] [[-IterationList] <String[]>] [[-TeamGroups] <String[]>] [[-ProjectName] <String>]
 [-IsCoded] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
New-TBTeam will create a TFS Team with associated Repos, Areas, Iterations, and TFS Application Security Groups (with assigned permissions)

## EXAMPLES

### EXAMPLE 1
```
New-TBTeam -Name "My Team" -Description "My Best Team" -Teamcode "My-Team" -TeamPath "ParentTeam\MY-TEAM" -ProjectName "MyProject" -IsCoded
```

## PARAMETERS

### -Name
TFS Team Name

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description
TFS Team Description

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TeamCode
TFS TeamCode - Used for Repo, Area, and Iteration Names

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TeamPath
TFS Team Iteration/Area Root Path - Nested paths must not have leading back slash.
Required back slash as a seperator.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RepoList
TFS RepoList - List of repo names to generate. 
Default is the TeamCode

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: @('{TeamCode}')
Accept pipeline input: False
Accept wildcard characters: False
```

### -IterationList
TFS IterationList - List of iteration names to generate. 
Default is the TeamCode

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: @('{TeamCode}')
Accept pipeline input: False
Accept wildcard characters: False
```

### -TeamGroups
TFS Team Security Groups - List of Application Security Groups to create. 
Default is "{TeamCode}-Contributors","{TeamCode}-CodeReviewers","{TeamCode}-Readers"

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: @("Contributors","CodeReviewers","Readers")
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProjectName
TFS TeamCode - Used for Repo, Area, and Iteration Names

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IsCoded
isCoded switch will make Version Control Repos if set.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Boolean

## NOTES

## RELATED LINKS

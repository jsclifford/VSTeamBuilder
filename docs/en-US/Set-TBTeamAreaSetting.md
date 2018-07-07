---
external help file: VSTeamBuilder-help.xml
Module Name: VSTeamBuilder
online version:
schema: 2.0.0
---

# Set-TBTeamAreaSetting

## SYNOPSIS
Set-TBTeamAreaSetting will set the default area for the team.

## SYNTAX

```
Set-TBTeamAreaSetting [-AreaPath] <String> [-TeamName] <String> [[-ProjectName] <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Set-TBTeamAreaSetting will set the default area for the team.

## EXAMPLES

### EXAMPLE 1
```
Set-TBTeamAreaSetting -AreaPath "Team1-AreaPath" -Teamname "MyFavoriteTeam" -ProjectName "MyFirstProject"
```

## PARAMETERS

### -AreaPath
Default Area Path for the team.

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

### -TeamName
TFS Team Name

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

### -ProjectName
TFS Project Name

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
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

## NOTES

## RELATED LINKS

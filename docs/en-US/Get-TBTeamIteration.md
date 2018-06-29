---
external help file: VSTeamBuilder-help.xml
Module Name: VSTeamBuilder
online version:
schema: 2.0.0
---

# Get-TBTeamIteration

## SYNOPSIS
Get-TBTeamIteration Retrieves teh Team Iteration object.

## SYNTAX

```
Get-TBTeamIteration [-TeamName] <String> [[-ProjectName] <String>] [<CommonParameters>]
```

## DESCRIPTION
Get-TBTeamIteration Retrieves teh Team Iteration object.

## EXAMPLES

### EXAMPLE 1
```
Get-TBTeamIteration -TeamName "MyTeam" -ProjectName "MyFirstProject"
```

## PARAMETERS

### -TeamName
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

### -ProjectName
TFS Project Name

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

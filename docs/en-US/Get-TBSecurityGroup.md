---
external help file: VSTeamBuilder-help.xml
Module Name: VSTeamBuilder
online version:
schema: 2.0.0
---

# Get-TBSecurityGroup

## SYNOPSIS
Get-TBSecurityGroup outputs the TFS security group object.

## SYNTAX

```
Get-TBSecurityGroup [-Name] <String> [[-ProjectName] <String>] [<CommonParameters>]
```

## DESCRIPTION
Get-TBSecurityGroup outputs the TFS security group object.

## EXAMPLES

### EXAMPLE 1
```
Get-TBSecurityGroup -Name "MySecurityGroup" -ProjectName "MyFirstProject"
```

## PARAMETERS

### -Name
Security Group Name

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
Project Name

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

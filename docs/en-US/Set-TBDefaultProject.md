---
external help file: VSTeamBuilder-help.xml
Module Name: VSTeamBuilder
online version:
schema: 2.0.0
---

# Set-TBDefaultProject

## SYNOPSIS
Set-TBDefaultProject will add the project name to the $VSTBVersionTable Object.

## SYNTAX

```
Set-TBDefaultProject [-ProjectName] <String> [<CommonParameters>]
```

## DESCRIPTION
Set-TBDefaultProject will add the project name to the $VSTBVersionTable Object and have all other
functions use it.

## EXAMPLES

### EXAMPLE 1
```
Set-TBDefaultProject -ProjectName "MyProjectName"
```

## PARAMETERS

### -ProjectName
TFS/VSTS Project

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

---
external help file: VSTeamBuilder-help.xml
Module Name: VSTeamBuilder
online version:
schema: 2.0.0
---

# Get-TBTokenCollection

## SYNOPSIS
Get-TBTokenCollection retrieves all the tokens for a specific namespace and project.

## SYNTAX

```
Get-TBTokenCollection [-NamespaceId] <String> [-ForceRefresh] [<CommonParameters>]
```

## DESCRIPTION
Get-TBTokenCollection retrieves all the tokens for a specific namespace and project.

## EXAMPLES

### EXAMPLE 1
```
Get-TBTokenCollection -NamespaceId "000"
```

Outputs TFS Token Collection and sets global variable VSTBTokencollection

## PARAMETERS

### -NamespaceId
TFS Namespace ID

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

### -ForceRefresh
Force Refresh of Token Collection

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

---
external help file: VSTeamBuilder-help.xml
Module Name: VSTeamBuilder
online version:
schema: 2.0.0
---

# Get-TBNamespaceCollection

## SYNOPSIS
Get-TBNamespaceCollection pulls all namespaces from TFS for permission identification.

## SYNTAX

```
Get-TBNamespaceCollection [-ForceRefresh] [<CommonParameters>]
```

## DESCRIPTION
Get-TBNamespaceCollection pulls all namespaces from TFS for permission identification. 
This is primarily used in Set-TBPermission. 
This functions
sets the variable $Global:VSTBNamespaceCollection.

## EXAMPLES

### EXAMPLE 1
```
Get-TBNamespaceCollection
```

### EXAMPLE 2
```
Get-TBNamespaceCollection -ForceRefresh
```

This refreshes the Global variable $Global:VSTBNamespaceCollection

## PARAMETERS

### -ForceRefresh
Refresh the Collection object in memory

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

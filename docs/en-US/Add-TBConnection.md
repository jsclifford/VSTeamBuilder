---
external help file: VSTeamBuilder-help.xml
Module Name: VSTeamBuilder
online version:
schema: 2.0.0
---

# Add-TBConnection

## SYNOPSIS
Add-TBConnection will add TB Connection to current session.

## SYNTAX

```
Add-TBConnection [-CollectionName] <String> [-ServerURL] <String> [[-PAT] <String>] [<CommonParameters>]
```

## DESCRIPTION
Add-TBConnection will add TB Connection to current session.

## EXAMPLES

### EXAMPLE 1
```
Add-TBConnection -CollectionName "test" -ServerUrl "http://mywebsite.com/tfs"
```

## PARAMETERS

### -CollectionName
TFS/VSTS Collection Name

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

### -ServerURL
TFS/VSTS Server URL or domain

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

### -PAT
PAT Token

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Boolean

## NOTES

## RELATED LINKS

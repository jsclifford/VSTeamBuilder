---
external help file: VSTeamBuilder-help.xml
Module Name: VSTeamBuilder
online version:
schema: 2.0.0
---

# Get-TBToken

## SYNOPSIS
Get-TBToken return a token object with namespaceid and token id

## SYNTAX

```
Get-TBToken [-ObjectId] <String> [[-NsName] <String>] [[-ProjectName] <String>] [<CommonParameters>]
```

## DESCRIPTION
Get-TBToken return a token object with namespaceid and token id

## EXAMPLES

### EXAMPLE 1
```
Get-TBToken -ObjectId "group1" -ProjectName "myproject"
```

-- Deprecated -- Get-TBToken -ObjectId "group1" -NsName "security" -ProjectName "myproject"

## PARAMETERS

### -ObjectId
TFS ObjectID (Group Name)

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

### -NsName
NamespaceName

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

### -ProjectName
Team Project to search from

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Management.Automation.PSObject

## NOTES

## RELATED LINKS

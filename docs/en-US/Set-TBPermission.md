---
external help file: VSTeamBuilder-help.xml
Module Name: VSTeamBuilder
online version:
schema: 2.0.0
---

# Set-TBPermission

## SYNOPSIS
Set-TBPermission sets a tfs permission for a tfs token object.

## SYNTAX

```
Set-TBPermission [-TokenObject] <Object> [-GroupName] <String> [[-AllowValue] <Int32>] [[-DenyValue] <Int32>]
 [-NoMerge] [[-ProjectName] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Set-TBPermission sets a tfs permission for a tfs token object.

## EXAMPLES

### EXAMPLE 1
```
Set-TBPermission -TokenObject $gitRepoToken.token -GroupName "MyTFSSecurityGroup" -AllowValue 7 -ProjectName "MyFirstProject"
```

--Deprecated -- Set-TBPermission -TokenObject $gitRepoToken.token -GroupName "MyTFSSecurityGroup" -NamespaceId "00-000" -AllowValue 7 -ProjectName "MyFirstProject"

## PARAMETERS

### -TokenObject
TFS Token Object

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -GroupName
Group Name to assign permission to.

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

### -AllowValue
Allow Permission value. 
Allow Permission values are added together like linux unix file permissions.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -DenyValue
Deny Permission value. 
Deny Permission values are added together like linux unix file permissions.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -NoMerge
Will not merge settings and wipe permissions of token

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

### -ProjectName
TFS/VSTS Project Name

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

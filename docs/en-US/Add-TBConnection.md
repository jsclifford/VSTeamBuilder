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
Add-TBConnection [-AcctUrl] <String> [[-PAT] <String>] [-API] <String> [-UseWindowsAuth] [<CommonParameters>]
```

## DESCRIPTION
Add-TBConnection will add TB Connection to current session. 
Windows Credentials and PAT tokens are only supported
at this time.

## EXAMPLES

### EXAMPLE 1
```
Add-TBConnection -AcctUrl "http://mywebsite.com/tfs"
```

## PARAMETERS

### -AcctUrl
TFS/VSTS AccountUrl - Proper format: \[accountname\].visualstudio.com or http(s)://\[TFS Site URl\]/\[Collection Name\].

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

### -PAT
PAT Token

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

### -API
Server Type

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

### -UseWindowsAuth
Use Windows Authentication

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

### System.Boolean

## NOTES

## RELATED LINKS

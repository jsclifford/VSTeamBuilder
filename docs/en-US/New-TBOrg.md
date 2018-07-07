---
external help file: VSTeamBuilder-help.xml
Module Name: VSTeamBuilder
online version:
schema: 2.0.0
---

# New-TBOrg

## SYNOPSIS
New-TBOrg will create TFS/VSTS Project and Team structure from an associated CSV or XML file.

## SYNTAX

```
New-TBOrg [-ProjectName] <String> [[-ProjectDescription] <String>] [-ImportFile] <String>
 [[-ProcessTemplate] <String>] [-NewProject] [-GenerateImportFile] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
This function creates Teams with associated security groups, iterations, area, repos, and dashboards(future release). 
By specifying
a template file, TFS/VSTS admins can use automation to manage large projects. 
This function can be run to also reset permissions and
settins on current projects created by this tool.
Define your template and never manually create a team again.

## EXAMPLES

### EXAMPLE 1
```
New-TBOrg -ProjectName "MyTestProject" -ProjectDescription "The best project ever." -ImportFile C:\MyTFSOrgImport.csv -NewProject
```

This command creates a new Project named MyTestProject and creates teams defined in the CSV file name MyTFSOrgImport.csv. 
CSV File
import will create groups based on TeamCode and no custom names.

### EXAMPLE 2
```
New-TBOrg -ProjectName "MyTestProject" -ProjectDescription "The best project ever." -ImportFile C:\MyTFSOrgImport.xml -NewProject
```

This command creates a new Project named MyTestProject and creates teams defined in the xml file name MyTFSOrgImport.xml. 
The xml file can
define advanced settings for permissions and custom group names.

### EXAMPLE 3
```
New-TBOrg -ProjectName "MyTestProject" -XMLAdvancedImportFile C:\MyTFSOrgImport.xml -GenerateImportFile
```

This command creates a new Project named MyTestProject and creates teams defined in the CSV file name MyTFSOrgImport.csv

## PARAMETERS

### -ProjectName
Project Name

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

### -ProjectDescription
Project Description

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

### -ImportFile
Import File path.

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

### -ProcessTemplate
Project Description```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: Agile
Accept pipeline input: False
Accept wildcard characters: False
```

### -NewProject
Create new project when set.

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

### -GenerateImportFile
Generates a template file at the path specified in the ImportFile paramater.

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

### System.Boolean

## NOTES

## RELATED LINKS

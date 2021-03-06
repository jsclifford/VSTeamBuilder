---
external help file: VSTeamBuilder-help.xml
Module Name: VSTeamBuilder
online version:
schema: 2.0.0
---

# Remove-TBOrg

## SYNOPSIS
Remove-TBOrg will remove TFS/VSTS Project structure define in associated template file.

## SYNTAX

```
Remove-TBOrg [-ProjectName] <String> [[-TeamGroups] <Hashtable[]>] [-ImportFile] <String> [-DisableProgressBar]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Remove-TBOrg will remove TFS/VSTS Project structure define in associated template file.

## EXAMPLES

### EXAMPLE 1
```
Remove-TBOrg -ProjectName "MyTestProject" -ImportFile C:\MyTFSOrgImport.csv
```

### EXAMPLE 2
```
Remove-TBOrg -ProjectName "MyTestProject" -ImportFile C:\MyTFSOrgImport.xml
```

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

### -TeamGroups
TFS Team Security Groups - List of Application Security Groups to create.
       Default is "{TeamCode}-Contributors","{TeamCode}-CodeReviewers","{TeamCode}-Readers".
       Permission Numbers with categories:  Array of Hastables example below
       $TeamGroups = @(
           @{
               Name = "CodeReviewers"
               Permissions = @{
                   Git = 126
                   Iteration = 7
                   Area = 49
                   Project = 513
               }
           },
           @{
               Name = "Contributors"
               Permissions = @{
                   Git = 118
                   Iteration = 7
                   Area = 49
                   Project = 513
               }
           },
           @{
               Name = "Readers"
               Permissions = @{
                   Git = 2
                   Iteration = 1
                   Area = 49
                   Project = 513
               }
           }
       )

```yaml
Type: Hashtable[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: @(
            @{
                Name = "CodeReviewers"
                Permissions = @{
                    Git = 126
                    Iteration = 7
                    Area = 49
                    Project = 513
                }
            },
            @{
                Name = "Contributors"
                Permissions = @{
                    Git = 118
                    Iteration = 7
                    Area = 49
                    Project = 513
                }
            },
            @{
                Name = "Readers"
                Permissions = @{
                    Git = 2
                    Iteration = 1
                    Area = 49
                    Project = 513
                }
            }
        )
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

### -DisableProgressBar
Disables progress bar.

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

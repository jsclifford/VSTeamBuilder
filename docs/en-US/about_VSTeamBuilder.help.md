# VSTeamBuilder
## about_VSTeamBuilder

```
ABOUT TOPIC NOTE:
This guide includes topics on how to successfully use VSTeamBuilder
```

# SHORT DESCRIPTION
Powershell Module that automates VSTS/TFS project creation and configuration for large project configurations.

```
ABOUT TOPIC NOTE:
This guide includes topics on how to successfully use VSTeamBuilder
```

# LONG DESCRIPTION
Powershell Module that automates VSTS/TFS project creation and configuration for large project configurations. By defining your team structure and configurations, this module will create your team project with custom security groups, repos, nested areas, nested iterations and much more.

The goal of this project is to automate management of VSTS/TFS big projects.  This module is for administrators that need to create custom groups, repos, and build definitions.  This module uses the TFS API and TFS Object DLLs to create the necessary teams.

# EXAMPLES
{{ New-TBOrg -ProjectName "MyTestProject" -ProjectDescription "The best project ever." -ImportFile C:\MyTFSOrgImport.csv -NewProject }}

# TROUBLESHOOTING NOTE
All New-* functions return true or false.  All error codes can be seen when running the command with -Verbose option.

# SEE ALSO
VSTeam, VSTS, Visual Studio Code


# KEYWORDS
TFS, VSTeam, VSTS, Visual Studio

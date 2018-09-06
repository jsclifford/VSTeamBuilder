# VSTeamBuilder
Powershell Module that automates VSTS/TFS project creation and configuration for large project configurations. By defining your team structure and configurations, this module will create your team project with custom security groups, repos, nested areas, nested iterations and much more.

The goal of this project is to automate management of VSTS/TFS big projects.  This module is for administrators that need to create custom groups, repos, and build definitions.  This module uses the TFS API and TFS Object DLLs to create the necessary teams.

## Build Status

|Branch|Status|
|------|------|
|master|[![Build status](https://ci.appveyor.com/api/projects/status/scmquvxicko0u23w/branch/master?svg=true)](https://ci.appveyor.com/project/jsclifford/vsteambuilder/branch/master)|
|dev|[![Build status](https://ci.appveyor.com/api/projects/status/scmquvxicko0u23w/branch/dev?svg=true)](https://ci.appveyor.com/project/jsclifford/vsteambuilder/branch/dev)|

### CodeCove Status

[![codecov](https://codecov.io/gh/jsclifford/VSTeamBuilder/branch/master/graph/badge.svg)](https://codecov.io/gh/jsclifford/VSTeamBuilder)

## Contributors

To contribute to this project please follow the [code of conduct](https://github.com/jsclifford/VSTeamBuilder/blob/master/CODE_OF_CONDUCT.md), [contributing guide](https://github.com/jsclifford/VSTeamBuilder/blob/master/.github/CONTRIBUTING.md), and [pull request template](https://github.com/jsclifford/VSTeamBuilder/blob/master/.github/PULL_REQUEST_TEMPLATE.md).  Thank you for your help.

## Versions

### 0.8.30

Update to documentation and buildhelp task.

### 0.8.25

Fixed Build process.  InstallPath Variable in build.settings.ps1 caused build to fail.
Added appveyor as build service.

### 0.8.1

Added TeamGroups to New-TBOrg and Remove-TBOrg.  Creates
ability to customize project wide security groups and permissions.

### 0.7.3

Build Process Bug

### 0.7.1

Made New/Remove-TBOrg TFSVC aware.
Added Verbose reporting in New-TBTeam and Remove-TBTeam
Added API Version aware on Area and Iteration functions

### 0.6.1

Added SkipExistingTeam to New-TBOrg
Changed TeamGroups parameter to include ability to specify group permissions on New-TBTeam
Fixed progress bar.

### 0.5.1

Added Validation for AcctUrl variable on Add-TBConnection.
Added progress bar on New-TBOrg.

### 0.4.5

Added Validation Test to AcctUrl variable on Add-TBConnection.
This resolves inputing wrong url format.

### 0.4.2

Added PAT logon support. Alpha Release.
Removed code signing file to prevent install
error.

### 0.4.1

Added PAT logon support. Alpha Release

### 0.1.1

Initial creation of powershell functions.

### 0.1.0

Creation of the module and project Scaffolding.

# Release Notes

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

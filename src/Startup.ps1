$binDir = (Join-Path $PSScriptRoot 'lib')

# Load basic TFS client assemblies
try{
    Add-Type -Path (Join-Path $BinDir 'Microsoft.TeamFoundation.Common.dll') -Verbose
    Add-Type -Path (Join-Path $BinDir 'Microsoft.TeamFoundation.Client.dll') -Verbose
}catch{
    Write-Verbose "Could not load DLLS $_"
}

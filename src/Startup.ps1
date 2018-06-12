$binDir = (Join-Path $PSScriptRoot 'lib')

# Load basic TFS client assemblies
try{
    Add-Type -Path (Join-Path $BinDir 'Microsoft.TeamFoundation.Common.dll')
    Add-Type -Path (Join-Path $BinDir 'Microsoft.TeamFoundation.Client.dll')
}catch{
    Write-Verbose "Could not load DLLS $_"
}

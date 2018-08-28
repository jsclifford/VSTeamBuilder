$commitId = Read-Host -Prompt "Commit ID for build:"
$token = $env:AppVeyorApiToken

$headers = @{
  "Authorization" = "Bearer $token"
  "Content-type" = "application/json"
}

$body = @{
    accountName="jsclifford"
    projectSlug="VSTeamBuilder"
    branch="experimental"
    commitId="$commitId"
}
$body = $body | ConvertTo-Json

Invoke-RestMethod -Uri 'https://ci.appveyor.com/api/builds' -Headers $headers  -Body $body -Method POST
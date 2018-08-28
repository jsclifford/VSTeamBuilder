$token = $env:AppVeyorApiToken

$headers = @{
  "Authorization" = "Bearer $token"
  "Content-type" = "application/json"
}

$body = @{
    accountName="jsclifford"
    projectSlug="VSTeamBuilder"
    branch="experimental"
    commitId="e852cf1a0e71aa589b106ebd33a334d18b1550a4"
}
$body = $body | ConvertTo-Json

Invoke-RestMethod -Uri 'https://ci.appveyor.com/api/builds' -Headers $headers  -Body $body -Method POST
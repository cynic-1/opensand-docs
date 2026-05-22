$ErrorActionPreference = "Stop"

$BaseUrl = if ($env:OPENSAND_BASE_URL) { $env:OPENSAND_BASE_URL } else { "https://opensand.ai/v1" }
$Model = if ($env:OPENSAND_DROID_MODEL) { $env:OPENSAND_DROID_MODEL } else { "claude-sonnet-4-6" }
$Provider = if ($env:OPENSAND_DROID_PROVIDER) { $env:OPENSAND_DROID_PROVIDER } else { "generic-chat-completion-api" }
$MaxOutputTokens = if ($env:OPENSAND_DROID_MAX_OUTPUT_TOKENS) { [int]$env:OPENSAND_DROID_MAX_OUTPUT_TOKENS } else { 16384 }
$ApiKey = if ($env:OPENSAND_API_KEY) { $env:OPENSAND_API_KEY } else { $env:OPENAI_API_KEY }

if ([string]::IsNullOrWhiteSpace($ApiKey)) {
  $ApiKey = Read-Host "Enter your OpenSand API key"
}

if ([string]::IsNullOrWhiteSpace($ApiKey)) {
  throw "OpenSand API key is required."
}

[Environment]::SetEnvironmentVariable("OPENSAND_API_KEY", $ApiKey, "User")
$env:OPENSAND_API_KEY = $ApiKey

$ProfilePath = $PROFILE.CurrentUserAllHosts
$ProfileDir = Split-Path -Parent $ProfilePath
New-Item -ItemType Directory -Force -Path $ProfileDir | Out-Null
if (-not (Test-Path $ProfilePath)) {
  New-Item -ItemType File -Force -Path $ProfilePath | Out-Null
}
Copy-Item $ProfilePath "$ProfilePath.opensand.bak.$(Get-Date -Format yyyyMMddHHmmss)" -Force

$ProfileContent = Get-Content $ProfilePath -Raw
$ProfileContent = [regex]::Replace($ProfileContent, "(?ms)^# >>> OpenSand Droid CLI env >>>.*?^# <<< OpenSand Droid CLI env <<<\r?\n?", "")
$EnvBlock = @"
# >>> OpenSand Droid CLI env >>>
`$env:OPENSAND_API_KEY = "$ApiKey"
# <<< OpenSand Droid CLI env <<<
"@
Set-Content -Path $ProfilePath -Value ($ProfileContent.TrimEnd() + "`r`n`r`n" + $EnvBlock + "`r`n") -Encoding UTF8

$SettingsDir = Join-Path $HOME ".factory"
$SettingsPath = Join-Path $SettingsDir "settings.json"
New-Item -ItemType Directory -Force -Path $SettingsDir | Out-Null
if (-not (Test-Path $SettingsPath)) {
  Set-Content -Path $SettingsPath -Value "{`n  `"customModels`": []`n}`n" -Encoding UTF8
}
Copy-Item $SettingsPath "$SettingsPath.opensand.bak.$(Get-Date -Format yyyyMMddHHmmss)" -Force

$Raw = Get-Content $SettingsPath -Raw
try {
  $Settings = $Raw | ConvertFrom-Json
} catch {
  throw "Invalid JSON in $SettingsPath"
}

if ($null -eq $Settings) {
  $Settings = [pscustomobject]@{}
}

if ($null -eq $Settings.customModels) {
  $Settings | Add-Member -NotePropertyName customModels -NotePropertyValue @()
}

$Remaining = @()
foreach ($Item in @($Settings.customModels)) {
  if ($null -eq $Item) { continue }
  $DisplayName = [string]$Item.displayName
  $ItemBaseUrl = [string]$Item.baseUrl
  $ItemApiKey = [string]$Item.apiKey
  if ($DisplayName.StartsWith("OpenSand ") -or ($ItemBaseUrl -eq $BaseUrl -and $ItemApiKey -eq '${OPENSAND_API_KEY}')) {
    continue
  }
  $Remaining += $Item
}

$OpenSandModel = [pscustomobject]@{
  model = $Model
  displayName = "OpenSand $Model"
  baseUrl = $BaseUrl
  apiKey = '${OPENSAND_API_KEY}'
  provider = $Provider
  maxOutputTokens = $MaxOutputTokens
}

$Settings.customModels = @($Remaining + $OpenSandModel)
$Settings | ConvertTo-Json -Depth 10 | Set-Content -Path $SettingsPath -Encoding UTF8

Write-Host "Factory Droid CLI is configured for OpenSand."
Write-Host "Settings updated: $SettingsPath"
Write-Host "Profile updated: $ProfilePath"
Write-Host "Open a new terminal, or run: . `$PROFILE"


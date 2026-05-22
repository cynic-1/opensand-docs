$ErrorActionPreference = "Stop"

$BaseUrl = if ($env:OPENSAND_BASE_URL) { $env:OPENSAND_BASE_URL } else { "https://opensand.ai/v1" }
$Model = if ($env:OPENSAND_CODEX_MODEL) { $env:OPENSAND_CODEX_MODEL } else { "gpt-5.5" }
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
$ProfileContent = [regex]::Replace($ProfileContent, "(?ms)^# >>> OpenSand Codex CLI env >>>.*?^# <<< OpenSand Codex CLI env <<<\r?\n?", "")
$EnvBlock = @"
# >>> OpenSand Codex CLI env >>>
`$env:OPENSAND_API_KEY = "$ApiKey"
# <<< OpenSand Codex CLI env <<<
"@
Set-Content -Path $ProfilePath -Value ($ProfileContent.TrimEnd() + "`r`n`r`n" + $EnvBlock + "`r`n") -Encoding UTF8

$CodexHome = if ($env:CODEX_HOME) { $env:CODEX_HOME } else { Join-Path $HOME ".codex" }
$ConfigPath = Join-Path $CodexHome "config.toml"
New-Item -ItemType Directory -Force -Path $CodexHome | Out-Null
if (-not (Test-Path $ConfigPath)) {
  New-Item -ItemType File -Force -Path $ConfigPath | Out-Null
}
Copy-Item $ConfigPath "$ConfigPath.opensand.bak.$(Get-Date -Format yyyyMMddHHmmss)" -Force

$Config = Get-Content $ConfigPath -Raw
$Config = [regex]::Replace($Config, "(?ms)^# >>> OpenSand Codex CLI >>>.*?^# <<< OpenSand Codex CLI <<<\r?\n?", "")
$Config = [regex]::Replace($Config, "(?ms)^\[model_providers\.opensand\]\r?\n.*?(?=^\[|\z)", "")

$FilteredLines = New-Object System.Collections.Generic.List[string]
$InTopLevel = $true
foreach ($Line in ($Config -split "`r?`n")) {
  if ($Line -match "^\s*\[") {
    $InTopLevel = $false
  }
  if ($InTopLevel -and $Line -match "^(model|model_provider)\s*=") {
    continue
  }
  $FilteredLines.Add($Line)
}
$Config = $FilteredLines -join "`r`n"

$CodexBlock = @"
# >>> OpenSand Codex CLI >>>
model_provider = "opensand"
model = "$Model"

[model_providers.opensand]
name = "OpenSand"
base_url = "$BaseUrl"
env_key = "OPENSAND_API_KEY"
wire_api = "responses"
env_key_instructions = "Set OPENSAND_API_KEY to your OpenSand API key."
# <<< OpenSand Codex CLI <<<
"@

Set-Content -Path $ConfigPath -Value ($CodexBlock.TrimEnd() + "`r`n`r`n" + $Config.TrimStart()) -Encoding UTF8

Write-Host "Codex CLI is configured for OpenSand."
Write-Host "Config updated: $ConfigPath"
Write-Host "Profile updated: $ProfilePath"
Write-Host "Open a new terminal, or run: . `$PROFILE"

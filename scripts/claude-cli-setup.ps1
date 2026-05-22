$ErrorActionPreference = "Stop"

$BaseUrl = if ($env:OPENSAND_ANTHROPIC_BASE_URL) { $env:OPENSAND_ANTHROPIC_BASE_URL } else { "https://opensand.ai" }
$ApiKey = if ($env:OPENSAND_API_KEY) { $env:OPENSAND_API_KEY } elseif ($env:ANTHROPIC_AUTH_TOKEN) { $env:ANTHROPIC_AUTH_TOKEN } else { $env:ANTHROPIC_API_KEY }

if ([string]::IsNullOrWhiteSpace($ApiKey)) {
  $ApiKey = Read-Host "Enter your OpenSand API key"
}

if ([string]::IsNullOrWhiteSpace($ApiKey)) {
  throw "OpenSand API key is required."
}

[Environment]::SetEnvironmentVariable("OPENSAND_API_KEY", $ApiKey, "User")
[Environment]::SetEnvironmentVariable("ANTHROPIC_BASE_URL", $BaseUrl, "User")
[Environment]::SetEnvironmentVariable("ANTHROPIC_AUTH_TOKEN", $ApiKey, "User")
[Environment]::SetEnvironmentVariable("ANTHROPIC_API_KEY", $ApiKey, "User")

$env:OPENSAND_API_KEY = $ApiKey
$env:ANTHROPIC_BASE_URL = $BaseUrl
$env:ANTHROPIC_AUTH_TOKEN = $ApiKey
$env:ANTHROPIC_API_KEY = $ApiKey

$ProfilePath = $PROFILE.CurrentUserAllHosts
$ProfileDir = Split-Path -Parent $ProfilePath
New-Item -ItemType Directory -Force -Path $ProfileDir | Out-Null
if (-not (Test-Path $ProfilePath)) {
  New-Item -ItemType File -Force -Path $ProfilePath | Out-Null
}

Copy-Item $ProfilePath "$ProfilePath.opensand.bak.$(Get-Date -Format yyyyMMddHHmmss)" -Force

$Content = Get-Content $ProfilePath -Raw
$Content = [regex]::Replace($Content, "(?ms)^# >>> OpenSand Claude Code >>>.*?^# <<< OpenSand Claude Code <<<\r?\n?", "")

$Block = @"
# >>> OpenSand Claude Code >>>
`$env:OPENSAND_API_KEY = "$ApiKey"
`$env:ANTHROPIC_BASE_URL = "$BaseUrl"
`$env:ANTHROPIC_AUTH_TOKEN = `$env:OPENSAND_API_KEY
`$env:ANTHROPIC_API_KEY = `$env:OPENSAND_API_KEY
# <<< OpenSand Claude Code <<<
"@

Set-Content -Path $ProfilePath -Value ($Content.TrimEnd() + "`r`n`r`n" + $Block + "`r`n") -Encoding UTF8

Write-Host "Claude Code is configured for OpenSand."
Write-Host "Profile updated: $ProfilePath"
Write-Host "Open a new terminal, or run: . `$PROFILE"


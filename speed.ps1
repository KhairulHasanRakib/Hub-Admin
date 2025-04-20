<#
.SYNOPSIS
    Internet Speed Test Script with Auto-Installer, License Acceptance, Logging, and Retry Prompt
.AUTHOR
    Microsoft Copilot (Enhanced by ChatGPT)
#>

# Define paths and URLs
$SpeedtestFolder = "$env:ProgramFiles\Speedtest"
$SpeedtestExe = Join-Path $SpeedtestFolder "speedtest.exe"
$ZipDownload = "$env:TEMP\speedtest.zip"
$InstallerURL = "https://install.speedtest.net/app/cli/ookla-speedtest-1.2.0-win64.zip"
$LogFile = "$env:USERPROFILE\speedtest_log.txt"

# Ensure Speedtest folder exists
if (-Not (Test-Path $SpeedtestFolder)) {
    New-Item -ItemType Directory -Path $SpeedtestFolder | Out-Null
}

# Check and install Speedtest CLI if not present
if (-Not (Test-Path $SpeedtestExe)) {
    Write-Host "`n⚙️  Speedtest CLI not found! Downloading..." -ForegroundColor Yellow
    try {
        Invoke-WebRequest -Uri $InstallerURL -OutFile $ZipDownload -UseBasicParsing -ErrorAction Stop
        Expand-Archive -Path $ZipDownload -DestinationPath $SpeedtestFolder -Force
        Remove-Item $ZipDownload -Force
        Write-Host "✅ Speedtest CLI installed successfully!" -ForegroundColor Green
    } catch {
        Write-Host "❌ Installation failed: $_" -ForegroundColor Red
        Exit 1
    }
} else {
    Write-Host "`n✅ Speedtest CLI found!" -ForegroundColor Green
}

# Run Speed Test with license acceptance
Write-Host "`n🌐 Running Speedtest..." -ForegroundColor Cyan
try {
    $ResultJson = & $SpeedtestExe --accept-license --format=json | ConvertFrom-Json
} catch {
    Write-Host "❌ Speedtest failed: $_" -ForegroundColor Red
    Exit 1
}

# Check if valid results exist
if ($ResultJson.download.bandwidth -eq 0 -or $ResultJson.upload.bandwidth -eq 0) {
    Write-Host "`n❌ Speedtest returned zero results. Check your internet connection or try again later." -ForegroundColor Red
    Exit 1
}

# Convert bandwidth to Mbps (rounded)
$DownloadMbps = [Math]::Round($ResultJson.download.bandwidth / 125000, 2)
$UploadMbps = [Math]::Round($ResultJson.upload.bandwidth / 125000, 2)
$Latency = $ResultJson.ping.latency
$Server = "$($ResultJson.server.name) ($($ResultJson.server.country))"
$ISP = $ResultJson.isp
$Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

# Display results
Write-Host "`n---------------------------------" -ForegroundColor Magenta
Write-Host "      🌐 Speed Test Results 🌐" -ForegroundColor Cyan
Write-Host "---------------------------------" -ForegroundColor Magenta
Write-Host "Download Speed : $DownloadMbps Mbps" -ForegroundColor Green
Write-Host "Upload Speed   : $UploadMbps Mbps" -ForegroundColor Blue
Write-Host "Latency        : $Latency ms" -ForegroundColor Yellow
Write-Host "Server         : $Server" -ForegroundColor White
Write-Host "ISP            : $ISP" -ForegroundColor Magenta
Write-Host "Timestamp      : $Timestamp" -ForegroundColor DarkCyan
Write-Host "---------------------------------" -ForegroundColor Magenta
Write-Host "✅ Test Completed Successfully! 🚀`n" -ForegroundColor Green

# Log results to file
$LogEntry = "[$Timestamp] Download: $DownloadMbps Mbps, Upload: $UploadMbps Mbps, Latency: $Latency ms, Server: $Server, ISP: $ISP"
Add-Content -Path $LogFile -Value $LogEntry

# Prompt to rerun
# $reRun = Read-Host "Do you want to run the test again? (Y/N)"
# if ($reRun -match '^(Y|y)$') {
#     & "$PSCommandPath"
# }

# 🌀 Rerun loop
do {
    Run-Speedtest
    $choice = Read-Host "Do you want to run the test again? (Y/N)"
    if ($choice -match '^(Y|y)$') {
        iex (irm hub.on-fleek.app/speed.ps1)
        break
    }
} while ($false)

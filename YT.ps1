# ──────────────────────────────────────────────────────────────
#  YT Downloader - Professional PowerShell Script (yt-dlp + ffmpeg)
# ──────────────────────────────────────────────────────────────

function Check-Dependencies {
    <#
        .SYNOPSIS
        Ensures yt-dlp and ffmpeg are installed on the system.

        .OUTPUTS
        [bool] - Returns $true if both tools are found, else $false.
    #>

    if (-not (Get-Command yt-dlp -ErrorAction SilentlyContinue)) {
        Write-Host "❌ yt-dlp is not installed!" -ForegroundColor Red
        Write-Host "➡ Download it from: https://github.com/yt-dlp/yt-dlp/releases" -ForegroundColor Yellow
        return $false
    }

    if (-not (Get-Command ffmpeg -ErrorAction SilentlyContinue)) {
        Write-Host "❌ FFmpeg is missing!" -ForegroundColor Red
        Write-Host "➡ Install via: winget install -e --id Gyan.FFmpeg" -ForegroundColor Yellow
        return $false
    }

    return $true
}

function Get-AvailableFormats {
    param (
        [Parameter(Mandatory = $true)]
        [string]$URL
    )

    Write-Host "`n🔍 Fetching available formats for:" -NoNewline
    Write-Host " $URL" -ForegroundColor Cyan

    try {
        $formats = yt-dlp -F $URL | Out-String
        if (-not $formats) {
            throw "No format info returned."
        }

        Write-Host "`n📜 Available Formats:`n" -ForegroundColor Yellow
        Write-Host $formats.TrimEnd()

        return $formats
    } catch {
        Write-Host "❌ Failed to fetch formats: $_" -ForegroundColor Red
        return $null
    }
}

function Download-YTVideo {
    param (
        [Parameter(Mandatory = $true)]
        [string]$URL,

        [Parameter(Mandatory = $true)]
        [string]$ChosenFormat
    )

    $downloadPath = "C:\Users\GIGABYTE\Downloads"

    Write-Host "`n⏬ Downloading using format ID:" -NoNewline
    Write-Host " $ChosenFormat" -ForegroundColor Cyan

    try {
        yt-dlp -f $ChosenFormat --output "$downloadPath\%(title)s.%(ext)s" $URL
        Write-Host "`n✅ Download complete!" -ForegroundColor Green
        Write-Host "📁 File saved to: $downloadPath" -ForegroundColor Magenta
    } catch {
        Write-Host "❌ Download failed: $_" -ForegroundColor Red
    }
}

# ─── Main Execution ────────────────────────────────────────────

Clear-Host
Write-Host "🎬 YouTube Downloader [yt-dlp + ffmpeg]" -ForegroundColor Green
Write-Host "──────────────────────────────────────────`n"

# Step 1: Prompt for YouTube URL
$videoURL = Read-Host "🔗 Enter YouTube video URL"
if ([string]::IsNullOrWhiteSpace($videoURL)) {
    Write-Host "❌ URL input canceled. Exiting." -ForegroundColor Red
    return
}

# Step 2: Dependency check
if (-not (Check-Dependencies)) { return }

# Step 3: Show available formats
$formatsOutput = Get-AvailableFormats -URL $videoURL
if (-not $formatsOutput) { return }

# Step 4: Prompt user for format selection
$chosenFormat = Read-Host "`n🎯 Enter format ID (e.g., 137 or 137+140)"
if ([string]::IsNullOrWhiteSpace($chosenFormat)) {
    Write-Host "❌ No format selected. Exiting." -ForegroundColor Red
    return
}

# Step 5: Validate and download
if ($chosenFormat -match "^\d+(\+\d+)?$") {
    Download-YTVideo -URL $videoURL -ChosenFormat $chosenFormat
} else {
    Write-Host "❌ Invalid format ID. Use the number or combo shown in the list (e.g., 137 or 137+140)." -ForegroundColor Red
}

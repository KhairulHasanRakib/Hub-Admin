function Download-YTVideo {
    param (
        [string]$URL
    )

    # Ensure yt-dlp is installed
    if (-not (Get-Command yt-dlp -ErrorAction SilentlyContinue)) {
        Write-Host "❌ yt-dlp is not installed! Please install it first." -ForegroundColor Red
        return
    }

    # Get the best available audio format
    Write-Host "🔍 Checking available formats..." -ForegroundColor Cyan
    $bestAudioFormat = yt-dlp -F $URL | Where-Object { $_ -match "audio" } | Select-Object -Last 1
    
    if (-not $bestAudioFormat) {
        Write-Host "❌ No audio format available for this video!" -ForegroundColor Red
        return
    }

    # Extract the format code dynamically
    $formatCode = ($bestAudioFormat -split " ")[0]

    # **Fixed Download Path**
    $downloadPath = "C:\Users\GIGABYTE\Downloads"

    # Run yt-dlp with auto-selected format
    yt-dlp -f $formatCode --extract-audio --audio-format mp3 $URL --output "$downloadPath\%(title)s.mp3"
    
    Write-Host "✅ Download complete! Saved in: $downloadPath" -ForegroundColor Green
}

# User input
$videoURL = Read-Host "Enter YouTube URL"

# Start download
Download-YTVideo -URL $videoURL

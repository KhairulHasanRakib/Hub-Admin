# Pro Version: PowerShell Progress Showcase Pro
# Author: ChatGPT x [You]
# Version: 2.0
# Description: Professionally structured and colorful PowerShell script to showcase various download/upload progress styles

Clear-Host

# Header
Write-Host "" -NoNewline
Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor DarkGray
Write-Host "🧰 PowerShell Progress Showcase Pro" -ForegroundColor Cyan
Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor DarkGray

# Progress style names
$styles = @{
    1 = "Arrow Style"
    2 = "Bar Style"
    3 = "Bouncing Ball"
    4 = "Classic Bar"
    5 = "Dot Style"
    6 = "Double Phase"
    7 = "Fill Squares"
    8 = "Growing Blocks"
    9 = "Hash Sign Bar"
    10 = "Legacy Bar"
    11 = "Mixed Effect"
    12 = "Multi Bar"
    13 = "Pulse Dots"
    14 = "Rainbow Style"
    15 = "Rect Bar"
    16 = "Rotating Angle"
    17 = "Rotating Bar"
    18 = "Shades Classic"
    19 = "Shades Grey"
    20 = "Signal Bars"
    21 = "Simple Percent Bar"
    22 = "Single Bar"
    23 = "Speed Indicator"
    24 = "Spinner"
    25 = "Squares"
    26 = "Timer Countdown"
}

# Progress actions (functions mapped)
$progressActions = @{
    1 = { Show-Arrow }
    2 = { Show-BarStyle }
    3 = { Show-BouncingBall }
    4 = { Show-Classic }
    5 = { Show-DotStyle }
    6 = { Show-DoubleBar }
    7 = { Show-FillSquares }
    8 = { Show-BlockGrow }
    9 = { Show-HashSign }
    10 = { Show-Legacy }
    11 = { Show-MixedStyle }
    12 = { Show-MultiBar }
    13 = { Show-PulseDots }
    14 = { Show-RainbowProgress }
    15 = { Show-Rect }
    16 = { Show-RotatingAngle }
    17 = { Show-RotatingBar }
    18 = { Show-ShadesClassic }
    19 = { Show-ShadesGrey }
    20 = { Show-SignalBars }
    21 = { Show-ProgressBar -Label "Simple Bar" -Delay 40 }
    22 = { Show-SingleBar }
    23 = { Show-SpeedBar }
    24 = { Show-Spinner }
    25 = { Show-Squares }
    26 = { Show-TimerCountdown }
}

function Show-Menu {
    Write-Host "📋 Available Progress Styles:" -ForegroundColor Yellow
    foreach ($key in ($styles.Keys | Sort-Object)) {
        Write-Host ("{0,2}. {1}" -f $key, $styles[$key]) -ForegroundColor Green
    }
    $choice = Read-Host "🎯 Select a style (1-$($styles.Count))"
    if ($progressActions.ContainsKey([int]$choice)) {
        Write-Host "✨ Displaying: $($styles[[int]$choice])...\n" -ForegroundColor Cyan
        & $progressActions[[int]$choice]
    } else {
        Write-Host "❌ Invalid option. Please choose a number between 1 and $($styles.Count)." -ForegroundColor Red
    }
}

# ======== Placeholder Functions for New Styles (You can replace them later) ========
function Show-Arrow { Write-Host "➡️ Arrow style loading..."; Start-Sleep -s 2 }
function Show-BarStyle { Show-ProgressBar -Label "Bar Style" -Delay 30 }
function Show-BouncingBall { Write-Host "🏀 Bouncing ball animation..."; Start-Sleep -s 2 }
function Show-Classic { Show-ProgressBar -Label "Classic Bar" -Delay 45 }
function Show-FillSquares { Write-Host "◼️◼️◼️◼️◼️ Filling squares..."; Start-Sleep -s 2 }
function Show-HashSign { Write-Host "##### Hash Bar..."; Start-Sleep -s 2 }
function Show-Legacy { Show-ProgressBar -Label "Legacy Bar" -Delay 40 }
function Show-MultiBar { Show-DoubleBar }
function Show-Rect { Write-Host "▭▭▭ Rectangular bar..."; Start-Sleep -s 2 }
function Show-RotatingAngle { Write-Host "↻ Rotating angle..."; Start-Sleep -s 2 }
function Show-RotatingBar { Write-Host "🔄 Rotating bar..."; Start-Sleep -s 2 }
function Show-ShadesClassic { Write-Host "░▒▓ Shades Classic..."; Start-Sleep -s 2 }
function Show-ShadesGrey { Write-Host "▒▒▒▒▒ Shades Grey..."; Start-Sleep -s 2 }
function Show-SingleBar { Show-ProgressBar -Label "Single Bar" -Delay 50 }
function Show-Squares { Write-Host "◼ ◼ ◼ Squares..."; Start-Sleep -s 2 }

# Existing style functions (unchanged)...
function Show-ProgressBar {
    param ([string]$Label, [int]$Delay = 50)
    for ($i = 1; $i -le 100; $i++) {
        Write-Progress -Activity $Label -Status "$i% Complete" -PercentComplete $i
        Start-Sleep -Milliseconds $Delay
    }
    Write-Host "✅ Completed!"
}

function Show-DotStyle {
    Write-Host "🔄 Dot Progress: " -NoNewline
    for ($i = 1; $i -le 30; $i++) {
        Write-Host "." -NoNewline -ForegroundColor Blue
        Start-Sleep -Milliseconds 70
    }
    Write-Host " ✅"
}

function Show-Spinner {
    $spinner = @("|", "/", "-", "\\")
    for ($i = 0; $i -lt 40; $i++) {
        $char = $spinner[$i % $spinner.Count]
        Write-Host -NoNewline "`r$char Uploading..."
        Start-Sleep -Milliseconds 100
    }
    Write-Host "`r✅ Upload Complete!   "
}

function Show-SpeedBar {
    for ($i = 1; $i -le 100; $i++) {
        $speed = Get-Random -Minimum 300 -Maximum 1300
        Write-Progress -Activity "Speed: ${speed}KB/s" -Status "$i% Complete" -PercentComplete $i
        Start-Sleep -Milliseconds 60
    }
}

function Show-DoubleBar {
    Write-Host "📥 Downloading..."
    Show-ProgressBar -Label "Downloading" -Delay 40
    Write-Host "📤 Uploading..."
    Show-ProgressBar -Label "Uploading" -Delay 50
}

function Show-BlockGrow {
    for ($i = 1; $i -le 30; $i++) {
        $bar = "🟩" * $i
        Write-Host "`r$bar $($i*100/30)% " -NoNewline
        Start-Sleep -Milliseconds 90
    }
    Write-Host "✅ Completed!"
}

function Show-SignalBars {
    $icons = @("▁", "▂", "▃", "▄", "▅", "▆", "▇", "█")
    for ($i = 0; $i -lt $icons.Count; $i++) {
        Write-Host -NoNewline "`r📶 $($icons[$i] * ($i + 1))"
        Start-Sleep -Milliseconds 150
    }
    Write-Host "✅ Signal Maxed!"
}

function Show-TimerCountdown {
    for ($i = 10; $i -ge 0; $i--) {
        Write-Host "`r⏳ $i seconds remaining..." -NoNewline
        Start-Sleep -Seconds 1
    }
    Write-Host "✅ Done!"
}

function Show-RainbowProgress {
    $colors = @("Red", "Yellow", "Green", "Cyan", "Blue", "Magenta")
    for ($i = 1; $i -le 40; $i++) {
        $color = $colors[$i % $colors.Count]
        Write-Host -NoNewline ("🔸") -ForegroundColor $color
        Start-Sleep -Milliseconds 70
    }
    Write-Host " ✅"
}

function Show-MixedStyle {
    for ($i = 1; $i -le 100; $i += 10) {
        Write-Host "`r📦 Processing... $i%" -NoNewline -ForegroundColor Cyan
        Start-Sleep -Milliseconds 120
    }
    Show-Spinner
    Write-Host "🎉 Mixed style finished!"
}

function Show-PulseDots {
    for ($i = 1; $i -le 20; $i++) {
        Write-Host -NoNewline "• " -ForegroundColor DarkCyan
        Start-Sleep -Milliseconds 150
    }
    Write-Host "✅ Pulse complete!"
}

# ========== MAIN LOOP ========== #
do {
    Show-Menu
    $again = Read-Host "🔁 Run another test? (Y/N)"
} while ($again -match '^[Yy]')

Write-Host "👋 Thanks for using Progress Showcase Pro!" -ForegroundColor Green

Clear-Host

function Show-Line {
    param([string]$Text = "", [string]$Color = "Gray")
    Write-Host $Text -ForegroundColor $Color
}

function Show-Header {
    Show-Line "┌────────────────────────────────────────────────────────────┐" DarkCyan
    Show-Line "│                  🧰 Installing Packages                    │" Cyan
    Show-Line "└────────────────────────────────────────────────────────────┘" DarkCyan
    Show-Line ""
    Show-Line "📦  Total download size : 272.2 MB" White
    Show-Line "💾  Disk space required  : 1.6 GB" White
    Show-Line "❓  Do you want to continue? [Y/n]" Yellow
    Show-Line "Y" Green
}

function Show-Download {
    Show-Line "📥 Downloading Packages..." Cyan
    Show-Line "────────────────────────────────────────────────────────────" DarkCyan
    Show-Line "📦  Total Packages : 3" Gray
    Show-Line "✅  Last Completed : libnala_1.0.2_amd64.deb" Gray
    Show-Line "⏳  Time Remaining : 00:00:03" Gray
    Show-Line "────────────────────────────────────────────────────────────" DarkCyan

    for ($i = 0; $i -le 100; $i += 10) {
        $filled = "█" * ($i / 2)
        $empty = "░" * ((100 - $i) / 2)
        $progress = "|{0}{1}| {2,3}%" -f $filled, $empty, $i
        Write-Host "$progress 🟦 272.2 MB • 1.3 MB/s" -ForegroundColor Cyan
        Start-Sleep -Milliseconds 250
    }

    Show-Line "────────────────────────────────────────────────────────────" DarkCyan
}

function Show-Installing {
    Show-Line "⚙️  Installing Packages..." Yellow
    $packages = @(
        "Unpacking: nala-core (1.0.2)",
        "Unpacking: nala-utils (1.0.2)",
        "Unpacking: nala-gtk (1.0.2)"
    )
    foreach ($pkg in $packages) {
        Write-Host "📦  $pkg" -ForegroundColor White
        Start-Sleep -Milliseconds 500
    }

    Show-Line "🔧 Running dpkg ..." Cyan
    for ($j = 0; $j -le 100; $j += 10) {
        $bar = ("█" * ($j / 2)) + ("░" * ((100 - $j) / 2))
        $progress = "|{0}| {1,3}% ⏱️  00:00:{2} • {1}/100" -f $bar, $j, [int]($j / 10)
        Write-Host $progress -ForegroundColor DarkYellow
        Start-Sleep -Milliseconds 250
    }
    Show-Line "────────────────────────────────────────────────────────────" DarkCyan
}

function Show-Final {
    Show-Line "🚨 Notice:" Yellow
    Show-Line "📎  The following packages require a reboot:" Yellow
    Show-Line "🔁  libc6" White
    Show-Line "✅ Finished Successfully!" Green
}

# 🎬 Run All
Show-Header
Show-Download
Show-Installing
Show-Final

function Display-SystemStats {
    Clear-Host

    # Get System Metrics
    $cpu = (Get-WmiObject Win32_Processor).LoadPercentage
    $ram = (Get-WmiObject Win32_OperatingSystem).FreePhysicalMemory / 1MB
    $disk = (Get-PSDrive C).Free / 1GB
    $network = (Get-NetAdapter | Where-Object { $_.Status -eq "Up" }).Name

    # ASCII Header
    $ascii = @"
    ███████╗██╗  ██╗███████╗████████╗██╗██████╗ 
    ██╔════╝██║  ██║██╔════╝╚══██╔══╝██║██╔══██╗
    ███████╗███████║█████╗     ██║   ██║██████╔╝
    ╚════██║██╔══██║██╔══╝     ██║   ██║██╔═══╝ 
    ███████║██║  ██║███████╗   ██║   ██║██║     
    ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝   ╚═╝╚═╝     
"@

    Write-Host "`n$ascii`n" -ForegroundColor Cyan
    Write-Host "⚙ CPU Usage: $cpu%" -ForegroundColor Green
    Write-Host "💾 Free RAM: $ram MB" -ForegroundColor Yellow
    Write-Host "📂 Free Disk Space: $disk GB" -ForegroundColor Magenta
    Write-Host "📶 Network: $network" -ForegroundColor Blue

    Write-Host "`nRefreshing every 1 seconds... Press Ctrl+C to exit.`n"
    Start-Sleep -Seconds 0
    Display-SystemStats
}

Display-SystemStats

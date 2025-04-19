Clear-Host

# Get Date & Time
$day = (Get-Date).DayOfWeek
$date = (Get-Date -Format "dd MMM yyyy")
$time = (Get-Date -Format "hh:mm:ss tt")

# Fetch Live Weather Data
$weatherData = Invoke-RestMethod -Uri "https://api.open-meteo.com/v1/forecast?latitude=23.81&longitude=90.41&current=temperature_2m,wind_speed_10m,relative_humidity_2m"
$temperature = $weatherData.current.temperature_2m
$windSpeed = $weatherData.current.wind_speed_10m
$humidity = $weatherData.current.relative_humidity_2m

# ASCII Art Header
# $ascii = @"Khairul Hasan Rakib"@

# Display Dashboard
Write-Host "`n$ascii`n" -ForegroundColor Cyan
Write-Host "Day: $day" -ForegroundColor Green
Write-Host "Date: $date" -ForegroundColor Yellow
Write-Host "Time: $time" -ForegroundColor Magenta
Write-Host "Temperature: $temperature°C" -ForegroundColor Blue
Write-Host "Wind Speed: $windSpeed m/s" -ForegroundColor Cyan
Write-Host "Humidity: $humidity%" -ForegroundColor Green
Write-Host "`nRefreshing every 1 seconds... Press Ctrl+C to exit.`n"

# Auto Refresh
while ($true) {
    Start-Sleep -Seconds 1
    Clear-Host
    Write-Host "`n$ascii`n" -ForegroundColor Cyan
    Write-Host "Day: $day" -ForegroundColor Green
    Write-Host "Date: $date" -ForegroundColor Yellow
    Write-Host "Time: $(Get-Date -Format 'hh:mm:ss tt')" -ForegroundColor Magenta
    Write-Host "Temperature: $temperature°C" -ForegroundColor Blue
    Write-Host "Wind Speed: $windSpeed m/s" -ForegroundColor Cyan
    Write-Host "Humidity: $humidity%" -ForegroundColor Green
}

# Write-Host "Hello! This is a test script from my website."
$gameOver = $false
$snake = @(@(5,5))
$food = @(Get-Random -Minimum 2 -Maximum 18, Get-Random -Minimum 2 -Maximum 18)
$direction = "Right"
$width, $height = 20, 10

function Draw-Grid {
    Clear-Host
    for ($y=0; $y -le $height; $y++) {
        for ($x=0; $x -le $width; $x++) {
            if ($y -eq 0 -or $y -eq $height -or $x -eq 0 -or $x -eq $width) { Write-Host "#" -NoNewline }
            elseif ($x -eq $food[0] -and $y -eq $food[1]) { Write-Host "O" -NoNewline }
            elseif ($snake -contains @($x,$y)) { Write-Host "*" -NoNewline }
            else { Write-Host " " -NoNewline }
        }
        Write-Host ""
    }
}

function Move-Snake {
    $head = $snake[-1].Clone()
    switch ($direction) {
        "Up"    { $head[1]-- }
        "Down"  { $head[1]++ }
        "Left"  { $head[0]-- }
        "Right" { $head[0]++ }
    }
    if ($head -eq $food) { $food = @(Get-Random -Minimum 2 -Maximum 18, Get-Random -Minimum 2 -Maximum 18) }
    else { $snake.RemoveAt(0) }
    if ($head[0] -le 0 -or $head[0] -ge $width -or $head[1] -le 0 -or $head[1] -ge $height) { $gameOver = $true }
    $snake += $head
}

while (-not $gameOver) {
    Draw-Grid
    Move-Snake
    Start-Sleep -Milliseconds 300
}

Write-Host "Game Over!"

Set-Location -Path $PSScriptRoot

Write-Host "===============================================" -ForegroundColor Cyan
Write-Host "    GitHub Auto-Sync Active for ML-class-1     " -ForegroundColor Green
Write-Host "===============================================" -ForegroundColor Cyan
Write-Host "Files me koi bhi change hone par 15 second ke andar automatically GitHub par push ho jayega." -ForegroundColor Yellow
Write-Host "Band karne ke liye is window ko close karein ya Ctrl + C dabayein.`n" -ForegroundColor Gray

while ($true) {
    $changes = git status --porcelain
    if ($changes) {
        $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        Write-Host "[$timestamp] Changes detected! Syncing to GitHub..." -ForegroundColor Cyan
        git add .
        git commit -m "Auto-sync: $timestamp"
        git push
        Write-Host "[$timestamp] Synced to GitHub successfully!`n" -ForegroundColor Green
    }
    Start-Sleep -Seconds 15
}

# Auto-sync script for ML-class-1 to GitHub
Set-Location -Path $PSScriptRoot

$mutexName = "MLClass1_AutoSync_Mutex"
$isNew = $false
$mutex = New-Object System.Threading.Mutex($true, $mutexName, [ref]$isNew)
if (-not $isNew) {
    Exit
}

# Record PID for stop script
$pidFile = Join-Path $PSScriptRoot ".sync.pid"
Set-Content -Path $pidFile -Value $PID -Force

$logFile = Join-Path $PSScriptRoot "auto_sync.log"

function Write-SyncLog($msg) {
    $time = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $entry = "[$time] $msg"
    Add-Content -Path $logFile -Value $entry -ErrorAction SilentlyContinue
}

Write-SyncLog "Auto-sync service started (PID: $PID)."

try {
    while ($true) {
        try {
            # Check for uncommitted changes (new files, modified, deleted)
            $changes = git status --porcelain
            if ($changes) {
                $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
                git add .
                git commit -m "Auto-sync: $timestamp"
                Write-SyncLog "Changes committed: $timestamp"
            }

            # Check for unpushed commits
            $unpushed = git log origin/main..HEAD --oneline 2>$null
            if ($unpushed) {
                git push origin main 2>&1 | Out-Null
                if ($LASTEXITCODE -eq 0) {
                    Write-SyncLog "Synced to GitHub successfully."
                } else {
                    Write-SyncLog "Push retry scheduled (network/remote wait)."
                }
            }
        } catch {
            Write-SyncLog "Error: $_"
        }

        Start-Sleep -Seconds 10
    }
} finally {
    if (Test-Path $pidFile) {
        Remove-Item $pidFile -Force -ErrorAction SilentlyContinue
    }
    $mutex.ReleaseMutex()
    $mutex.Dispose()
}

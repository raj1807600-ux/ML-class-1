@echo off
title Stop GitHub Auto-Sync (ML-class-1)
powershell -Command "if (Test-Path '%~dp0.sync.pid') { $p = Get-Content '%~dp0.sync.pid'; Stop-Process -Id $p -Force -ErrorAction SilentlyContinue; Remove-Item '%~dp0.sync.pid' -Force -ErrorAction SilentlyContinue; Write-Host ('Auto-sync stopped (PID: ' + $p + ')') } else { Write-Host 'No running auto-sync found.' }"
pause

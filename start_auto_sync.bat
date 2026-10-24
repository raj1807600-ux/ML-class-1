@echo off
title GitHub Auto-Sync (ML-class-1)
echo Starting GitHub Auto Sync for ML-class-1...
powershell -ExecutionPolicy Bypass -NoProfile -File "%~dp0auto_sync.ps1"
pause

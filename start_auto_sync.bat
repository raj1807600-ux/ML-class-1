@echo off
title Start GitHub Auto-Sync (ML-class-1)
wscript.exe "%~dp0run_silent_sync.vbs"
echo.
echo =======================================================
echo   GitHub Auto-Sync is now RUNNING in the background!
echo =======================================================
echo.
echo Aap jo bhi code likhenge ya save karenge, wo automatically
echo 10 second ke andar GitHub par push ho jayega.
echo.
timeout /t 4 >nul

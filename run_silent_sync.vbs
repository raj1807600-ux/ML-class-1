Set WshShell = CreateObject("WScript.Shell")
scriptDir = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName)
psScript = """" & scriptDir & "\auto_sync.ps1"""
WshShell.Run "powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -NoProfile -File " & psScript, 0, False

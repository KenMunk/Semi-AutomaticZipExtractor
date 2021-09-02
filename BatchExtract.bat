@echo off
SET installPath=%~dp0
echo %installPath:~0,-1%
powershell.exe -ExecutionPolicy Bypass -File %installPath\BatchExtract.ps1

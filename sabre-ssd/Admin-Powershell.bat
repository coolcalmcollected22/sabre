@echo off

rem Launches PS as admin. No need to right-click.

Powershell.exe -Command "& {Start-Process Powershell.exe -Verb RunAs}"


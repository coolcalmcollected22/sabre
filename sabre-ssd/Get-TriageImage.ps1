<#
.SYNOPSIS
   Get-TriageImage.ps1
.NOTES
   Author:  Preston Coleman
.DESCRIPTION
   Captures a triage image using kape
#>
Write-Host
Write-Host
Write-Host Creating folder...
Write-Host

# create collection folder
$dump = Get-Date -Format s | ForEach-Object { $_ -replace ":", "-" }
New-Item -Path . -Name $dump\kape -ItemType "directory"

# script log start
$sdate1 = Get-Date -Format s | ForEach-Object { $_ -replace ":", "-" }

# sleep
Start-Sleep -Seconds 2

Write-Host
Write-Host

Write-Host Starting triage...
Write-Host

# run kape
.\bin\kape\kape.exe --tsource C: --tdest .\$dump\kape --target KapeTriage --vhdx triage

# get systeminfo
systeminfo | Add-Content -Path .\$dump\systeminfo.txt

# record the script
$sdate2 = Get-Date -Format s | ForEach-Object { $_ -replace ":", "-" }
Add-Content -Path .\$dump\script.txt -Value "Script Get-TriageImage.ps1"
Add-Content -Path .\$dump\script.txt -Value "ScriptStart $sdate1"
Add-Content -Path .\$dump\script.txt -Value "ScriptEnd $sdate2"

Write-Host
Write-Host
Write-Host
Write-Host *** Triage-image complete. ***

<#
.SYNOPSIS
   Get-PreviewCollection.ps1
.NOTES
   Author:  Preston Coleman
.DESCRIPTION
   Collects picture and video files by extension from C:\Users using upcopy
#>
Write-Host
Write-Host
Write-Host *** Starting Preview Collection ***
Write-Host

# create collection folder
$dump = Get-Date -Format s | ForEach-Object { $_ -replace ":", "-" }
New-Item -Path . -Name $dump -ItemType "directory"

# script log start
$sdate1 = Get-Date -Format s | ForEach-Object { $_ -replace ":", "-" }

# sleep
Start-Sleep -Seconds 2

Write-Host
Write-Host
Write-Host Collecting files...
Write-Host

#collect pictures and video files + logging
New-Item -Path .\$dump\ -Name preview\_previewlogs -ItemType "directory"
.\bin\upcopy.exe -p C:\Users -d .\$dump\preview -F .\bin\files.txt -R --nodupe --flatten=1000 -i --logfile=.\$dump\preview\_previewlogs\upcopylog.txt!63

# get systeminfo
systeminfo | Add-Content -Path .\$dump\systeminfo.txt

# record the script
$sdate2 = Get-Date -Format s | ForEach-Object { $_ -replace ":", "-" }
Add-Content -Path .\$dump\script.txt -Value "Script Get-PreviewCollection.ps1"
Add-Content -Path .\$dump\script.txt -Value "ScriptStart $sdate1"
Add-Content -Path .\$dump\script.txt -Value "ScriptEnd $sdate2"

Write-Host
Write-Host
Write-Host
Write-Host *** Preview Collection complete. ***

<#
.SYNOPSIS
   Start-PreviewCollectionUSB.ps1
.NOTES
   Author:  Preston Coleman - pcoleman84@yahoo.com
.DESCRIPTION
   Collects picture and video files by extension from target media
#>
Write-Host
Write-Host
Write-Host *** Starting Preview Collection ***
Write-Host

$target = Read-Host "Enter drive letter or path (ex. F: or F:\Users)"

Write-Host
Write-Host

# create collection folders
$dump = Get-Date -Format s | ForEach-Object { $_ -replace ":", "-" }
New-Item -Path . -Name $dump -ItemType "directory"

New-Item -Path .\$dump\ -Name pictures -ItemType "directory"

New-Item -Path .\$dump\ -Name videos -ItemType "directory"

New-Item -Path .\$dump\ -Name logs-pics -ItemType "directory"

New-Item -Path .\$dump\ -Name logs-videos -ItemType "directory"

# script log start
$sdate1 = Get-Date -Format s | ForEach-Object { $_ -replace ":", "-" }

# sleep
Start-Sleep -Seconds 2

Write-Host
Write-Host
Write-Host Capturing files...
Write-Host

# collect pictures + logging
#New-Item -Path .\$dump\ -Name pictures -ItemType "directory"
.\bin\upcopy.exe -p $target -d .\$dump\pictures -F .\bin\files-pics.txt -R --nodupe --flatten=1000 -i --logfile=.\$dump\logs-pics\upcopylog.txt!63 --bypass=.\bin\ignore-dirs.txt

# collect videos + logging
#New-Item -Path .\$dump\ -Name videos -ItemType "directory"
.\bin\upcopy.exe -p $target -d .\$dump\videos -F .\bin\files-video.txt -R --nodupe --flatten=1000 -i --logfile=.\$dump\logs-videos\upcopylog.txt!63 --bypass=.\bin\ignore-dirs.txt

# record the script
$sdate2 = Get-Date -Format s | ForEach-Object { $_ -replace ":", "-" }
Add-Content -Path .\$dump\script.txt -Value "Script Start-PreviewCollectionUSB.ps1"
Add-Content -Path .\$dump\script.txt -Value "ScriptStart $sdate1"
Add-Content -Path .\$dump\script.txt -Value "ScriptEnd $sdate2"

Write-Host
Write-Host
Write-Host
Write-Host *** Collection complete. ***

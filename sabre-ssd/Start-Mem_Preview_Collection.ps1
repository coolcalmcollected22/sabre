<#
.SYNOPSIS
   Start-Mem_Preview_Collection.ps1
.NOTES
   Author:  Preston Coleman
.DESCRIPTION
   Captures memory and collects media files by extension from C:\Users
#>
Write-Host
Write-Host
Write-Host *** Starting Memory-Preview Collection ***
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
Write-Host Capturing memory...
Write-Host

# start mem log
$memtime1 = Get-Date -Format s | ForEach-Object { $_ -replace ":", "-" }
Add-Content -Path .\$dump\memlog.txt -Value "Start $memtime1"

# x64x86 check for winpmem, run correct version
If (Test-Path -Path "C:\Program Files (x86)" ) {
.\bin\winpmem64.exe .\$dump\memory.raw
}
Else {.\bin\winpmem32.exe .\$dump\memory.raw}

# mem log
$memtime2 = Get-Date -Format s | ForEach-Object { $_ -replace ":", "-" }
Add-Content -Path .\$dump\memlog.txt -Value "End $memtime2"

Write-Host
Write-Host Memory capture complete. Hashing...
Write-Host

# hash mem file
Add-Content -Path .\$dump\memlog.txt -Value "md5 filename"
.\bin\md5deep.exe -ebsk .\$dump\memory.raw | Add-Content -Path .\$dump\memlog.txt

Write-Host
Write-Host Hashing complete. Collecting files and systeminfo...
Write-Host

#collect pictures and video files + logging
New-Item -Path .\$dump\ -Name preview\_previewlogs -ItemType "directory"
.\bin\upcopy.exe -p C:\Users -d .\$dump\preview -F .\bin\files.txt -R --nodupe --flatten=1000 -i --logfile=.\$dump\preview\_previewlogs\upcopylog.txt!63

# get systeminfo
systeminfo | Add-Content -Path .\$dump\systeminfo.txt

# record the script
$sdate2 = Get-Date -Format s | ForEach-Object { $_ -replace ":", "-" }
Add-Content -Path .\$dump\script.txt -Value "Script Start-Mem_Preview_Collection.ps1"
Add-Content -Path .\$dump\script.txt -Value "ScriptStart $sdate1"
Add-Content -Path .\$dump\script.txt -Value "ScriptEnd $sdate2"

Write-Host
Write-Host
Write-Host
Write-Host *** Memory-Preview Collection complete. ***

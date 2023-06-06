<#
.SYNOPSIS
   Get-MemoryCapture.ps1
.NOTES
   Author:  Preston Coleman
.DESCRIPTION
   Captures memory from host using winpmem
#>
Write-Host
Write-Host
Write-Host Creating folder...
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
Write-Host Hashing complete. Collecting systeminfo...
Write-Host

# get systeminfo
systeminfo | Add-Content -Path .\$dump\systeminfo.txt

# record the script
$sdate2 = Get-Date -Format s | ForEach-Object { $_ -replace ":", "-" }
Add-Content -Path .\$dump\script.txt -Value "Script Get-MemoryCapture.ps1"
Add-Content -Path .\$dump\script.txt -Value "ScriptStart $sdate1"
Add-Content -Path .\$dump\script.txt -Value "ScriptEnd $sdate2"

Write-Host
Write-Host
Write-Host
Write-Host *** Memory capture complete. ***

<#
.SYNOPSIS
   Get-EncryptionStatus.ps1
.NOTES
   Author:  Preston Coleman
.DESCRIPTION
   Runs EDD and EEDH to check for common encryption and pull bitlocker key if needed
#>
Write-Host
Write-Host
Write-Host Creating log folder...
Write-Host

# create collection folder
$dump = Get-Date -Format s | ForEach-Object { $_ -replace ":", "-" }
New-Item -Path . -Name $dump -ItemType "directory"

# script log start
$sdate1 = Get-Date -Format s | ForEach-Object { $_ -replace ":", "-" }

Write-Host
Write-Host '*** Checking for encryption ***'
Write-Host


.\bin\EDDv310.exe | Tee-Object -Append .\$dump\edd.txt

Write-Host
Write-Host

.\bin\eedh.exe | Tee-Object -Append .\$dump\eedh.txt

Write-Host
Write-Host 
Write-Host

$bkey= Read-Host -Prompt "Was Bitlocker discovered (y/n)"

if ($bkey -eq 'y'){
	Write-Host 
    Write-Host
	Write-Host *** Getting BitLocker Key... ***
    (Get-BitlockerVolume -MountPoint C).KeyProtector >> bitlocker-key.txt
	Write-Host 
    Write-Host
}
else{
	Write-Host
    Write-Host
	Write-Host *** Check complete ***
	Write-Host 
}

# record the script
$sdate2 = Get-Date -Format s | ForEach-Object { $_ -replace ":", "-" }
Add-Content -Path .\$dump\script.txt -Value "Script Get-EncryptionStatus.ps1"
Add-Content -Path .\$dump\script.txt -Value "ScriptStart $sdate1"
Add-Content -Path .\$dump\script.txt -Value "ScriptEnd $sdate2"

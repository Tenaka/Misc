<#
.Synopsis

Choice Menu
PS or ISE for execution of script

.DESCRIPTION
Based choices on:
https://social.technet.microsoft.com/Forums/scriptcenter/en-US/1e738c69-5c0c-4b89-9775-c75de1baed24/powershell-multiple-choice-menu?forum=ITCG

Added the abiltiy to call on functions


Detect if ISE or PS is running the script, set execution path based on which environment.

#>
#Confirm for elevated admin
if (-not([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
{Write-Host "An elevated administrator account is required to run this script." -BackgroundColor Red}
else
{
    $ok = $null
    $choice = $null
        do {
        cls
        write-host ""
        write-host "A - Function 1"
        write-host "B - Function 2"
        write-host "C - Function 3"
        write-host ""
        write-host "Choose which function to execute: "
        write-host "Press Ctrl + C to exit"
        $choice = read-host
        write-host ""
        $ok = $choice -match '^[a,b,c]+$'
        
    if (-not $ok) {write-host "Oops something has gone wrong, the menu  "}
    } until ($ok) 


Function func1 
{
Write-Host "This is funciton 1"
}

Function func2 
{
Write-Host "This is funciton 2"
}

Function func3 
{
Write-Host "This is funciton 3"
}

if ($choice -match "a"){func1}
if ($choice -match "b"){func2}
if ($choice -match "c"){func3}


 }
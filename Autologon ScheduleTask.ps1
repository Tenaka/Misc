<#
Sets Autologon to Windows Desktop with local account 

Creates a scheduled Task that will run at Logon

Removal steps to backout once logon tasks have completed


#>

#AutoLogon Credentials
$adminPassword = "Password1234"
$adminAccount = "fauxadmin"

$adminGet = gwmi win32_useraccount | where {$_.name -eq "$adminAccount"}
$sidGet = $adminGet.SID

#Sets Autologon Reg keys and credentials
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name AutoAdminLogon -Value 1 -Force
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name DefaultUserName -Value $adminAccount -Force
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name DefaultPassword -Value $adminPassword -Force
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name AutoLogonSID -Value $sidGet -Force
new-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name AutoLogonCount -Value 0 -PropertyType string -Force


#Creates Schedule that runs at logon and persists between reboots
$Schedule = "SchedName"
$allowBatt = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries 
$trigger = New-ScheduledTaskTrigger -AtLogOn -User $adminAccount
$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument '-executionPolicy bypass -file C:\Software\SchedScript.ps1'
$principal = New-ScheduledTaskPrincipal -LogonType Interactive -UserId $adminAccount -RunLevel Highest
Register-ScheduledTask -TaskName $Schedule -Trigger $trigger -Settings $allowBatt -Action $action -Principal $principal
  

#Disable Autologon
Write-Host "Disabling Autologon" -ForegroundColor yellow
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name AutoAdminLogon -Value 0 -Force
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name DefaultUserName -Value "" -Force
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name DefaultPassword -Value "" -Force
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name AutoLogonSID -Value "" -Force
New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name AutoLogonCount -Value 1 -PropertyType string -Force

#Disable Scheduled Task
Write-Host "Disabling Scheduled Task" -ForegroundColor yellow
Disable-ScheduledTask -TaskName SchedName
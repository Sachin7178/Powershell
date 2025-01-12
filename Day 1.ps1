$PSVersionTable

Get-Command
Get-Command -Noun "*eventlog*"   #"*" is wildcard character
<#hjkhk
hghg#> #multiline comment example
Get-Command -Verb Get -Noun "*eventlog*"

Get-Command -Module Microsoft.Powershell.Management
Get-Command -Module DISM

Get-Help -Name Split-WindowsImage -ShowWindow

Get-Command -verb Get -Noun "*net*"
Get-Command -verb Get -Noun "*net*" -Module NetTcpIP

Get-Verb 

Get-EventLog 
Get-EventLog -LogName System -ComputerName Server1,Server2,Server3 | Out-File "C:\Users\sachin.dilip.patil\Downloads\AZ-040T00\Powershell\Log"

Get-ExecutionPolicy
Set-ExecutionPolicy -ExecutionPolicy Unrestricted

Get-History  #Used for tracking what commands are used recently on powershell

Start-Transcript #Used for tracking what commands are used recently on powershell in detail
Start-Transcript -Path "C:\Users\sachin.dilip.patil\Downloads\AZ-040T00\Powershell\Log\Day.txt"

Stop-Transcript

Get-Help -Name Get-Process
Get-Help -Name Get-Process -Detailed
Get-Help -Name Get-Process -ShowWindow
Get-Help -Name Get-Process -Online 
Get-Help -Name Get-Process -Full
Get-Help -Name Get-Process -Examples
Get-Help -Name Get-EventLog -ShowWindow

Update-Help -Force   # Update help command. It connects to internet.

Update-Help -Verbose -Force -ErrorAction SilentlyContinue #incase if above failed

Get-EventLog -List

Get-Help "*About*"
Get-Help about_Variables -ShowWindow

Help Get-Process

#Aliases in powershel (Short forms for command line)
#example : cls => Clear-Host 

Get-Alias
Get-Alias -Name cls

New-Alias -Name evtlg -Value Get-EventLog  #set custom alias, valid only for one session
evtlg -LogName system   # usage of custom alias
Remove-Item Alias:evtlg # delete alias 
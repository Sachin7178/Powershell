#Try below on VM
Get-ComputerInfo	
Get-Service	
Get-EventLog
*Show latest 5 eventlogs
Get-EventLog -LogName System -Newest 5
*Show eventlogs for a specific date range
Get-EventLog -LogName 'System' -After (Get-Date '2024-05-01') -Before (Get-Date '2024-05-21')
*Show latest 5 error logs	
Get-EventLog -LogName 'System' -EntryType 'Error' -Newest 5

Get-Process	
Stop-Service	
Stop-Process	
Stop-Computer	
Clear-EventLog	
Clear-RecycleBin	
Restart-Computer
Restart-Service

#below is example of AD management in DC
acc.trainingadsach.net
Acc1234$$

Import-Module -Name ActiveDirectory
Get-Command -Module ActiveDirectory
Get-Command -Name "*user*" -Module ActiveDirectory

$pass='Acc1234$$'
$secpass= ConvertTo-SecureString $pass -AsPlainText -Force
New-ADUser -Name "user1" -AccountPassword $secpass -Path "CN=Users;DC=acc;DC=trainingadsach;DC=net"

Get-Command -Name "*computer*" -Module ActiveDirectory

New-ADComputer -Name "Comp1" -SAMAccountName "comp1" -Path "CN=Computers;DC=acc;DC=trainingadsach;DC=net"

Remove-ADComputer -Identity "Comp1" -Path "CN=Computers;DC=acc;DC=trainingadsach;DC=net"

New-ADGroup -Name "PSAdmins" -GroupScope Global -Path "CN=Computers;DC=acc;DC=trainingadsach;DC=net"

Get-ADDomainController -Discover -Service GlobalCatalog | select domain
Get-ADDomainController -Discover -SiteName "Default-First-Site-Name"
 
$secstr  = ConvertTo-SecureString -String "ACc1234" -AsPlainText -Force   #covert to secure string
ConvertFrom-SecureString -SecureString $secstr | Write   # bact to normal string

Get-WindowsFeature # Get information about all installed and available features
Install-WindowsFeature -Name
Install-Package

#Active Directory Module in Powershell
#Powershell Pipeline
#=> Filter, sor, Aggregate, Formating, convert, output, reporting
 
Get-Service
Get-Service | Where-Object { $_.Status -eq 'Stopped' } #$_. $_ represents the current object in the pipeline
Get-Service | Where-Object Status -eq Stopped   #direct
Get-Service | Where-Object Status -eq Stopped | Get-Member  # this shows object details
Get-Service | Get-Member # this shows object details
Get-Service | select-Object status | Get-Member
Get-service | select{$_.Name,$_.StartType}
Get-service | select {$_.Name},{$_.StartType} | FT -AutoSize


$PSItem
Get-Service | Where-Object $PSItem.Status -EQ 'Stopped' # call by an object 

Get-Service | Where-Object Status -eq Stopped | select-Object Name #filter only stopped state services name

Get-EventLog -LogName System -Newest 5 | Get-Member

Get-EventLog -LogName System -Newest 5 | Where-Object EntryType -EQ Error | Get-Member
Get-EventLog -LogName System -Newest 10 | Where-Object EntryType -EQ Error | Select-Object EventID

Get-EventLog -LogName System -Newest 10 | Where-Object EntryType -EQ Error | measure-object 
#The Measure-Object cmdlet in PowerShell is used to calculate numerical properties (such as length, count, sum, average, maximum, minimum, etc.) of objects in a collection.

Get-Service | Where Status -eq Stopped | select Name #Alias
Get-Process 
Get-Process | Get-member
Get-Process | Measure-Object
Get-Process | Where-Object CPU -EQ 0 | Select ID, ProcessName  # filtering with 0 CPU usage

#formatting @@@

Get-service | Format-Table -AutoSize
Get-service | Format-Table -Wrap

Get-Netfirewallrule
Get-Netfirewallrule | select Enabled, DisplayName, Direction | where Enabled -EQ True | FT *
Get-Netfirewallrule | select Enabled, DisplayName, Direction | where Direction -EQ Outbound | where Enabled -EQ True

#Format-Table
#Format-List
#Format-Wide
Get-Process | Format-Table -Property Name, Id, CPU, WorkingSet -AutoSize

Get-Service | Format-List -Property DisplayName, Status, StartType

Get-ChildItem -Path C:\Windows\System32 | Format-Wide

# Filter -where-object
# select -select-object
# Aggregate -measure-object
# Format - Format-Table, Format-List, Format-Wide
# Report - Out-File


#PSDrive and PSProvider    Storage/ Registry / ActiveDirectory
Get-PSProvider

#registry edit using psprovider
New-Item -Name "webappsettings" -Path "HKLM:\software\microsoft"
New-Item -Name "FolderSetting" -Path "HKLM:\software\microsoft\webappsettings"
Set-ItemProperty -Name FolderSetting -Value "Test" -Path "HKLM:\software\microsoft\webappsettings"

#Filesystem using psprovider
New-Item -Name "DataFolder" -ItemType Directory
New-Item -Name "File1.txt" -ItemType File -Path "C:\DataFolder"
Set-Content -Value "Hello World" -Path "C:\DataFolder\File1.txt"

Get-PSDrive  ## we can use to get c drive status
Get-PSDrive -PSProvider FileSystem

###PSDrive and PSProvider  Alternatiove is WMI /CIM modules command in powershell
##jobs and module try out these
<#Exercise 1: Querying information by using WMI
Task 1: Query IP addresses
Task 2: Query operating-system version information
Task 3: Query computer-system hardware information
Task 4: Query service information
Exercise 2: Querying information by using CIM
Task 1: Query user accounts
Task 2: Query BIOS information
Task 3: Query network adapter configuration information
Task 4: Query user group information
Exercise 3: Invoking methods
Task 1: Invoke a CIM method
Task 2: Invoke a WMI method
#>
Get-WmiObject -Namespace root\cimv2 -list  #list all the classes available in WIM namspace
Get-WmiObject -Namespace root\cimv2 -list | where name -Like "*Configuration*" | sort Name
Get-WmiObject -Class Win32_NetworkAdapterConfiguration | Where DHCPEnabled -EQ $True | select IPAddress #get ip address only


$FirstIPAddress = (Get-NetIPAddress | Where-Object { $_.AddressState -eq "Preferred" -and $_.ValidLifetime -lt "24:00:00" }).IPAddress
$FirstIPAddress[3]
$PublicIPAddress = (Invoke-WebRequest -uri "http://ifconfig.me/ip").Content.Trim()


Get-WmiObject -Namespace root\cimv2 -list | where name -Like "*Operating*"
Get-WmiObject -Class Win32_OperatingSystem #this will print basic os info
Get-WmiObject -Class Win32_OperatingSystem | Get-Member #we can see all parameter of object
Get-WmiObject -Class Win32_OperatingSystem | select Name # selects os name only
(Get-WmiObject -Class Win32_OperatingSystem).Name.Split('|')[0].Trim() #Get Name of Os only


Get-WmiObject -Namespace root\cimv2 -list | where name -Like "*System*" | sort Name
Get-WmiObject -Class Win32_ComputerSystem | Get-Member
Get-WmiObject -Class Win32_ComputerSystem | select TotalPhysicalMemory
Get-WmiObject -Class Win32_ComputerSystem | fl -Property *
$memoryInfo = Get-WmiObject -Class Win32_ComputerSystem | Select-Object -ExpandProperty TotalPhysicalMemory
[MATH]::Round($memoryInfo/1GB,2)

Get-WmiObject -Namespace root\cimv2 -list | where name -Like "*Service*" | sort Name
Get-WmiObject -Class CIM_Service
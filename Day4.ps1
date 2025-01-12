<#Error handling in Powershell
Terminating Error - mostly due to Syntax error
Non Termination Error - Error while everything is correct #>

#ErrorAction  - limited to sing line command specific
#$ErrorActionPreference - Global error handling configuration

$ErrorActionPreference
$filepath = 'C:\LogFiles1'
try {
        $filelist = Get-ChildItem -Path $filepath -ea Stop
        Write-Output "After Error line"
        Write "Post Error Occred"
        foreach($item in $filelist){
             $content = Get-Content -Path $item.FullName
           }
        Write $content
}
catch{
        Write "Error occurred!!"
        $psItem.Exception[0].Message
        #Set-Content -Value $psItem.Exception[0].Message -Path "c:\logfiles\log1.txt"
        throw 
}
finally{}
#--------------------------------------------
$filepath = 'C:\Users\sachin.dilip.patil\Downloads\AZ-040T00\Powershell\Log'
$filelist = Get-ChildeItem -Path $filepath
Write-Output = "After Error line"
Write "Post Error occured"
foreach($item in $filelist){
    $content = Get-Content -path $item.Fullname   
}
Write $content
#Try - catch   or   Try - Finaly
#-------

$filepath = 'C:\Users\sachin.dilip.patil\Downloads\AZ-040T00\Powershell\Log'
Try{
    $filelist = Get-ChildeItem -Path $filepath
    Write-Output = "After Error line"
    Write "Post Error occured"
    foreach($item in $filelist){
        $content = Get-Content -path $item.Fullname   
    }
    Write $content
}
catch{
    write "Error occured"
    #$PSItem.Exception
    $PSItem.Exception[0].message
}

#------------------------------------------------------

try {
    # Code that might generate an error
    Get-Item "C:\NonExistentFile.txt" -ErrorAction Stop
}
catch {
    # Code to handle the error
    Write-Host "An error occurred: $_"
}

#------------------------
try {
    # Code that might generate an error
    Get-Item "C:\NonExistentFile.txt" -ErrorAction Stop
}
catch{
    # Code to handle the error
    Write-Host "An error occurred: $_"
    Set-Content -Value $_.Exception.Message -Path "C:\Users\sachin.dilip.patil\Downloads\AZ-040T00\Powershell\Log\Log1.txt"
}


##Modules----------------------------------Modules--------------------
#we can make our own module to reuse code - Not insatallable
<#Powershell Gallery - Central repository for PowerShell content i.e collection of modules, For using this 
we need to install and import to specific code.#>

#for user defined module we need to create manifest file and script file
#.PSD
#.PSM - contains actual code

#we can copy paste our module to path C:\Program Files\WindowsPowerShell\Modules    To make it available by default

Get-Command "*AZ*"
Get-PSRepository

New-ModuleManifest -Path "C:\Users\sachin.dilip.patil\Downloads\AZ-040T00\Powershell\ModuleFile\GetSumOfNumber.psd1"

Import-Module -Name "C:\Program Files\WindowsPowerShell\Modules\ModuleFile\MyModule.psm1"

Get-Module
Get-HelloWorld
Get-Sum 1,2,3,4

Remove-Module Get-HelloWorld -Force
Remove-Module MyModule -Force
Remove-Module GetSum -Force

#-------------------------------------------------
#WMI - CIM

[4:04 PM] K S, Ravi Kumar
#-- Query Computer System Hardware Information - Memory

Get-WmiObject -Class Win32_ComputerSystem | Select Manufacturer,Model,TotalPhysicalMemory

Get-WmiObject -Class Win32_ComputerSystem | Select Manufacturer,Model,@{n='RAM';e={$PSItem.TotalPhysicalMemory}}

Get-WmiObject -Class Win32_ComputerSystem | Select Manufacturer,Model,{[math]::Truncate($PSItem.TotalPhysicalMemory/1GB)}

Get-WmiObject -Class Win32_ComputerSystem | 

          Select Manufacturer,Model,@{n='RAM';e={[math]::Truncate($PSItem.TotalPhysicalMemory/1GB)}}
[4:04 PM] K S, Ravi Kumar
get-command "*wmi*"
 
get-wmiobject -List

Get-CimClass -ClassName "*"
 
 
get-wmiobject -list -Class "*net*"

get-wmiobject -list -Class "*oper*"

get-wmiobject -List -Class "*system*"

get-wmiobject -List -Class "*service*"
 
Get-WmiObject -Class Win32_networkadapter -ComputerName localhost

Get-WmiObject -Class Win32_OperatingSystem 

Get-WmiObject -Class Win32_ComputerSystem

$computerSystem = Get-WmiObject Win32_ComputerSystem

if ($computerSystem.Domain -eq "") {

  Write-Host "This computer is not joined to a domain"

} else {

  Write-Host "Domain: $($computerSystem.Domain)"

}

#-------------------------------------------------------------
 
Get-WmiObject -Class Win32_Service 

Get-WmiObject Win32_Service | Where-Object {$_.State -eq "Running"}

$service = Get-WmiObject Win32_Service -Filter "Name = 'W3SVC'"

$service.StopService()

$service.StartService()
 
#------------------------------------------------
 
#--List WMI/CIM Win32 classes

Get-CimClass
 
Get-WmiObject -Class Win32_ComputerSystem | Format-List -Property *
 
#-- Query Computer System Hardware Information - Memory

Get-WmiObject -Class Win32_ComputerSystem | Select Manufacturer,Model,TotalPhysicalMemory

Get-WmiObject -Class Win32_ComputerSystem | Select Manufacturer,Model,@{n='RAM';e={$PSItem.TotalPhysicalMemory}}

Get-WmiObject -Class Win32_ComputerSystem | Select Manufacturer,Model,{[math]::Truncate($PSItem.TotalPhysicalMemory/1GB)}

Get-WmiObject -Class Win32_ComputerSystem | Select Manufacturer,Model,@{n='RAM';e={[math]::Truncate($PSItem.TotalPhysicalMemory/1GB)}}
 
#-- Query Service Information

Get-WmiObject -Class Win32_Service | select name,state | where name -Like "winr*"
 
#-------CIM based commands

#--Query BIOS information usine CIM

Get-CimClass -ClassName "*bios*"

Get-CimInstance -ClassName Win32_Bios

#--Query Network adapter configuration

Get-Cimclass -ClassName "*adapter*"

Get-CimInstance -ClassName Win32_NetworkAdapter

#-- Reboot a computer using CIM command from powershell

Invoke-CimMethod -ClassName Win32_OperatingSystem -ComputerName 172-31-76-221  -MethodName Reboot

#-- Invoke CIM Method to kill Notepad application

Invoke-CimMethod -Query 'select * from Win32_Process where name like "notepad%"' -MethodName "Terminate"
 
#--Get and Set Service Startup status using WMI

Get-Service WinRM | Format-List *

Get-WmiObject -Class  "*service*"

Get-WmiObject -Class Win32_Service -Filter "Name = 'WinRM'" | Invoke-WmiMethod -Name ChangeStartMode -ArgumentList 'Manual'

#----------------------------------------

Get-WmiObject -Class Win32_networkadapter -ComputerName localhost
Get-WmiObject -Class Win32_OperatingSystem 
Get-WmiObject -Class Win32_ComputerSystem
Get-WmiObject -Class Win32_Service
 
#Get Remote Computer Disk information
 
 
Get-WmiObject Win32_logicaldisk -ComputerName IP-AC200D33 |
Select-Object DeviceID,FreeSpace,Size
 
Get-WmiObject Win32_logicaldisk -ComputerName IP-AC200D33 |
Select-Object DeviceID,FreeSpace, {$PSItem.Size / 1024Mb}
 
 
Get-WmiObject Win32_logicaldisk -ComputerName IP-AC200D33 |
Select-Object DeviceID,FreeSpace,@{label = 'Total Space'; 'Expression' = {$PSItem.Size / 1024Mb}}
 
Get-WmiObject Win32_logicaldisk -ComputerName localhost |
Select-Object DeviceID,FreeSpace, {[math]::Truncate($PSItem.Size / 1024Mb)}

Get-WmiObject Win32_logicaldisk -ComputerName localhost |
Select-Object DeviceID,FreeSpace, {[math]::Truncate($PSItem.Size / 1024Mb)}
#Variables

get-help about_variables -ShowWindow
get-help about_environment_variables -ShowWindow

#    user defined variableds
$var1 = 10
$var1.GetType()
$var1 = "Name"
$var1 = $false

#Variable is auto assigned based on assignment data
$ProcessList = Get-Process
$ProcessList

#strong type variable
[int]$var1=20
Clear-Variable $var2 #clear value from value
Remove-Variable $var2 # delete variable

$ProcessList[0].Handles
if()

#User defined values-can be changed
#Automatic variable cant be changed
Get-Process | Get-Member  #PSItem  #Contextual

#Preference variables
$ConfirmPreference # SAP Powershell module
$ErrorActionPreference #

#Environment variable : Starts wit $ENV
$env:CommonProgramFiles
$env:COMPUTERNAME
$env:USERNAME

Get-ComputerInfo | select WindowsProductName

#check About-variables , About-environment-variable

$arr1 = 1,2,3,4,5 #array
$arr11[]

$name = "n1","n2" #string array
$arr2 = @(1,2,3,4,5) #array
$arr3 = @(1..6)  #array with range operater
#We can change array value with another type of data like below
$arr1 = "n1","n2"
[int[,]]$twodarr = 1,2,3,4 # two dimentional array
[int[][]]$arrofarr = 1,2,3,4 # array of array

Foreach($item in $arr3)
{
    Write-Host $item
}

#0 index based
$num1= 1,2,3,4
$num2 = 1,2
$num = $num1+$num2
$num

# Array is List type of colloection
# Array is colleaction data, Index is predefined , Values
#------------------
#Hash table - Dictionry type collection
#You can create a hash table using the @{} syntax, where each key-value pair is separated by a = sign.
#index is user defined index i.e. key

$hashtable = @{
    Name = "Sachin"
    Position = "Analyst"
    Company = "ACN"
}
$hashtable.Count
$hashtable["Name"]  #accessing
$hashtable["Country"] = "India"  #Adding data
$hashtable["State"] = "Maharashtra"

$hashtable.Remove("State") # remove item

$hashtable1 = @{
    Name = "Sachin","Ravi"
    Position = "Analyst","Manager"
    Company = "ACN","ACN"
}

$hashtable1["Name"]
$hashtable1.Keys # print keys only
$hashtable1.Values #print values only

#Example of hashtable
$service=@{"winrm"="WinRM"; "WinInst"="MSIservere"}
foreach($item in $service.Keys)
{
    Stop-Service $service[$item]
}

$var5 = Read-Host "Read name"
$var6 = Read-Host "Read position"
$var7 = Read-Host "Read Company"
$hashtable3 = @{
    Name = $var5
    Position = $var6
    Company = $var7
}

$hashtable3


#Remoting 
#write script to create multiple users using the CSV input
#write script to install web server and build simple webpage
Get-PSDrive -PSProvider FileSystem

#Remoting session type:
#P2P one to one connection
#Multiple system one to many
# For remoting to work Windows remote management - WinRM service should be running on remote server

Get-Command "*session*" -Module Microsoft.Powershell.core
Get-PSSession

Enter-PSSession -ComputerName LocalHost # enter in localhost session
Get-PSDrive
Exit-PSSession

#Actual scenario using credential,Only valid for 1 to 1
$cred = Get-Credential -Message "Enter Login Deteails"
Enter-PSSession -ComputerName IP-AC20078C -Credential $cred
Exit-PSSession

#Multiple host
$cred = Get-Credential -Message "Enter Login Deteails"
$Session = New-PSSession -ComputerName localhost,IP-AC20078C -Credential $cred
Get-PSSession
Invoke-Command -Session $Session -ScriptBlock{Get-PSDrive -PSProvider FileSystem} #execute command
Invoke-Command -Session $Session -ScriptBlock{Get-Service -Name WinRM | Select Status}

Get-PSSession | Where ID -EQ 6 | Remove-PSSession #remove single PSsession
Get-PSSession | Remove-PSSession #remove all session
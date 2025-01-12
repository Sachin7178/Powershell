$cred = Get-Credential -Message "Enter Login Deteails"
$Session = New-PSSession -ComputerName add_computer_name_here -Credential $cred
Get-PSSession
Invoke-Command -Session $Session -ScriptBlock{Get-PSDrive -PSProvider FileSystem} #execute command
Invoke-Command -Session $Session -ScriptBlock{Get-Service -Name WinRM | Select Status}
Invoke-Command -Session $Session -ScriptBlock{
Get-CimInstance -Class CIM_OperatingSystem | Select Version
(Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion').UBR
}
 
Invoke-Command -Session $Session -ScriptBlock{winver}
 
 
 
Get-PSSession | Where ID -EQ 6 | Remove-PSSession #remove single PSsession
Get-PSSession | Remove-PSSession #remove all session 
 
 
Get-CimInstance -Class CIM_OperatingSystem -ComputerName (Get-Content -Path C:\server.txt) | select Object *
Get-CimInstance -Class CIM_OperatingSystem -ComputerName glpaueprap061 | Select Version
 
 
 
(Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion').UBR
(Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UpdatePolicy\Settings').ReleaseID
 
Star-Process -FilePath "Winver"
winver | Get-Member

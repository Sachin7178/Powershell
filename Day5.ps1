#Background jobs
Get-Command *job* -Module Microsoft.powershell.core, psscheduledjob

Get-Help Get-Job -Showwindow 
Get-Job
Start-Job -Name

#Ping-Test , track backup background job
Test-Connection -ComputerName LocalHost -Count 20

#we can run perticuler jobs up to some time. Powershelljobs are Asynchronus 
#We can run multiple jobs and other commands while on job is running
Start-Job -Name "PingTest" -ScriptBlock{Test-Connection -ComputerName LocalHost -Count 20}
Get-Service | Where Name -EQ "WinRM"
Get-Job | Receive-Job #Get a job and show result(it shows dat only once and it delete it). 
Get-Job | Receive-Job -Keep #To keep data we need to use "-Keep" to retain the data
Get-Job | Where ID -EQ 1 | Remove-Job

#overlap issue can happen in scheduled jobs
#Below is scheduled job example
(Get-Culture).DateTimeFormat.ShortDatePattern
 
$date = Get-Date -Date "24/05/2024 07:36:00AM"
$trigger = New-JobTrigger -Once -At  $date -RepetitionInterval (New-TimeSpan -Minutes 2) -RepetitionDuration (New-Timespan -Hours 2)
$options = New-ScheduledJobOption -StartIfOnBattery
Register-ScheduledJob -Name PingJob3 -ScriptBlock {Test-Connection -ComputerName IP-AC200D33,localhost -Count 20} -Trigger $trigger -ScheduledJobOption $options

#---------------------------------
#AZ modules
Install-Module -Name AZ.Compute
Install-Module -NAme AZ
Import-Module AZ
Get-Command -Module AZ.Accounts



# Authenticate to Azure
Connect-AzAccount
Disconnect-AzAccount

# Step 1: Authenticate to Azure
Connect-AzAccount
# Step 2: Select the specific subscription
$subscriptionId = "2ae3b17d-2520-4336-9e0d-adf658bb945c"
Select-AzSubscription -SubscriptionId $subscriptionId
# Verify the selected subscription
Write-Host "Selected Subscription:"
Get-AzContext



# Variables
$resourceGroupName = "myResourceGroup"
$location = "EastUS"
$vmName = "myUbuntuVM"
$vmSize = "Standard_DS1_v2"
$adminUsername = "azureuser"
$adminPassword = "P@ssw0rd1234!" # Replace with a secure password
$subnetName = "mySubnet"
$vnetName = "myVNet"
$vnetAddressPrefix = "10.0.0.0/16"
$subnetAddressPrefix = "10.0.0.0/24"
$publicIpName = "myPublicIP"
$nicName = "myNic"
$securityGroupName = "myNSG"
$imagePublisher = "Canonical"
$imageOffer = "UbuntuServer"
$imageSku = "18.04-LTS"
$imageVersion = "latest"

# Create a resource group
New-AzResourceGroup -Name $resourceGroupName -Location $location

# Create a virtual network
$vnet = New-AzVirtualNetwork -ResourceGroupName $resourceGroupName -Location $location `
    -Name $vnetName -AddressPrefix $vnetAddressPrefix

# Create a subnet
$subnet = Add-AzVirtualNetworkSubnetConfig -Name $subnetName -AddressPrefix $subnetAddressPrefix -VirtualNetwork $vnet

# Create the virtual network
$vnet | Set-AzVirtualNetwork

# Create a public IP address
$publicIp = New-AzPublicIpAddress -ResourceGroupName $resourceGroupName -Location $location `
    -Name $publicIpName -AllocationMethod Dynamic

# Create a network security group
$nsg = New-AzNetworkSecurityGroup -ResourceGroupName $resourceGroupName -Location $location -Name $securityGroupName

# Create a NIC
$nic = New-AzNetworkInterface -ResourceGroupName $resourceGroupName -Location $location `
    -Name $nicName -SubnetId $vnet.Subnets[0].Id -PublicIpAddressId $publicIp.Id -NetworkSecurityGroupId $nsg.Id

# Create a virtual machine configuration
$vmConfig = New-AzVMConfig -VMName $vmName -VMSize $vmSize |
    Set-AzVMOperatingSystem -Linux -ComputerName $vmName -Credential (Get-Credential -UserName $adminUsername -Message "Enter password") |
    Set-AzVMSourceImage -PublisherName $imagePublisher -Offer $imageOffer -Skus $imageSku -Version $imageVersion |
    Add-AzVMNetworkInterface -Id $nic.Id

# Create the VM
New-AzVM -ResourceGroupName $resourceGroupName -Location $location -VM $vmConfig

#-------------------------------
#Install webserver with the help of webserver 

Install-WindowsFeature -Name Web-Server -IncludeManagementTools                                                   
new-item -Name 'myportal'-ItemType Directory -Path 'C:\inetpub\wwwroot'                    
New-Item -Name index.html -ItemType File -Path 'C:\inetpub\wwwroot\myportal'               
Set-Content -Value '<html><body><b>Welcome to Powershell</b></body></html>' -Path 'C:\inetpub\wwwroot\myportal\index.html'

Get-WindowsFeature
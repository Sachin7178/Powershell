
Install-Module -NAme AZ -Scope CurrentUser -Repository PSGallery
#----------------------
az login --use-device-code
#Connect-AzAccount -SubscriptionName 'mbr_workshop'

az account show


az account list --output table


az login --tenant ""  #my subscription
az account set --subscription ""

az login --tenant Add_tenant_id_here --use-device-code # mimp

az login --tenantID Add_tenant_id_here

az group create --name MyResourceGroup --location eastus
az group delete --name MyResourceGroup --yes --no-wait


#-----------------
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Update-AzConfig -EnableLoginByWam $false


Connect-AzAccount -TenantId Add_tenant_id_here -UseDeviceAuthentication #alternate
Connect-AzAccount -UseDeviceAuthentication

Get-AzContext
Get-AzSubscription
Set-AzContext -Subscription "2ae3b17d-2520-4336-9e0d-adf658bb945c"

New-AzResourceGroup -Name MyResource -Location eastus
                        
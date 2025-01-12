
Install-Module -NAme AZ -Scope CurrentUser -Repository PSGallery
#----------------------
az login --use-device-code
#Connect-AzAccount -SubscriptionName 'mbr_workshop'

az account show


az account list --output table





az login --tenant "0938ad44-73dc-4627-b0ab-cb7ad38dec7a"  #my subscription
az account set --subscription "2ae3b17d-2520-4336-9e0d-adf658bb945c"

az login --tenant 0938ad44-73dc-4627-b0ab-cb7ad38dec7a --use-device-code # mimp

az login --tenantID 0938ad44-73dc-4627-b0ab-cb7ad38dec7a

az group create --name MyResourceGroup --location eastus
az group delete --name MyResourceGroup --yes --no-wait


#-----------------
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Update-AzConfig -EnableLoginByWam $false


Connect-AzAccount -TenantId 0938ad44-73dc-4627-b0ab-cb7ad38dec7a -UseDeviceAuthentication #alternate
Connect-AzAccount -UseDeviceAuthentication

Get-AzContext
Get-AzSubscription
Set-AzContext -Subscription "2ae3b17d-2520-4336-9e0d-adf658bb945c"

New-AzResourceGroup -Name MyResource -Location eastus
                        
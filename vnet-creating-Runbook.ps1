﻿Connect-AZAccount -Identity
Import-Module Az.Resources

$resourceGroupName = "Sachin-RG"
$location = "East US"
$vNetName = "Sachin-Vnet"
$vnetAddressPrefix = "172.68.0.0/16"
$subnetName = "Sachin-Subnet"
$subnetAddressPrefix = "172.68.1.0/24"

New-AzResourceGroup -Name $resourceGroupName -Location $location

New-AzVirtualNetwork -Name $vNetName -ResourceGroupName $resourceGroupName -Location $location -AddressPrefix $vnetAddressPrefix

#Get existing Azure Virtual Network information
$azvNet = Get-AzVirtualNetwork -Name $vNetName -ResourceGroupName $resourceGroupName
Add-AzVirtualNetworkSubnetConfig -Name $subnetName -AddressPrefix $subnetAddressPrefix -VirtualNetwork $azvNet 

#Make changes to vNet
$azvNet | Set-AzVirtualNetwork
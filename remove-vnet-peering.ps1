Login-AzAccount -tenant ""


Remove-AzVirtualNetworkPeering -Name 'Sachin-Vnet_to_Harshal-Vnet' -VirtualNetwork 'Sachin-Vnet' -ResourceGroupName 'Sachin-RG' -Force
Remove-AzVirtualNetworkPeering -Name 'Harshal-Vnet_to_Sachin-Vnet' -VirtualNetwork 'Harshal-Vnet' -ResourceGroupName 'Harshal-RG' -Force

$vms = Get-AzVM

# Initialize an empty list to store VM properties
$vmProperties = @()


foreach ($vm in $vms) {
    $vmInfo = @{

        "ResourceType"   = "VirtualMachine"
        "ResourceName"   = $vm.Name
        "PrivateIP"      = (Get-AzNetworkInterface -ResourceGroupName $vm.ResourceGroupName -Name (Split-Path -Leaf ($vm.NetworkProfile.NetworkInterfaces[0].Id))).IpConfigurations[0].PrivateIpAddress
        "ResourceStatus" = $vm.Statuses[0].DisplayStatus
        "ResourceGroup"  = $vm.ResourceGroupName
        "Location"       = $vm.Location
        "OS"             = $vm.StorageProfile.OsDisk.OsType
        "OS_Flavor"      = $vm.StorageProfile.OsDisk.OsState
        "OS_Publisher"   = $vm.StorageProfile.ImageReference.Publisher
        "OS_Offer"       = $vm.StorageProfile.ImageReference.Offer
        "VM_Size"        = $vm.HardwareProfile.VmSize
        "Description"    = $vm.Tags.Description
        "Environment"    = $vm.Tags.Environment
        "ServerBanding"  = $vm.Tags.ServerBanding
        "ComplianceFlag" = $vm.Tags.ComplianceFlag
     }
        
        $vmProperties += New-Object PSObject -Property $vmInfo
}



Login-AzureRmAccount


# Specify the resource group and VM name
$resourceGroupName = "YourResourceGroupName"
$vmName = "YourVMName"

# Get the VM status including InstanceView
$vm = Get-AzureRmVM -ResourceGroupName $resourceGroupName -Name $vmName -Status

# Check the VM status
$vmStatus = $vm.Statuses | Where-Object { $_.Code -like 'PowerState/*' }

if ($vmStatus.Code -eq 'PowerState/running') {
    Write-Output "The VM is running."
} elseif ($vmStatus.Code -eq 'PowerState/deallocated') {
    Write-Output "The VM is deallocated."
} else {
    Write-Output "The VM is in a different state: $($vmStatus.Code)"
}

# (Get-AzNetworkInterface -ResourceGroupName $vm.ResourceGroupName -Name (Split-Path -Leaf ($vm.NetworkProfile.NetworkInterfaces[0].Id))).IpConfigurations[0].PrivateIpAddress

$Myvms = Get-AzVM

$Properties = @()

foreach ($vm in $Myvms) {
    
    $privateIpAddress = ""
    $resourceStatus = ""
    $osPublisher = ""
    $osOffer = ""
    $description = ""
    $environment = ""
    $serverBanding = ""
    $complianceFlag = ""


    if ($vm.NetworkProfile.NetworkInterfaces -and $vm.NetworkProfile.NetworkInterfaces.Count -gt 0) {
        $nicId = $vm.NetworkProfile.NetworkInterfaces[0].Id
        $nicName = Split-Path -Leaf $nicId
        $nic = Get-AzNetworkInterface -ResourceGroupName $vm.ResourceGroupName -Name $nicName

        if ($nic.IpConfigurations -and $nic.IpConfigurations.Count -gt 0) {
            $privateIpAddress = $nic.IpConfigurations[0].PrivateIpAddress
        }
    }

    $powerState = (Get-AzVM -ResourceGroupName $vm.ResourceGroupName -Name $vm.Name -Status).Statuses | Where-Object Code -like 'PowerState/*' | Select-Object -ExpandProperty DisplayStatus
    $provisioningState = $vm.ProvisioningState
    
    if ($powerState -eq "VM running" -and $provisioningState -eq "Succeeded") {
        $resourceStatus = "Provisioning succeeded VM running"
    } elseif ($powerState -eq "VM deallocated") {
        $resourceStatus = "Provisioning succeeded VM deallocated"
    } else {
        $resourceStatus = "Unknown"
    }


    if ($vm.StorageProfile.ImageReference) {
        $osPublisher = $vm.StorageProfile.ImageReference.Publisher
        $osOffer = $vm.StorageProfile.ImageReference.Sku
    }

    if ($vm.Tags) {
        if ($vm.Tags.Description) { $description = $vm.Tags.Description } else {$description = ""}
        if ($vm.Tags.Environment) { $environment = $vm.Tags.Environment } else {$environment = ""}
        if ($vm.Tags.ServerBanding) { $serverBanding = $vm.Tags.ServerBanding } else {$serverBanding = ""}
        if ($vm.Tags.Compliance) { $complianceFlag = $vm.Tags.Compliance } else {$complianceFlag = ""}
    }

    $vmInfo = @{
        "ComplianceFlag" = $complianceFlag
        "ServerBanding"  = $serverBanding
        "Environment"    = $environment
        "Description"    = $description
        "VM_Size"        = $vm.HardwareProfile.VmSize
        "OS_Offer"       = $osOffer
        "OS_Publisher"   = if ($osPublisher -eq "MicrosoftWindowsServer") { "WindowsServer" } elseif ($osPublisher -eq "RedHat") { "RHEL" } else { $osPublisher }
        "OS_Flavor"      = $osPublisher
        "OS"             = $vm.StorageProfile.OsDisk.OsType
        "Location"       = $vm.Location
        "ResourceGroup"  = $vm.ResourceGroupName
        "ResourceStatus" = $resourceStatus
        "PrivateIP"      = $privateIpAddress
        "ResourceName"   = $vm.Name
        "ResourceType"   = "VirtualMachine"
        
    }

    $Properties += [PSCustomObject]$vmInfo
}


#$Properties = $Properties | Sort-Object -Property ResourceName
$Properties | Export-Excel -Path "C:\Users\sachin.dilip.patil\Downloads\File.xlsx" -AutoSize -FreezeTopRow -BoldTopRow



#$Properties | Format-Table -AutoSize
Login-AzAccount -tenant ""
$resourceGroupName = 'Sachin-RG' 
$location = 'East US' 
$vmName = 'Sachin-Server01'
$snapshotName = 'mySnapshot'

$vm = Get-AzVM -ResourceGroupName $resourceGroupName -Name $vmName

$snapshot =  New-AzSnapshotConfig -SourceUri $vm.StorageProfile.OsDisk.ManagedDisk.Id -Location $location -CreateOption copy

New-AzSnapshot -Snapshot $snapshot -SnapshotName $snapshotName -ResourceGroupName $resourceGroupName
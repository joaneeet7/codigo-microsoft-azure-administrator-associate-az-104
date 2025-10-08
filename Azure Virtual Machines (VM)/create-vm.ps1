$adminUser = "joanamengual"
$adminPassword = ConvertTo-SecureString "SecurePassword2025!" -AsPlainText -Force
$location = "westeurope"
$resourceGroup = "MyResourceGroup"
$computerName = "MyVM"
$vmName = "MyVM"
$vmSize = "Standard_B1s"

# Ensure resource group exists
if (-not (Get-AzResourceGroup -Name $resourceGroup -ErrorAction SilentlyContinue)) {
    New-AzResourceGroup -Name $resourceGroup -Location $location
}

$virtualNetworkName = "MyVNet"
$subnetName = "MySubnet"
$nicName = "MyNIC"
$subnetPrefix = "10.0.0.0/24"
$vnetPrefix = "10.0.0.0/16"

$singleSubnet = New-AzVirtualNetworkSubnetConfig -Name $subnetName -AddressPrefix $subnetPrefix

$vnet = New-AzVirtualNetwork -Name $virtualNetworkName `
  -ResourceGroupName $resourceGroup `
  -Location $location `
  -AddressPrefix $vnetPrefix `
  -Subnet $singleSubnet

$nic = New-AzNetworkInterface -Name $nicName `
  -ResourceGroupName $resourceGroup `
  -Location $location `
  -SubnetId $vnet.Subnets[0].Id

$cred = New-Object System.Management.Automation.PSCredential($adminUser, $adminPassword)

$vm = New-AzVMConfig -VMName $vmName -VMSize $vmSize
$vm = Set-AzVMOperatingSystem -VM $vm -Windows -ComputerName $computerName -Credential $cred -ProvisionVMAgent -EnableAutoUpdate
$vm = Add-AzVMNetworkInterface -VM $vm -Id $nic.Id
$vm = Set-AzVMSourceImage -VM $vm -PublisherName "MicrosoftWindowsServer" -Offer "WindowsServer" -Skus "2022-datacenter-azure-edition" -Version "latest"

New-AzVM -ResourceGroupName $resourceGroup -Location $location -VM $vm -Verbose

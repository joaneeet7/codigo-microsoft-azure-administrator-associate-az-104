# create-vm.ps1

# Configuration
$adminUsername = "joanamengual"
$adminPassword = ConvertTo-SecureString "SecurePassword!" -AsPlainText -Force
$location = "westeurope"
$resourceGroup = "MyResourceGroup"
$computerName = "MyVM"
$vmName = "MyVM"
$vmSize = "Standard_B1s"

# Network configuration
$virtualNetworkName = "MyVNet"
$subnetName = "MySubnet"
$nicName = "MyNIC"
$subnetPrefix = "10.0.2.0/24"
$vnetPrefix = "10.0.0.0/16"

# Create subnet config
$subnetConfig = New-AzVirtualNetworkSubnetConfig -Name $subnetName -AddressPrefix $subnetPrefix

# Create virtual network
$vnet = New-AzVirtualNetwork -Name $virtualNetworkName `
  -ResourceGroupName $resourceGroup `
  -Location $location `
  -AddressPrefix $vnetPrefix `
  -Subnet $subnetConfig

# Create network interface
$nic = New-AzNetworkInterface -Name $nicName `
  -ResourceGroupName $resourceGroup `
  -Location $location `
  -SubnetId $vnet.Subnets[0].Id

# Create credentials
$credentials = New-Object System.Management.Automation.PSCredential ($adminUsername, $adminPassword)

# VM configuration
$vmConfig = New-AzVMConfig -VMName $vmName -VMSize $vmSize

$vmConfig = Set-AzVMOperatingSystem -VM $vmConfig -Windows `
  -ComputerName $computerName `
  -Credential $credentials `
  -ProvisionVMAgent -EnableAutoUpdate

$vmConfig = Add-AzVMNetworkInterface -VM $vmConfig -Id $nic.Id

$vmConfig = Set-AzVMSourceImage -VM $vmConfig `
  -PublisherName "MicrosoftWindowsServer" `
  -Offer "WindowsServer" `
  -Skus "2022-datacenter-azure-edition-core" `
  -Version "latest"

# Create the virtual machine
New-AzVM `
  -ResourceGroupName $resourceGroup `
  -Location $location `
  -VM $vmConfig `
  -Verbose

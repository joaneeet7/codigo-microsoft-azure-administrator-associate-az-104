# Define admin credentials for the virtual machine
$adminUser = "joanamengual"
$adminPassword = ConvertTo-SecureString "SecurePassword!" -AsPlainText -Force  # Convert plain text password to a secure string

# Define basic configuration parameters
$location = "westeurope"          # Azure region where the VM will be deployed
$resourceGroup = "MyResourceGroup" # Name of the resource group
$computerName = "MyVM"             # Computer name inside the OS
$vmName = "MyVM"                   # Name of the virtual machine in Azure
$vmSize = "Standard_B1s"           # VM size (defines CPU, memory, etc.)

# Ensure that the resource group exists; create it if it doesn't
if (-not (Get-AzResourceGroup -Name $resourceGroup -ErrorAction SilentlyContinue)) {
    New-AzResourceGroup -Name $resourceGroup -Location $location
}

# Define networking variables
$virtualNetworkName = "MyVNet"   # Name of the virtual network
$subnetName = "MySubnet"         # Name of the subnet
$nicName = "MyNIC"               # Name of the network interface card (NIC)
$subnetPrefix = "10.0.0.0/24"    # IP address range for the subnet
$vnetPrefix = "10.0.0.0/16"      # IP address range for the virtual network

# Create a subnet configuration
$singleSubnet = New-AzVirtualNetworkSubnetConfig -Name $subnetName -AddressPrefix $subnetPrefix

# Create the virtual network (VNet) with the defined subnet
$vnet = New-AzVirtualNetwork -Name $virtualNetworkName `
  -ResourceGroupName $resourceGroup `
  -Location $location `
  -AddressPrefix $vnetPrefix `
  -Subnet $singleSubnet

# Create a network interface (NIC) and associate it with the subnet
$nic = New-AzNetworkInterface -Name $nicName `
  -ResourceGroupName $resourceGroup `
  -Location $location `
  -SubnetId $vnet.Subnets[0].Id

# Create a credential object using the admin username and password
$cred = New-Object System.Management.Automation.PSCredential($adminUser, $adminPassword)

# Create a new virtual machine configuration object
$vm = New-AzVMConfig -VMName $vmName -VMSize $vmSize

# Set up the operating system for the VM (Windows in this case)
$vm = Set-AzVMOperatingSystem -VM $vm -Windows -ComputerName $computerName -Credential $cred -ProvisionVMAgent -EnableAutoUpdate

# Attach the previously created network interface to the VM
$vm = Add-AzVMNetworkInterface -VM $vm -Id $nic.Id

# Specify the source image for the VM (Windows Server 2022 Datacenter Azure Edition)
$vm = Set-AzVMSourceImage -VM $vm -PublisherName "MicrosoftWindowsServer" -Offer "WindowsServer" -Skus "2022-datacenter-azure-edition" -Version "latest"

# Deploy the virtual machine with all the defined configurations
New-AzVM -ResourceGroupName $resourceGroup -Location $location -VM $vm -Verbose

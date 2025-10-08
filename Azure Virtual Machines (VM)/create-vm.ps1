# create-vm.ps1

# Configuration variables
$resourceGroup = "MyResourceGroup"
$location = "westeurope"
$vmName = "MyVM"
$image = "Win2022Datacenter"
$size = "Standard_B1s"
$username = "joanamengual"
$password = ConvertTo-SecureString "SecurePassword!" -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential($username, $password)

# Login to Azure
Connect-AzAccount

# Create resource group if it doesn't exist
if (-not (Get-AzResourceGroup -Name $resourceGroup -ErrorAction SilentlyContinue)) {
    New-AzResourceGroup -Name $resourceGroup -Location $location
}

# Create the virtual machine
New-AzVM `
  -ResourceGroupName $resourceGroup `
  -Name $vmName `
  -Location $location `
  -Image $image `
  -Size $size `
  -Credential $credential `
  -OpenPorts 3389

Write-Host "✅ Virtual machine '$vmName' created successfully in region $location with user '$username'."

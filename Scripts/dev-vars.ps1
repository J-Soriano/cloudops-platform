# CloudOps Platform - Dev Environment Variables

$rg        = "cloudops-tfstate-rg"
$sa        = "cloudopstfstate01"
$container = "tfstate"

# Pull the storage key dynamically (do NOT hardcode secrets)
$key = az storage account keys list `
  --resource-group $rg `
  --account-name $sa `
  --query "[0].value" -o tsv
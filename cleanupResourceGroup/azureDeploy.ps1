$resourceGroup = "jegebhDevRG"
$templatePath = "C:\Users\v-jegebh\projects\azure-arm-templates\cleanupResourceGroup\clearRG.template.json"

$deployment = New-AzureRmResourceGroupDeployment -ResourceGroupName $resourceGroup -Mode Complete -TemplateFile $templatePath -Force

$deployment
$resourceGroup = ""
$templatePath = ""

New-AzureRmResourceGroupDeployment -ResourceGroupName $resourceGroup -Mode Complete -TemplateFile $templatePath -Force
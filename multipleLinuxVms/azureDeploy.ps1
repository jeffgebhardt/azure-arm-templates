#Set Script Params
$resourceGroupName = "jegebhDevRG"
$numInstances = 2
$templatePath = "C:\Users\v-jegebh\projects\azure-arm-templates\multipleLinuxVms\azureDeploy.template.json"


$deployment = New-AzureRmResourceGroupDeployment -ResourceGroupName $resourceGroupName -numberOfInstances $numInstances -TemplateFile $templatePath  -verbose

$deployment.OutputsString
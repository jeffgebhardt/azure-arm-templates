#Set Script Params
$resourceGroupName = "jegebhDevRG"
$templatePath = "C:\Users\v-jegebh\projects\azure-arm-templates\singleLinuxVm\deploylinuxVm.template.json"

$params = @{
    adminUsername = "jegebh";
}

$deployment = New-AzureRmResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateFile $templatePath -TemplateParameterObject $params -verbose

$deployment.OutputsString

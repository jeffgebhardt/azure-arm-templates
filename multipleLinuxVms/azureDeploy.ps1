#Set Script Params
$resourceGroupName = "jegebhWebTest"
$resourceGroupLocation = "eastus"
$deploymentName = "jegebhWebDeployTest"
$numInstances = 4
$templatePath = "C:\Users\v-jegebh\projects\azure-arm-templates\201-vm-copy-index-loops\azureDeploy.json"
$sshPubKey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDJgSw6X1tiXNE6YiAFy293cNwm1mFTNwbx012QIzbL0zYAoof6J9J7YZFbRE+sG79VmML9nfp0QzxhG92EpqvgOF6Y14vApYNUDIZh/DTvZnF8C8fj7UqabdVQh03wBkiorJqET0GxGtlXVRRcvRRrl3/BYG6ABQyvEFx+CSu9di7Zs2zoxuP0wIvb+V6Spee+skHo92j6CyJ6GYFd6l4ncppIKZAjA0GtNuV/wakg8l/Flq3owjbJdFa8iJFYLkfdnA5bcoK5mWOHY9Xk+JDj5o/1lY3EYi264PbXK8HMpYOKXefqOmBV4cW1W4ERkO2U44u3nW7mTBU0/sksEHZz jgebhardt@MININT-2376EFB"

#Create new Resource group
New-AzureRmResourceGroup -Name $resourceGroupName -Location $resourceGroupLocation
New-AzureRmResourceGroupDeployment -Name $deploymentName -ResourceGroupName $resourceGroupName -numberOfInstances $numInstances `
  -sshKeyData $sshPubKey -TemplateFile $templatePath  -verbose
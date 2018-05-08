#Set Script Params
$resourceGroupName = "jegebhDevRG"
$resourceGroupLocation = "westcentralus"
$templatePath = "C:\Users\v-jegebh\projects\azure-arm-templates\singleLinuxVm\deploylinuxVm.template.json"
$sshPubKey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDJgSw6X1tiXNE6YiAFy293cNwm1mFTNwbx012QIzbL0zYAoof6J9J7YZFbRE+sG79VmML9nfp0QzxhG92EpqvgOF6Y14vApYNUDIZh/DTvZnF8C8fj7UqabdVQh03wBkiorJqET0GxGtlXVRRcvRRrl3/BYG6ABQyvEFx+CSu9di7Zs2zoxuP0wIvb+V6Spee+skHo92j6CyJ6GYFd6l4ncppIKZAjA0GtNuV/wakg8l/Flq3owjbJdFa8iJFYLkfdnA5bcoK5mWOHY9Xk+JDj5o/1lY3EYi264PbXK8HMpYOKXefqOmBV4cW1W4ERkO2U44u3nW7mTBU0/sksEHZz jgebhardt@MININT-2376EFB"


$params = @{
    adminUsername = "jegebh";
}

$deployment = New-AzureRmResourceGroupDeployment -ResourceGroupName $resourceGroupName -sshKeyData $sshPubKey -TemplateFile $templatePath -TemplateParameterObject $params -verbose

$deployment.OutputsString

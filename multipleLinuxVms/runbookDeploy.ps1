param (
    [Parameter(Mandatory=$true)]
    [string]
    $ResourceGroupName,

    [Parameter(Mandatory=$true)]
    [string]
    $StorageAccountName,

    [Parameter(Mandatory=$true)]
    [string]
    $StorageFileName,

    [Parameter(Mandatory=$true)]
    [string]
    $NumInstances
)

# Authenticate to Azure if running from Azure Automation
$ServicePrincipalConnection = Get-AutomationConnection -Name "AzureRunAsConnection"
Add-AzureRmAccount `
    -ServicePrincipal `
    -TenantId $ServicePrincipalConnection.TenantId `
    -ApplicationId $ServicePrincipalConnection.ApplicationId `
    -CertificateThumbprint $ServicePrincipalConnection.CertificateThumbprint | Write-Verbose

$StorageAccountKey = Get-AzureRmAutomationVariable -Name "storageKey" -ResourceGroupName "jobivens-rg" -AutomationAccountName "automata"

# Create a new context
$Context = New-AzureStorageContext -StorageAccountName $StorageAccountName -StorageAccountKey $StorageAccountKey

Get-AzureStorageFileContent -ShareName 'arm-templates' -Context $Context -path 'azureDeploy.template.json' -Destination 'C:\Temp'

$TemplatePath = Join-Path -Path 'C:\Temp' -ChildPath $StorageFileName
$sshPubKey = Get-AzureRmAutomationVariable -Name "storageKey" -ResourceGroupName "jobivens-rg" -AutomationAccountName "automata" 

# Deploy the storage account
$deployment = New-AzureRmResourceGroupDeployment -ResourceGroupName $ResourceGroupName -numberOfInstances $NumInstances -sshKeyData $sshPubKey -TemplateFile $TemplatePath

$mailParams = @{
"RunbookName" = "deployLinuxVMs";
"MessageBody" = $deployment
}

Start-AzureRmAutomationRunbook -ResourceGroupName "jobivens-rg" -Name "sendMail" -AutomationAccountName "automata" -Parameters $mailParams
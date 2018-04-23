param (
    [Parameter(Mandatory=$true)]
    [string]
    $ResourceGroupName,

    [Parameter(Mandatory=$true)]
    [string]
    $StorageAccountName,

    [Parameter(Mandatory=$true)]
    [string]
    $StorageFileName
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

Get-AzureStorageFileContent -ShareName 'arm-templates' -Context $Context -path 'clearRG.template.json' -Destination 'C:\Temp'

$TemplatePath = Join-Path -Path 'C:\Temp' -ChildPath $StorageFileName

$deployment = New-AzureRmResourceGroupDeployment -ResourceGroupName $ResourceGroupName -Mode Complete -TemplateFile $templatePath -Force

$mailParams = @{
"RunbookName" = "clearRG";
"MessageBody" = $deployment
}

Start-AzureRmAutomationRunbook -ResourceGroupName "jobivens-rg" -Name "sendMail" -AutomationAccountName "automata" -Parameters $mailParams
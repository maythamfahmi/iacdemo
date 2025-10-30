[CmdletBinding()]
param (
    [Parameter(Mandatory = $false)]
    [String]$location,

    [Parameter(Mandatory = $false)]
    [String]$tenantId,

    [Parameter(Mandatory = $false)]
    [String]$subscriptionId,

    [Parameter(Mandatory = $false)]
    [String]$TemplateFileName,

    [Parameter(Mandatory = $false)]
    [String]$ParameterFileName
)

# Set Az Context
if (![string]::IsNullOrEmpty($tenantId) -And ![string]::IsNullOrEmpty($subscriptionId)) {
    Write-Verbose "Setting Azure Context to subscription: $subscriptionId in tenant: $tenantId"
    Set-AzContext -Tenant $tenantId -Subscription $subscriptionId -ErrorAction "Stop" | Out-Null
}

# Deploying
Write-Verbose "Deploying infrastructure"
$splat = @{
    Name                  = "Infra-demo"
    TemplateFile          = "$TemplateFileName"
    TemplateParameterFile = "$($ParameterFileName).json"
    ErrorAction           = "stop"
    Location              = $location
    Verbose               = $true
}

# Subscription level deployment
Write-Verbose "Performing subscription-level deployment"
bicep build-params "$($ParameterFileName).bicepparam" | Out-Null
New-AzDeployment @splat 
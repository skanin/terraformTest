[CmdletBinding()]
param (
    [Parameter(Mandatory=$true, HelpMessage="Location of the resources")]
    [string] $RuleName,
    
    [Parameter(Mandatory=$true, HelpMessage="Location of the resources")]
    [string] $WebAppName,
    
    [Parameter(Mandatory=$true, HelpMessage="Instance Id (i.e. 01, 02) of the resources")]
    [string] $ResourceGroupName,
    
    [Parameter(Mandatory=$true, HelpMessage="Environment name (dev, test, prod)")]
    [bool] $Enable
)

function GetMyIp() {
    $ret = Invoke-RestMethod -Uri "https://api.ipify.org?format=json" -Method Get
    return $ret.ip
}

$myip = GetMyIp
Write-Host "Detecting IP address: $myip"

Write-Host "Removing old JIT rule"
az $azFunc config access-restriction remove -g $ResourceGroupName -n $WebAppName --rule-name "JIT_CICD_$RuleName"
if ($Enable) {
    Write-Host "Enabling JIT rule"
    az functionapp config access-restriction add  -g $ResourceGroupName -n $WebAppName --rule-name "JIT_CICD_$RuleName" --action Allow --ip-address "$myip/32" --priority 100
    Start-Sleep -Seconds 15
}

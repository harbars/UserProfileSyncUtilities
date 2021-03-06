<#
    Resets UPA properties to defaults.
#>
If ($null -eq (Get-PSSnapin -Name "Microsoft.SharePoint.PowerShell" -EA 0)) { Add-PSSnapin -Name "Microsoft.SharePoint.PowerShell" }

$UpaName = "User Profile Service Application"

$Upa = Get-SPServiceApplication | Where-Object {$_.DisplayName -eq $UpaName}
$Upa.NoILMUsed = $true
$Upa.NetBIOSDomainNamesEnabled = $false
$Upa.Update()
#EOF
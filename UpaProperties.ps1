<#
    Gets or Sets the UPA properties for External Identity Manager and NetBiosDomainNames

    Demo Workpad
#>
If ((Get-PSSnapin -Name "Microsoft.SharePoint.PowerShell" -EA 0) -eq $null) { Add-PSSnapin -Name "Microsoft.SharePoint.PowerShell" }

# noIlmUsed 
# True means Active Directory Import (ADI) - we are not using "ilm" - i.e. User Profile Sync
# False means User Profile Sync (UPS) *OR* External Identity Manager (EIM)
# False should not be set unless SP16 & Feb 17 PU applied, as there is a bug with refdata

Function Get-UpaProperties {
    param ($upaName)
    Clear-Host
    $upa = Get-SPServiceApplication | Where-Object {$_.DisplayName -eq $upaName}
    if ($upa.NoILMUsed) { Write-Host "Active Directory Import mode is configured!" -ForegroundColor "Red" }
    else { Write-Host "External Identity Manager is configured." -ForegroundColor Green }
    if ($upa.NetBIOSDomainNamesEnabled) { Write-Host "NetBIOSDomainNames are Enabled." -ForegroundColor "Green" }
    else { Write-Host "NetBIOSDomainNames are NOT enabled!" -ForegroundColor Red }
}

Function Set-UpaProperties {
    param ($upaName)
    $upa = Get-SPServiceApplication | Where-Object {$_.DisplayName -eq $upaName}
    $upa.NoILMUsed = $false
    $upa.NetBIOSDomainNamesEnabled = $true
    $upa.Update()
    Get-UpaProperties $upaName
}

$upaName = "User Profile Service Application"
Get-UpaProperties $upaName

Set-UpaProperties $upaName

#EOF
#testing new vscode
#another edit
<#
    Adds a user to Farm Administrators, and outputs the resulting Farm Administrators.

    The account which runs the SharePoint MA must be a farm administrator in order to connect to Central Administration
    TEST AGAINw
#>
If ((Get-PSSnapin -Name "Microsoft.SharePoint.PowerShell" -EA 0) -eq $null) { Add-PSSnapin -Name "Microsoft.SharePoint.PowerShell" }

$FarmAdmin = "FABRIKAM\spma"

$CentralAdminUrl = Get-SPWebApplication -includecentraladministration | Where-Object {$_.IsAdministrationWebApplication} | Select-Object -ExpandProperty Url
$CentralAdminSite = Get-SPWeb -Identity $CentralAdminUrl
$AdminGroup = $CentralAdminSite.AssociatedOwnerGroup
Set-SPUser -UserAlias $FarmAdmin -Web $CentralAdminUrl -Group $AdminGroup #New-SPUser if never added before

$AdminGroup.Users
#EOF
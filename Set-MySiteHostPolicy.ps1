<#
    Creates a new Web Application Policy for the My Site Host and adds the SharePoint MA to that policy using a classic identifier.

    The account which runs the SharePoint MA must have this User Policy in order to successfully create profile photos from ThumbnailPhoto.
    MUST be done via PoSh as the UI will create a Claims identifier.

    http://www.harbar.net/archive/2018/02/02/Using-PowerShell-to-import-Profile-Photos-when-using-Active-Directory.aspx
#>
If ((Get-PSSnapin -Name "Microsoft.SharePoint.PowerShell" -EA 0) -eq $null) { Add-PSSnapin -Name "Microsoft.SharePoint.PowerShell" }


$WebAppUrl = "https://onedrive.fabrikam.com"
$PolicyRoleName = "MIM Photo Import"
$PolicyRoleDescription = "Allows MIM SP MA to export photos to the MySite Host."
$GrantRightsMask = "ViewListItems, AddListItems, EditListItems, DeleteListItems, Open"
$SpMaAccount = "FABRIKAM\spma"
$SpMaAccountDescription = "MIM SP MA Account"

$WebApp = Get-SPWebApplication -Identity $WebAppUrl


$policyRole = $WebApp.PolicyRoles.Add($PolicyRoleName, $PolicyRoleDescription)
$policyRole.GrantRightsMask = $GrantRightsMask
$policy = $WebApp.Policies.Add($SpMaAccount, $SpMaAccountDescription)
$policy.PolicyRoleBindings.Add($policyRole)
$WebApp.Update()
#EOF
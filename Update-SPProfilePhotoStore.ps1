<#
    Creates the three thumbnail photos from source binary data already in My Site host.

    Should be scheduled to run on a machine in the farm hosting the User Profiles service instance
    If run on a machine not hosting that service, it will complete successfully, doing nothing.
#>
If ((Get-PSSnapin -Name "Microsoft.SharePoint.PowerShell" -EA 0) -eq $null) { Add-PSSnapin -Name "Microsoft.SharePoint.PowerShell" }


$MySiteHost = "https://onedrive.fabrikam.com"

Update-SPProfilePhotoStore -CreateThumbnailsForImportedPhotos $true -MySiteHostLocation $MySiteHost
#EOF
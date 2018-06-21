<#
    Run the EIM Membership and Relationships Timer job.

    Run after initial import to resolve and populate reference data correctly. Not required in production with recent SP13/16/19 builds
#>
If ((Get-PSSnapin -Name "Microsoft.SharePoint.PowerShell" -EA 0) -eq $null) { Add-PSSnapin -Name "Microsoft.SharePoint.PowerShell" }

Get-SPTimerJob | Where-Object {$_.TypeName -match 'ExternalIdentityManagerMembershipsAndRelationshipsJob'} | Start-SPTimerJob
#EOF
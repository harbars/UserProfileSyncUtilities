<#
    Workpad for SP Connector - for demo use only
#>
Start-Service "FIMSynchronizationService"

$WorkingPath = "c:\SP16MIMBase"                           # Path to the MA files and Module
$CentralAdminUrl = "https://spca.fabrikam.com"            # Url of Central Administration
$ForestDnsName = "fabrikam.com"                           # DNS name of the Forest
$AdMaAccountName = "FABRIKAM\sppsync"                     # AD MA Account Name (needs dirsync rights)
$SpMaAccountName = "FABRIKAM\spma"                        # SharePoint MA Account Name (A Farm Administrator)
                                                          # NOTE: *must* have correct policy on MySite Web App to export photos
$PictureFlow = 'Export only (NEVER from SharePoint)'      # Picture Flow - 'Export only (NEVER from SharePoint)' or 'Import only (ALWAYS from SharePoint)'
                                                          # NOTE: Import only is not implemented

# Semi-colon delimited list of DNs of containers to Sync
$OrganizationalUnits = 'OU=Fabrikam Users,DC=fabrikam,DC=com;OU=Ent Users,DC=fabrikam,DC=com;OU=Legal,DC=fabrikam,DC=com'
  
# For original toolkit
$OrganizationalUnits = 'OU=Fabrikam Users,DC=fabrikam,DC=com'  

# Credential Requests
# TODO: Add validation from SPAT here
$AdMaAccountCreds = Get-Credential $AdMaAccountName
$SpMaAccountCreds = Get-Credential $SpMaAccountName



# Import the SharePoint Sync Module
# ORIGINAL
Import-Module $WorkingPath\SharePointSync.psm1 -Force

# Configure the sample AD and SP MAs
# ORIGINAL
Install-SharePointSyncConfiguration -Path $WorkingPath -Verbose `
                                    -ForestDnsName $ForestDnsName `
                                    -ForestCredential $AdMaAccountCreds `
                                    -SharePointUrl $CentralAdminUrl `
                                    -SharePointCredential $SpMaAccountCreds `
                                    -PictureFlowDirection $PictureFlow `
                                    -OrganizationalUnit $OrganizationalUnits

<#
# Modified version
Import-Module $WorkingPath\SHSharePointSync.psm1 -Force

# Modified version
Install-SharePointSyncConfiguration -Path $WorkingPath -Verbose `
                                    -ForestDnsName $ForestDnsName `
                                    -ForestCredential $SyncAccountCreds `
                                    -SharePointUrl $CentralAdminUrl `
                                    -SharePointCredential $FarmAccountCreds `
                                    -PictureFlowDirection $PictureFlow `
                                    -OrganizationalUnits $OrganizationalUnits 

#>


# do the "what if" sync, which isn't whatif at all but merely doens't run the export to SP
Start-SharePointSync -WhatIf -Verbose 


### Run the Synchronization Service management agents 
## FULL SYNC
Start-SharePointSync -Verbose 
#EOF
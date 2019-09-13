Get-ADUser -Filter 'HomeDrive -ne "$Local"' `
-Property Name,CanonicalName,CN,DisplayName,DistinguishedName,HomeDirectory,`
HomeDrive,SamAccountName,UserPrincipalName | `
export-csv -path (Join-Path $pwd HomeDrive.csv) -encoding ascii -NoTypeInformation



# Run 'Get-ExecutionPolicy'. If it returns 'Restricted', then run 'Set-ExecutionPolicy Unrestricted'
# Set-ExecutionPolicy Bypass -Scope Process
# After Script is finished 'Set-ExecutionPolicy Restricted' to set back to default.

Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

choco install 7zip.install -y
choco install atom -y
choco install ccleaner -y
choco install chocolatey-core.extension -y
choco install firefox -y
choco install flashplayeractivex -y
choco install flashplayerplugin -y
choco install foxitreader -y
choco install googlechrome -y
choco install javaruntime -y
choco install jre8 -y
choco install notepadplusplus.install -y
choco install putty.install -y
choco install silverlight -y
choco install slack -y
choco install vlc -y
choco install zoom -y

Get-AppxPackage -name "Microsoft.ZuneMusic" | Remove-AppxPackage 
Get-AppxPackage -name "Microsoft.Music.Preview" | Remove-AppxPackage
Get-AppxPackage -name "Microsoft.XboxGameCallableUI" | Remove-AppxPackage 
Get-AppxPackage -name "Microsoft.XboxIdentityProvider" | Remove-AppxPackage 
Get-AppxPackage -name "Microsoft.BingTravel" | Remove-AppxPackage 
Get-AppxPackage -name "Microsoft.BingHealthAndFitness" | Remove-AppxPackage 
Get-AppxPackage -name "Microsoft.BingFoodAndDrink" | Remove-AppxPackage 
Get-AppxPackage -name "Microsoft.People" | Remove-AppxPackage 
Get-AppxPackage -name "Microsoft.BingFinance" | Remove-AppxPackage 
Get-AppxPackage -name "Microsoft.3DBuilder" | Remove-AppxPackage 
Get-AppxPackage -name "Microsoft.WindowsCalculator" | Remove-AppxPackage 
Get-AppxPackage -name "Microsoft.BingNews" | Remove-AppxPackage 
Get-AppxPackage -name "Microsoft.XboxApp" | Remove-AppxPackage 
Get-AppxPackage -name "Microsoft.BingSports" | Remove-AppxPackage 
Get-AppxPackage -name "Microsoft.WindowsCamera" | Remove-AppxPackage 
Get-AppxPackage -name "Microsoft.Getstarted" | Remove-AppxPackage 
Get-AppxPackage -name "Microsoft.Office.OneNote" | Remove-AppxPackage 
Get-AppxPackage -name "Microsoft.WindowsMaps" | Remove-AppxPackage 
Get-AppxPackage -name "Microsoft.MicrosoftSolitaireCollection" | Remove-AppxPackage 
Get-AppxPackage -name "Microsoft.MicrosoftOfficeHub" | Remove-AppxPackage 
Get-AppxPackage -name "Microsoft.BingWeather" | Remove-AppxPackage 
Get-AppxPackage -name "Microsoft.BioEnrollment" | Remove-AppxPackage 
Get-AppxPackage -name "Microsoft.WindowsStore" | Remove-AppxPackage 
Get-AppxPackage -name "Microsoft.Windows.Photos" | Remove-AppxPackage 
Get-AppxPackage -name "Microsoft.WindowsPhone" | Remove-AppxPackage

"SCRIPT COMPLETED"

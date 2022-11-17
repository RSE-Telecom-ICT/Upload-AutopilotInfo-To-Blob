#Download AzCopy
Invoke-WebRequest -Uri "https://aka.ms/downloadazcopy-v10-windows" -OutFile AzCopy.zip -UseBasicParsing
 
#Expand Archive
Expand-archive -Path '.\AzCopy.zip' -Destinationpath '.\' -Force
 
#Find AzCopy
$AzCopy = (Get-ChildItem -path '.\' -Recurse -File -Filter 'azcopy.exe').FullName
 
#Check if NuGet provider is installed, if not install it 
Write-Host "Checking if NuGet provider exists"
if ((Get-PackageProvider -ListAvailable | where-object Name -eq NuGet) -ne $null) {
    Write-Host "NuGet provider exists"
} 
else {
    Write-Host "NuGet provider is not installed, Installing now...."
    Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
    Write-Host "NuGet provider Installed"
}

#Check if Powershell Autopilot script is installed, if not install it 
Write-Host "Checking if script Get-WindowsAutopilotInfo exists"
if (Get-InstalledScript -Name Get-WindowsAutopilotInfo) {
    Write-Host "script Get-WindowsAutopilotInfo exists"
} 
else {
    Write-Host "Script Get-WindowsAutopilotInfo is not installed, Installing now...."
    Install-Script Get-WindowsAutopilotInfo -Force
    Write-Host "Script Get-WindowsAutopilotInfo Installed"
}

#Use computername as part of the filename
$Filename = "AutopilotHWID-" + $env:COMPUTERNAME.ToString() + ".csv"

#Get location of Autopilot script
$scriptlocation = (Get-InstalledScript -Name Get-WindowsAutopilotInfo).InstalledLocation

#Generate CSV file for upload to azure blob storage
& $scriptlocation\Get-WindowsAutoPilotInfo.ps1 -OutputFile $Filename -Partner -Force

#Set relative path to be used by AzCopy
$RelativePath = './' + $Filename

#Use AzCopy to upload the generated CSV to blob storage
& $AzCopy cp $RelativePath $env:SasURL --overwrite true

netsh wlan delete profile name="eduroam®"
netsh wlan delete profile name="eduroam® via partner"

Start-Sleep -Milliseconds 100

$eduroam_temp = "C:\temp\eduroam.exe"
$dest = "https://cat.eduroam.org/user/API.php?action=downloadInstaller&lang=fr&profile=5886&device=w10&generatedfor=user&openroaming=0"
$proxy = ([System.Net.WebRequest]::GetSystemWebproxy()).GetProxy($dest)

Invoke-WebRequest -Uri $dest -Proxy $proxy -ProxyUseDefaultCredentials -OutFile $eduroam_temp | Wait-Process

Start-Process $eduroam_temp | Wait-Process

netsh wlan set profileparameter name="eduroam®" ConnectionMode=auto
netsh wlan set profileorder name="eduroam®" priority=1 interface="Wi-Fi"
netsh wlan delete profile name="eduroam®" | Out-Null
netsh wlan delete profile name="eduroam® via partner" | Out-Null

netsh wlan show profiles eduroam | Select-String "Nom du SSID[^`"]+`"([^`"]+)`"" | ForEach-Object { $_.Matches.Groups[1].Value }

Start-Sleep -Milliseconds 100

$eduroam = "C:\temp\eduroam.exe"
$dest = "https://cat.eduroam.org/user/API.php?action=downloadInstaller&lang=fr&profile=5886&device=w10&generatedfor=user&openroaming=0"
$proxy = ([System.Net.WebRequest]::GetSystemWebproxy()).GetProxy($dest)

Invoke-WebRequest -Uri $dest -Proxy $proxy -ProxyUseDefaultCredentials -OutFile $eduroam | Wait-Process

Start-Process $eduroam | Wait-Process

netsh wlan set profileparameter name="eduroam®" ConnectionMode=auto
netsh wlan set profileorder name="eduroam®" priority=1 interface="Wi-Fi"
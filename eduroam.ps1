<# [string[]]$netsh = netsh wlan show networks | Select-String -Pattern "SSID" 
$netsh | ForEach-Object {[string]$_.Substring(9, $_.Length-9)} | Where-Object {$_} #>

netsh wlan delete profile name="eduroam®"
netsh wlan delete profile name="eduroam® via partner"

Start-Process .\eduroam.exe


netsh wlan set profileparameter name="eduroam®" ConnectionMode=auto
netsh wlan set profileorder name="eduroam®" priority=1 interface="Wi-Fi"
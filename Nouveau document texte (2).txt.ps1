# =======================================================
# NAME: deployEduroam.ps1
# AUTHOR: Lafarguette Stéphane, D.S.I. Académie de Clermont-Ferrand
# DATE: 17/10/2018
#
# KEYWORDS: windows, ssid, eduroam
# VERSION 0.1
# 27/06/2018 Create script
# TODO : Nothing more
# COMMENTS: Nothing
# Parameters :
# - force, boolean if $true delte eduroam ssid and reload
# Requires -Version 5.0 >
# =======================================================
# Parameters :
# force : boolean
param ($force)

$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition

# Is Wi-Fi present ?
if (Get-NetAdapter | Where-Object {$_.InterfaceType -eq "71"}) {
    # Yes do we force Wi-Fi profile import ?
    if ($force) {
        if ($force -eq $true) {
            # Yes so delete it (present or no don't want to loose time with check)
            netsh wlan delete profile eduroam | Out-Null
        }
    }
    # Is Wi-Fi profile present ?
    if ($(netsh wlan show profile eduroam).Contains("introuvable") -eq $true) {
        netsh wlan add profile filename="$scriptPath\Wi-Fi-eduroam.xml" user=all | Out-Null
    }
}
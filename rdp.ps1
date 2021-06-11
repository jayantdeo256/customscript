$key='HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp'
set-location 'hklm:/'
Set-ItemProperty -Path $key -Name 'PortNumber' -Value 42967
New-NetFirewallRule -DisplayName "Allow RDP1" -Direction Inbound -LocalPort 42967 -Protocol TCP -Action Allow
restart-service -name TermService, SessionEnv,UmRdpService -force

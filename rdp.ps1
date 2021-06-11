mkdir C:\transcript
Start-transcript -Path C:\transcript\transcript.log -Append
$key='HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp'
set-location 'hklm:/'
Set-ItemProperty -Path $key -Name 'PortNumber' -Value 42967
New-NetFirewallRule -DisplayName "Allow RDP1" -Direction Inbound -LocalPort 42967 -Protocol TCP -Action Allow
restart-service -name TermService, SessionEnv,UmRdpService -force

write-host "Adding ad forest"
$domain = jayantdeo.local
$adminForestPassword = 'Test@06112021'
$netBiosName = $domain

net user Administrator (New-Guid).Guid

Install-ADDSForest `
            -CreateDnsDelegation:$false `
            -DatabasePath "C:\Windows\NTDS" `
            -DomainMode "Win2012R2" `
            -ForestMode "Win2012R2" `
            -InstallDns:$true `
            -SysvolPath "C:\Windows\SYSVOL" `
            -DomainName $domain `
            -SafeModeAdministratorPassword $adminForestPassword `
            -DomainNetbiosName $netBiosName `
            -NoRebootOnCompletion `
            -Force

stop-transcript

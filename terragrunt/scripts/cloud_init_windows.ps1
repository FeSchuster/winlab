<powershell>
# update credentials 
net user Administrator "P@ssword"
net user aecid "P@ssword" /add
net localgroup administrators aecid /add

# install ssh server, see https://learn.microsoft.com/en-us/windows-server/administration/openssh/openssh_install_firstuse?tabs=powershell&pivots=windows-server-2022#install-openssh-for-windows-server
Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
Start-Service sshd
Set-Service -Name sshd -StartupType 'Automatic'
if (!(Get-NetFirewallRule -Name "OpenSSH-Server-In-TCP" -ErrorAction SilentlyContinue | Select-Object Name, Enabled)) {
    New-NetFirewallRule -Name 'OpenSSH-Server-In-TCP' -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
}

# set default shell to powershell
New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell -Value "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -PropertyType String -Force

# write public key
$PublicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGXEb4y+yzaaQUaGk6I0Vb5L7NYqLK5l6Mn4Yeu57/8/ felix@Ubuntu" # CHANGE ME
$PublicKey | Out-File -FilePath "C:\ProgramData\ssh\administrators_authorized_keys" -Append -Encoding ascii

# fix administrators_authorized_keys file permissions
icacls "C:\ProgramData\ssh\administrators_authorized_keys" /inheritance:r
icacls "C:\ProgramData\ssh\administrators_authorized_keys" /grant "Administrators:F"
icacls "C:\ProgramData\ssh\administrators_authorized_keys" /grant "SYSTEM:F"
Restart-Service sshd

# disable password authentication
# $file="C:\ProgramData\ssh\sshd_config"
# $find="#PasswordAuthentication yes"
# $replace="PasswordAuthentication no"
# (Get-Content $file).replace($find, $replace) | Set-Content $file
# Restart-Service sshd
</powershell>

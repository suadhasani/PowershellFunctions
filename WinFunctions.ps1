# Removes duplicate environment var entries (requires admin shell) 
function removeEnvDuplicates(){
    $CurrentPath = [Environment]::GetEnvironmentVariable('Path', $env:USERNAME)
    $SplittedPath = $CurrentPath -split ';'
    $CleanedPath = $SplittedPath | Sort-Object -Unique
    $NewPath = $CleanedPath -join ';'
    [Environment]::SetEnvironmentVariable('Path', $NewPath, $env:USERNAME)
}

# Kill process with processID x
function killProcess([string]$process){
    taskkill /f /im $process
}

# Kills Java processes
function killJava(){
    killProcess("jqs.exe")
    killProcess("javaw.exe")
    killProcess("java.exe")
}

# Kills Python processes
function killPython(){
   killProcess("python.exe")
}

# Add IKEV2 VPN Connection
function addIKEV2([string]$vpn){
    Add-VpnConnection -Name "$vpn" -ServerAddress $vpn -AuthenticationMethod Eap -TunnelType Ikev2 -EncryptionLevel Required -RememberCredential
}

# Add L2TP VPN Connection
function addL2TP([string]$vpn){
    Add-VpnConnection -Name "$vpn" -ServerAddress $vpn -AuthenticationMethod MSChapv2, Chap -EncryptionLevel Required -L2tpPsk nordvpn -RememberCredential -TunnelType L2tp
}

# Add PPTP VPN Connection
function addPPTP([string]$vpn){
    Add-VpnConnection -Name "$vpn" -ServerAddress $vpn -RememberCredential -TunnelType PPTP
}
# Add address to hostfile
function addHost ([string]$hosts){
    echo $hosts >> C:\Windows\System32\drivers\etc\hosts
}
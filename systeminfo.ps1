#ip
$name = hostname
$ip = (Get-NetIPAddress -AddressFamily IPv4).IPAddress
$domain = (Get-WmiObject Win32_ComputerSystem).Domain

'
########################################################
#                      MACHINE:                        #'
'HOSTNAME'
$name
''
'DOMAIN'
$domain
''
'IP address'
$ip
'
#                                                      #
########################################################
'

'
########################################################
#                      LOCAL USERS                     #
########################################################
'
#users
net user


'
########################################################
#                      Services                        #
########################################################
'
#Services

#in case powershell be mad
#cmd.exe /c 'sc query'

$serv = get-service | where {$_.Status -eq 'Running'} | sort Name
$serv


'
########################################################
#                      Shares                          #
########################################################
'

net share

'
########################################################
#                      Firewall                        #
########################################################
'

$fire = get-netfirewallprofile
($fire).Enabled

#if powershell big gay
#netsh advfirewall show allprofiles state


$proclist = (get-nettcpconnection | ? {$_.State -eq 'Listen'}).OwningProcess

$tcpcon = @()
$i = 1
foreach ($proc in $proclist) {
    Write-Progress -Activity "TcpConnection" -Status "Filling New Object tcpcon" -PercentComplete (($i / $proclist.Count) * 100)
    $procname = (Get-Process -PID $proc).ProcessName
    $port = (Get-NetTCPConnection | ? {$_.OwningProcess -eq $proc}).LocalPort
    $tcpcon += [PSCustomObject]@{
        'Name' = $procname
        'ProcessId' = $proc
        'Port' = $port
    }
    $i++
}


'
########################################################
#                 Listening Port Info                  #
########################################################
'

$tcpcon | sort Name | ft -AutoSize



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
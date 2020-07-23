#Better netstat mechanism 0.1
#
#
# Name|x| Process|x| Port|x| 
#
# for each process, find port, for each port make object

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


$tcpcon | sort Name | ft -AutoSize

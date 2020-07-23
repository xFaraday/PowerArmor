#powerarmor command execution mechanism 0.1

$cmd = $args[0]
$comp = $args[1]
$user = $args[2]

function CE() {
    $sum = Invoke-command -computername $comp -scriptblock { $cmd = $out } -credential $user 5>&1
    
    return $out
    return $sum
}

Write-output $sum

CE
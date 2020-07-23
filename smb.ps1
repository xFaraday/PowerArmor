
$time = Get-date -Format HH:mm
New-Item -type file $time
$shares = get-smbshare
$shares | out-file -FilePath .\$time

foreach ($share in $shares) {
	remove-smbshare -Name "$share" -Force 
}


stop-process -id $id

binp = (get-process -id $id | Select-Object Path).Path 

remove-item $binp -Force

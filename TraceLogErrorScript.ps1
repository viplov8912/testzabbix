
$logfile = (Get-Content C:\Users\viplov\Documents\testzabbix-master\alert_flexnet.log)
$values = $logfile -match '.*ORA-.*$'



foreach($line in $values) {
    if($line -match '.*ORA-48913.*$' -or $line -match '.*ORA-609.*$' -or $line -match '.*ORA-279.*$'){
       #Write-Output('can be ignored')
       continue
    }else
    
    {
    
       Write-Host($line) >> C:\Users\viplov\Documents\testzabbix-master\output_log.txt
      
    }
}

Write-Host('done!!')
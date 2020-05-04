#fetching timestamp of file last modified
$update_status_file =  gci D:\standby\logs_zabix.txt

$update_status_file_time = $update_status_file.LastWriteTime



#loading the local system date and time
$system_time = Get-Date

#finding the time difference in minutes(timestemp modified file - local itme)
$TimeDifferenceExternalMinutes = [int](NEW-TIMESPAN –Start $update_status_file_time –End $system_time).TotalMinutes
$TimeDifferenceExternalHours = [int](NEW-TIMESPAN –Start $update_status_file_time –End $system_time).TotalHours


#fetching the time-stamp from inside the file and Assigning it to a variable

if([string](Get-Content -path 'D:\standby\logs_zabix.txt') -match '.*generated at ((0[1-9]|1\d|2\d|3[01])\/(0[1-9]|1[0-2])\/(19|20)\d{2} ([0-1]?[0-9]|[2][0-3]):([0-5]?[0-9]):([0-5]?[0-9]))')
{
   $update_status_file_time= $Matches[1]  #storing thr date-time Capturing Group
    
}

else{

Write-Output('Error In Time Script') #printing error if there is a change in Regex or time format.

}




#finding the time difference in minutes(timestemp inside file - local itme)
$TimeDifferenceInternalMinutes = [int](NEW-TIMESPAN –Start $update_status_file_time –End $system_time).TotalMinutes  
$TimeDifferenceInternalHours = [int](NEW-TIMESPAN –Start $update_status_file_time –End $system_time).TotalHours


if ($TimeDifferenceExternalMinutes -lt 60 -and $TimeDifferenceInternalMinutes -lt 60){
    Write-Output("Update Standy Backup Synced Success! Backup last synsed at " + $update_status_file_time )

}

else{

    
    Write-Output("Update Standby Backup failed, file last synced "+ $TimeDifferenceInternalHours+ " Hours ago")
}
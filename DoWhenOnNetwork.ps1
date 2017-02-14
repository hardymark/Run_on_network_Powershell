<#  
Script name: DoWhenOnNetwork.ps1
Script Ver : 1.0

This script checks the current TCP/IP configuration and searches for a specific address 
(typically your default gateway). If it finds that address in the configuration, it does
one action, if not it does another.

Use to launch something in the background when you're on your home network, but not 
elsewhere. Alternatively, you can use this script to kill a process when on a specific
network and then launch again as soon as you're off that network.

Written by: Mark Hardy
            mark.hardy@compucom.com
            (310) 871-2493
            @hardymark

#>

$homegw = '192.168.1.1'
$ProcessName = 'Syncthing'             ## Executable name, DO NOT INCLUDE '.exe'
$ProcessWorkingDir = 'c:\Program Files\Syncthing'
$ProcessArgumentList = '-no-console -no-browser'
$numseconds = 15






$repeat = 'True'
Do {
    $nwINFO = Get-WmiObject -ComputerName '.' Win32_NetworkAdapterConfiguration | select-object *
    $found = 'False'
    foreach ($address in $nwINFO) {
        $straddress = [string]$address
	    if ($straddress.contains("$homegw"))
           {$found='True'}
    }
    $ProcessRunning = Get-Process "$ProcessName" -ErrorAction SilentlyContinue
    if ($found -eq 'True') {
        ## on the desired network
        if (-NOT $ProcessRunning) {
            ## On Network - Process not running
            start-process -Filepath "$ProcessWorkingDir\$ProcessName.exe" -ArgumentList "$ProcessArgumentList" -WorkingDirectory "$ProcessWorkingDir" -WindowStyle Hidden
            
        }
        Else{
            ## On Network, Process running
        }

    }
    Else {
        if ($ProcessRunning) {
            ## Off Network, Process running
            $ProcessRunning | Stop-Process -Force
        }
        Else{
            ## Off Network, Process NOT running
        }

    }


    start-sleep -seconds $numseconds


} 
While ($repeat -eq 'True')







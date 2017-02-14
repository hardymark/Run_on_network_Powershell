# Run_on_network_Powershell
Powershell script to run an executable only when on a certain network


Script name: DoWhenOnNetwork.ps1
Script Ver : 1.0

This script checks the current TCP/IP configuration and searches for a specific address 
(typically your default gateway). If it finds that address in the configuration, it does
one action, if not it does another.

Use to launch something in the background when you're on your home network, but not 
elsewhere. Alternatively, you can use this script to kill a process when on a specific
network and then launch again as soon as you're off that network.

# Created by Emmitt B Houston III on 12/6/2013
# University of Wisconsin Milwaukee
# Desktop Support
#
# This script displays the following information for ARC-C-Print machines:
# Computer Name, IP Address, MAC Address, and Service Tag.
# This information is used to assist in connecting the client to the Captionist's server


function Pause ($Message="Press any key to continue...")
{
Write-Host -NoNewLine $Message
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeydown")
Write-Host ""
}

$computer = "LocalHost" 
$namespace = "root\cimv2" 
$ComputerName = gwmi win32_networkadapterconfiguration|where {$_.IPEnabled -eq "True"}|select -expandproperty DNSHostname
$IpAddress = gwmi Win32_NetworkAdapterConfiguration -filter 'IPEnabled=True'|select -expandproperty IPAddress|Where {$_ -notmatch ':'}
$MacAddress = gwmi -namespace $namespace -class win32_networkadapter -computername $computer|where {$_.NetEnabled -eq 'True'}|select -expandproperty macaddress
$AdapterType = gwmi -namespace $namespace -class win32_networkadapter -computername $computer|where {$_.NetEnabled -eq 'True'}|select -expandproperty NetConnectionID
$ServiceTag = gwmi -namespace $namespace -class Win32_ComputerSystemProduct -computername $computer| select -expandproperty IdentifyingNumber

Write-Host "Computer Information              "
Write-Host "----------------------------------"
Write-Host "Computer Name : $ComputerName     `n"
Write-Host "Adapter Type  : $AdapterType      `n"
Write-Host "IP Address    : $IpAddress        `n"
Write-Host "MAC Address   : $MacAddress       `n"
Write-Host "Service Tag   : $ServiceTag"
Write-Host "----------------------------------"

Pause
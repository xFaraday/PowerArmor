"					
				   _.--.    .--._
				 ."  ."      ".  ".
                ;  ."    /\    ".  ;
                ;  '._,-/  \-,_.`  ;			Powerarmor v0.1
                \  ,`  / /\ \  `,  /			
                 \/    \/  \/    \/				Ethan Michalak
                 ,=_    \/\/    _=,
                 |  "_   \/   _"  |		 Powershell remote framework
                 |_   '"-..-"'   _|
                 | "-.        .-" |
                 |    "\    /"    |
                 |      |  |      |
         ___     |      |  |      |     ___
     _,-",  ",   '_     |  |     _'   ,"  ,"-,_
   _(  \  \   \"=--"-.  |  |  .-"--="/   /  /  )_
 ,"  \  \  \   \      "-'--'-"      /   /  /  /  ".
!     \  \  \   \                  /   /  /  /     !
:      \  \  \   \                /   /  /  /      :
"

function Invoke-PA 
{
<#
.SYNOPSIS

This script aims at lowering secure time of incident response teams by allowing mass deployment
of powershell commands or other prewritten functions. 
Uses WinRM to open up sessions on specified IPs or hosts.

.DESCRIPTION

.PARAMETER ComputerName

Computers that are targeted.

.PARAMETER Inventory

Switch: Collects inventory in text files

.PARAMETER Custom

Custom command override.

.EXAMPLE

Grab detailed systeminfo off of supplied IPs
Invoke-PA -Inventory -ComputerName @("172.168.2.3", "172.168.2.4")

#>

[CmdletBinding(DefaultParameterSetName="default")]
Param(
	[Parameter(Position = 0)]
	[String[]]
	$ComputerName,

	[Parameter(Position = 1)]
	[Switch]
	$Inventory,

	[Parameter(Position = 2)]
	[Switch]
	$Services,

	[Parameter(Position = 3)]
	[Switch]
	$smb,

	[Parameter(Position = 3)]
	[Switch]
	$registry,

	[Parameter(Position = 2)]
	[String[]]
	$pkill

	[Parameter(Position = 2)]
	[String[]]
	$Custom	
)

	$a = @()
#Add lockdown, web, and other functions
#
#
#
	if($Inventory -eq $true) {
		$inventory = 'inventory.ps1'
		$a += $inventory
		} else if ($Services -eq $true) {
			$service = 'service.ps1'
			$a += $service
			} else if ($smb -eq $true) {
				$Smb = 'smb.ps1'
				$a += $Smb
				} else if ($registry -eq $true) {
					$Registry = 'registry.ps1'
					$a += $Registry
					} else if ($tcpconnections -eq $true) {
						$TCPconnections = 'tcpconnections.ps1'
						$a += $TCPconnections
						} else if ($gpupdate -eq $true) {
							$GPupdate = 'gpupdate.ps1'
							$a += $GPupdate
							} else {

							}


	



	foreach ($script in $a) {
		$path =  (resolve-path .\$script).Path
		Invoke-command -computername $ComputerName -FilePath $path 
	}


}



Invoke-PA

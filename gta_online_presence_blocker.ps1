#Requires -RunAsAdministrator

param (
  [string]$Title = 'GTA:O Presence Blocker'
)
Write-Host "================ $Title ================"
Write-Host "T: Type 'T' to Enable Presence Block"
Write-Host "F: Type 'F' to Disable Presence Block`n"

do {
  $selection = Read-Host "Please make a selection"
  switch ($selection) {
    'T' {
      New-NetFirewallRule -DisplayName "gta_online_presence" `
        -Direction Outbound `
        -LocalPort 61455, 61456, 61457, 61458 `
        -Protocol UDP `
        -Action Block | out-null
      'Presence Block Enabled'
    } 'F' {
      $r = Get-NetFirewallRule -DisplayName 'gta_online_presence'  2> $null;
      if ($r) {
        Remove-NetFirewallRule -DisplayName "gta_online_presence" | out-null
        'Presence Block Disabled'
      }
      else {
        write-host "Presence Block already disabled!"
      }
    }
  }
}
until ($selection -eq 'q')
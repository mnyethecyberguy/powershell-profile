<#
Author:		    Michael Nye
Script Name:    Microsoft.PowerShell_profile.ps1
Version:        1.1
Description:    Script contains PowerShell profile that can be used on Windows or macOS
Change Log:	    v1.0: Initial Release
                v1.1: Added prompt function
Notes:          Windows CurrentUserCurrentHost profile location ($PROFILE): C:\Users\<user>\Documents\PowerShell\Microsoft.PowerShell_profile.ps1
                MacOS profile location: /Users/<user>/.config/powershell/Microsoft.PowerShell_profile.ps1
#>

# Customize PS Prompt
# Similar to Ubuntu prompt - user@computer:<pwd>$
# 'user@computer in bold green, pwd in bold blue. Computername in lower case. Replaces $home with '~'.
Function Prompt {
    if ($IsWindows) {
        "$($PSStyle.Foreground.Green)$($PSStyle.Bold)$env:USERNAME@$($env:COMPUTERNAME.ToLower())$($PSStyle.Reset):$($PSStyle.Foreground.Blue)$($PSStyle.Bold)$($(Get-Location).Path.replace($home,'~'))$($PSStyle.Reset)$ "
        # This line can be used instead if you need the ANSI escape sequences.  $PSStyle was added in PowerShell 7.2
        #"`e[32m`e[1m$env:USERNAME@$($env:COMPUTERNAME.ToLower())`e[0m:`e[34m`e[1m$($(Get-Location).Path.replace($home,'~'))`e[0m$ "
    }
    elseif ($IsMacOS) {
        # These lines can be used on macOS where environment variables are different than Windows
        "$($PSStyle.Foreground.Green)$($PSStyle.Bold)$env:USER@$($(hostname).ToLower().replace(".local",''))$($PSStyle.Reset):$($PSStyle.Foreground.Blue)$($PSStyle.Bold)$($(Get-Location).Path.replace($home,'~'))$($PSStyle.Reset)$ "
        #"`e[32m`e[1m$env:USER@$($(hostname).ToLower().replace(".local",''))`e[0m:`e[34m`e[1m$($(Get-Location).Path.replace($home,'~'))`e[0m$ "
    }    
}
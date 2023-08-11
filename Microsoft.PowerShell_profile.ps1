<#
Author:		    Michael Nye
Script Name:    Microsoft.PowerShell_profile.ps1
Version:        1.1
Description:    Script contains PowerShell profile that can be used on Windows or macOS
Change Log:	    v1.0: Initial Release
                v1.1: Added prompt function
                v1.2: Added AWS CLI auto complete
                v1.3: Added parsing git branch to prompt for Windows
Notes:          Windows CurrentUserCurrentHost profile location ($PROFILE): C:\Users\<user>\Documents\PowerShell\Microsoft.PowerShell_profile.ps1
                MacOS profile location: /Users/<user>/.config/powershell/Microsoft.PowerShell_profile.ps1
#>

# Customize PS Prompt
# Similar to Ubuntu prompt - user@computer:<pwd> (git branch)$
# 'user@computer in bold green, pwd in bold blue. Computername in lower case. Replaces $home with '~'.
Function Prompt {
    if ($IsWindows) {
        $gitbranch = Get-GitBranch
        if ($gitbranch) {
            "$($PSStyle.Foreground.Green)$($PSStyle.Bold)$env:USERNAME@$($env:COMPUTERNAME.ToLower())$($PSStyle.Reset):$($PSStyle.Foreground.Blue)$($PSStyle.Bold)$($(Get-Location).Path.replace($home,'~')) ($($gitbranch))$($PSStyle.Reset)$ "
            # This line can be used instead if you need the ANSI escape sequences.  $PSStyle was added in PowerShell 7.2
            #"`e[32m`e[1m$env:USERNAME@$($env:COMPUTERNAME.ToLower())`e[0m:`e[34m`e[1m$($(Get-Location).Path.replace($home,'~'))`e[0m$ "
        }
        else {
            "$($PSStyle.Foreground.Green)$($PSStyle.Bold)$env:USERNAME@$($env:COMPUTERNAME.ToLower())$($PSStyle.Reset):$($PSStyle.Foreground.Blue)$($PSStyle.Bold)$($(Get-Location).Path.replace($home,'~'))$($PSStyle.Reset)$ "
            # This line can be used instead if you need the ANSI escape sequences.  $PSStyle was added in PowerShell 7.2
            #"`e[32m`e[1m$env:USERNAME@$($env:COMPUTERNAME.ToLower())`e[0m:`e[34m`e[1m$($(Get-Location).Path.replace($home,'~'))`e[0m$ "
        }
    }
    elseif ($IsMacOS) {
        # These lines can be used on macOS where environment variables are different than Windows
        "$($PSStyle.Foreground.Green)$($PSStyle.Bold)$env:USER@$($(hostname).ToLower().replace(".local",''))$($PSStyle.Reset):$($PSStyle.Foreground.Blue)$($PSStyle.Bold)$($(Get-Location).Path.replace($home,'~'))$($PSStyle.Reset)$ "
        #"`e[32m`e[1m$env:USER@$($(hostname).ToLower().replace(".local",''))`e[0m:`e[34m`e[1m$($(Get-Location).Path.replace($home,'~'))`e[0m$ "
    }    
}

# Auto complete for AWS CLI
Register-ArgumentCompleter -Native -CommandName aws -ScriptBlock {
    param($commandName, $wordToComplete, $cursorPosition)
        $env:COMP_LINE=$wordToComplete
        if ($env:COMP_LINE.Length -lt $cursorPosition){
            $env:COMP_LINE=$env:COMP_LINE + " "
        }
        $env:COMP_POINT=$cursorPosition
        aws_completer.exe | ForEach-Object {
            [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
        }
        Remove-Item Env:\COMP_LINE     
        Remove-Item Env:\COMP_POINT  
}

# Parse git branch to add to prompt
function Get-GitBranch {
    return git branch --show-current
}
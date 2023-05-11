# PowerShell Profile
This PowerShell profile can be used on Windows or MacOS running PowerShell v7.2 or greater.

## Profile Paths
I personally place this profile in the CurrentUserCurrentHost profile location for personal use.
- Windows: C:\Users\\<user>\Documents\PowerShell\Microsoft.PowerShell_profile.ps1
- MacOS: /Users/\<user>/.config/powershell/Microsoft.PowerShell_profile.ps1

## Prompt Function
This can be customized to suit your needs/preferences.  I like the look and feel of the Ubuntu prompt so this mimics that formatting.  I included lines for both the newer capabilities for $PSStyle, which comes with PowerShell 7.2+, and for using standard legacy ANSI escape characters.  Both work for each platform.
![PoshCcat](https://img.shields.io/powershellgallery/v/PoshCCat.svg?include_prerelease "0.0.2")
# PoshCCat
## Description
Like oh-my-zsh colorize allow to have a colorized version of get-content. Currently, we can colorize CSV File and LogFiles.
- CSV : Rainbow CSV, Round-robin color
- Log : Highligth patterns
    - Date and Time
    - Hexadecimal words
    - Paths
    - Error and Warning Keywords
    - IPv4 addresses
    - Windows SID
    - GuID
- Ini and Inf Files
- Outlook prf Files
- Citrix ICA Files
- Microsoft Registry Files
- Services and Hosts Files
- Unix Config File with or without block

## Installation

Copy and Paste the following command to install this package using PowerShellGet

`Install-Module -Name PoshCCat`

## usage

`Get-ColorizeContent -Path Path/to/file`    
`ccat Path/to/file`

## Changelog
- 20201228 v0.0.2-beta
    * Error when csv start with a comment
    * Error when trying to access file on a share
- 20201223 v0.0.1-beta
- 20201219 Initial Draft


######################################################################
# Analyze                                                            #
######################################################################
# No report                                                          #
######################################################################


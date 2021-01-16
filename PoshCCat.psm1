#requires -Modules Pansies
######################################################################
# Module : PoshCCat.psm1                                             #
######################################################################
# Description : contains main function and utilities                 #
#                                                                    #  
######################################################################
# Changelog :                                                        # 
# 20201218 Initial realease                                          # 
######################################################################
# Note / TODO and FIXME                                              #
# TODO: Guess delimiter in CsvColor function DONE/                   #
# TODO: Add Guess File content, file Type function                   # 
# TODO: USe CmdLet Binding DONE/ (Almost)                            # 
# TODO: should add uri in path                                       # 
# FIXME: Comment can be colorize with content highlighting FIXED/    #
# TODO: Rename "IniColors" to ConfigurationColors                    #
# TODO: Trace text parameters DONE/                                  #
# TODO: TraceText HAsh Validation                                    #
# TODO: TraceText should be first action                             #  
# FIXME: CSV can start with comment FIXED/                           # 
######################################################################

######################################################################
# Module Variables                                                   #
######################################################################

#$CSVColors = @("Blue", "Green", "Red", "Yellow", "Orange")
#$CSVDelimColor = "Purple"
#$LogColors = @{
#    DateTimeFrontColor = "Blue"
#    ErrorFrontColor    = "Red"
#    WarningFrontColor  = "Yellow"
#    HexWordFrontColor  = "Green"
#    SIDFrontColor      = "LightGreen"
#    GuIDFrontColor     = "DarkGreen"
#    IPv4FrontColor     = "Orange"
#}
#$ConfigurationColors = @{
#    CommentFrontColor  = "Blue"
#    SectionFrontColor  = "Green"
#    VariableFrontColor = "LightGreen"
#    ValueFrontColor    = "darkOrange"
#}
#$HostColors = @{
#    CommentFrontColor = "Blue"
#    IpV4FrontColor    = "LightGreen"
#    HostFrontColor    = "darkOrange"
#    ServiceFrontColor = "darkorange"
#    AliasFrontColor   = "darkORange"
#    PortFrontColor    = "lightGreen"
#    ProtoFrontColor   = "lightGreen"
#}
$CCatColors = @{
    CSV                 = @("Blue", "Green", "Red", "Yellow", "Orange")
    CSVDelimColor       = "Purple"
    LogColors           = @{
        DateTimeFrontColor = "Blue"
        ErrorFrontColor    = "Red"
        WarningFrontColor  = "Yellow"
        HexWordFrontColor  = "Green"
        SIDFrontColor      = "LightGreen"
        GuIDFrontColor     = "DarkGreen"
        IPv4FrontColor     = "Orange"
    }
    ConfigurationColors = @{
        CommentFrontColor  = "Blue"
        SectionFrontColor  = "Green"
        VariableFrontColor = "LightGreen"
        ValueFrontColor    = "darkOrange"
    }
    HostColors          = @{
        CommentFrontColor = "Blue"
        IpV4FrontColor    = "LightGreen"
        HostFrontColor    = "darkOrange"
        ServiceFrontColor = "darkorange"
        AliasFrontColor   = "darkORange"
        PortFrontColor    = "lightGreen"
        ProtoFrontColor   = "lightGreen"
    }
}

######################################################################
# Functions                                                          #
######################################################################

function Get-ColorizedContent {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true,
            ValueFromPipeline = $true)]
        [ValidateScript( {
                if ( (Test-Path $_ | ? { $_ -ne $true } -GT 0)) {
                    Throw [System.IO.FileNotFoundException]
                } else {
                    return $true
                }
            })]
        [string[]]$Path,
        [hashtable][ValidateScript( {
                $(diff @($_.Keys) @('Object', 'BackgroundColor', 'ForegroundColor') -PassThru).Count -eq 0
            }) ]$TraceText
    )
    process {
        [System.IO.FileInfo]$File = Convert-Path (Resolve-Path  $Path).Path
        $return = @()
        if ($File.Extension -eq '.csv') {
            $return = CsvColor -FilePath $File
        } elseif ( $File.Extension -eq '.log') {
            $return = LogColor -FilePath $File
        } elseif ( $File.Extension -eq '.ini' -or $File.Extension -eq '.inf' -or $File.Extension -eq '.ica' -or $File.Extension -eq '.prf' -or $File.Extension -eq '.cmw') {
            $return = IniColor -FilePath $File
        } elseif ( $File.Extension -eq '.conf' -or $File.Extension -eq '.cfg') {
            $return = ConfigFileColor -FilePath $File
        } elseif ( $File.Extension -eq '.reg') {
            $return = RegistryFileColor -FilePath $File
        } elseif ($File.FullName -eq 'C:\WINDOWS\System32\drivers\etc\hosts') {
            $return = HostColor -FilePath $File
        } elseif ($File.FullName -eq 'C:\WINDOWS\System32\drivers\etc\services') {
            $return = ServiceColor -FilePath $File
        } else {
            $return = Get-Content -Path $File
        }
        if ($TraceText) {
            $return = TraceText $return $TraceText
        }
        return $return
    }

    <# 
    .SYNOPSIS
    Return coloriezd content of a file

    .DESCRIPTION
    Return a colorized version of a file, can be use as a pipeline. support formats "ini" and cfg unix    

    .PARAMETER FilePath
    Path of the file to be returned

    .EXAMPLE
    Get-ColorizedContent -FilePath $env:windir\system32\drivers\etc\services

    .EXAMPLE
    ccat $env:windir\system32\drivers\etc\services

    .LINK
    https://gitub.com/belotn/poshCCat

#>
}

######################################################################
# function CsvColor                                                  #
######################################################################
# Description : Format CSV based on csv color array                  # 
######################################################################

function CsvColor {
    param(
        [string]$FilePath
    )
    $CSVColors = $CCatColors.CSV
    $CSVDelimColor = $CCatColors.CSVDelim
    $MaxColor = $CSVColors.Count
    $Delimiter = ((Get-Content -Path $FilePath | ? { $_ -notlike '#*' })[0].ToCharArray() | group | ? { ":", ";", ",", "`t" -contains $_.Name } | sort Count | select -First 1 ).Name
    $csv = Import-Csv -delim $Delimiter -Path $FilePath 
    #header
    $i = 0
    @($csv[0].psobject.Properties.Name | % { $i++; New-Text $_ -ForegroundColor $CSVColors[$i % $MaxColor] -LeaveColor } ) -join (New-Text $Delimiter  -ForegroundColor $CSVDelimColori -LeaveColor)
    $csv | % {
        $i = 0
        @($_.psobject.Properties.Value | % { $i++; New-Text $_ -ForegroundColor $CSVColors[$i % $MaxColor] -LeaveColor } ) -join (New-Text $Delimiter -ForegroundColor $CSVDelimColor -LeaveColor)
    }
}

######################################################################
# function LogColor                                                  #
######################################################################
# Description : Format Log File based on Logcolors Hash              # 
######################################################################

function LogColor {
    param(
        [string]$FilePath
    )
    $LogColors = $CCatColors.LogColors
    $DateRegexp = "(\d{1,2}[/\- ]\d{1,2}[/\- ]\d{2,4}|20\d{6}|\d{2,4}[/\- ]\d{1,2}[/\- ]\d{1,2}|\d{2}-\w{3}-\d{4})"
    $TimeRegexp = "(\d{1,2}[:]\d{1,2}[:]\d{1,2}\.?\d*)"
    $HexWordRegexp = "(?<HexWord>0x[0-9a-eA-E]{4,8})"
    $PathRegexp = "(?<Before>\W)(?<Path>(\w:[/\\]?|\\\\|//)[\w\\/\- \.$]+(\.[\w]+)?)"
    $SIDRegex = "(?<SID>S-\d-(?:\d+-){1,14}\d+)"
    $GuIDRegex = "(?<GUID>[A-Z0-9]{8}-([A-Z0-9]{4}-){3}[A-Z0-9]{12})"
    $IPv4Regex = "(?<IPV4>([^1-9.][1-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3} )"
    Get-Content $FilePath | % {
        $line = $_
        if ( $_ -match $DateRegexp) { 
            $matches.Values | group | % {
                $line = $line.replace($_.Name, (New-Text -ForegroundColor $LogColors.DateTimeFrontColor -Object $_.Name ).toString() )
            }
        }
        if ( $_ -match $TimeRegexp) { 
            $matches.Values | group | % {
                $line = $line.replace($_.Name, (New-Text -ForegroundColor $LogColors.DateTimeFrontColor -Object $_.Name ).toString() )
            }
        }
        $line = $line -replace $HexWordRegexp, (New-Text '${HexWord}' -ForegroundColor $LogColors.HexWordFrontColor ).toString()
        $line = $line -replace $PathRegexp, ('${Before}' + (New-UnderlineText '${Path}' ))
        $line = $line -replace $SIDRegex, (New-Text '${SID}' -ForegroundColor $logColors.SIDFrontColor )
        $line = $line -replace $GuIDRegex, (New-Text '${GUID}' -ForegroundColor $logColors.GuIDFrontColor )
        $line = $line -replace $IPv4Regex, (New-Text '${IPV4}' -ForegroundColor $logColors.IPv4FrontColor )
        $line = $line -replace "(?<Match>Error)", (New-Text '${Match}' -ForegroundColor $LogColors.ErrorFrontColor ).toString()
        $line = $line -replace "(?<Match>Warning)", (New-Text '${Match}' -ForegroundColor $Logcolors.WarningFrontColor ).toString()
        $line
    }
}
######################################################################
# function IniColor                                                  #
######################################################################
# Description : Format Ini File based on Inicolors Hash              # 
######################################################################

function IniColor {
    param(
        [string]$FilePath
    )
    $ConfigurationColors = $CCatColors.ConfigurationColors
    $CommentRegexp = "(?<Comment>[#;].*)$"
    $SectionRegexp = "(?<Section>\[[^]]+\])"
    $VariableValueRegexp = "(?<Variable>[\w.*%$-]+\s*)=(?<Value>\s*[^;#]*)" #"(?<Variable>[\w+.\-*]\s*)=(?<Value>\s*[^;#]+)"
    Get-Content $FilePath | % {
        $line = $_
        $line = $line -replace $CommentRegexp, (New-Text '${Comment}' -ForegroundColor $ConfigurationColors.CommentFrontColor).toString()
        $line = $line -replace $SectionRegexp, (New-Text '${Section}' -ForegroundColor $ConfigurationColors.SectionFrontColor).toString()
        $line = $line -replace $VariableValueRegexp, ((New-Text '${Variable}' -ForegroundColor $ConfigurationColors.VariableFrontColor).toString() + '=' + (New-Text '${Value}' -ForegroundColor $ConfigurationColors.ValueFrontColor).tostring() )
        $line
    }
}

######################################################################
# function HostColor                                                 #
######################################################################
# Description : Format Host File based on Inicolors Hash             # 
######################################################################
function HostColor {
    param(
        [string]$FilePath
    )
    $HostColors = $CCatColors.HostColors
    $CommentRegexp = "(?<Comment>#.*$)"
    $HostRegexp = "(?<IPV4>^\s*([1-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3})(?<Hostname>\s+.*)"
    Get-Content $FilePath -Encoding UTF8 | % {
        $line = $_
        $line = $line -replace $CommentRegexp, (New-Text '${Comment}' -ForegroundColor $HostColors.CommentFrontColor).toString()
        if ( $line.length -gt 0 -and $line.substring(0, 1) -ne '#') {
            $line = $line -replace $HostRegexp, ((New-Text '${IPV4}' -ForegroundColor $HostColors.IPv4FrontColor).ToString() + (New-Text '${Hostname}' -ForegroundColor $HostColors.HostFrontColor).toString() )
        }
        $line
    }
}
######################################################################
# function ServiceColor                                              #
######################################################################
# Description : Format Service File based on Inicolors Hash          # 
######################################################################
function ServiceColor {
    param(
        [string]$FilePath
    )
    $HostColors = $CCatColors.HostColors
    $ServiceRegexp = "(?<Service>[\w\-]+\s+)(?<Port>\d+)(?<Proto>/(tcp|udp))(?<Alias>\s*[\w \-]*)"
    $CommentRegexp = "(?<Comment>#.*$)"
    Get-Content $FilePath -Encoding UTF8 | % {
        $line = $_
        $line = $line -replace $CommentRegexp, (New-Text '${Comment}' -ForegroundColor $HostColors.CommentFrontColor).toString()
        $line = $line -replace $ServiceRegexp, ((New-Text '${Service}' -ForegroundColor $HostColors.ServiceFrontColor).toString() + (New-Text '${Port}' -ForegroundColor $HostColors.PortFrontColor).toString() + (New-Text '${Proto}' -ForegroundColor $HostColors.ProtoFrontColor).toString() + (New-Text '${Alias}' -ForegroundColor $HostColors.AliasFrontColor).toString())
        $line
    }
}

######################################################################
# function ConfigFileColor                                           #
######################################################################
# Description : Format Service File based on Inicolors Hash          # 
######################################################################
function ConfigFileColor {
    param(
        [string]$FilePath
    ) 
    $ConfigurationColors = $CCatColors.ConfigurationColors 
    $CommentRegexp = "(?<Comment>#.*)"
    $SectionRegexp = "(?<Section>^\w+$)"
    $AssignRegexp = "(?<Name>^\s*[\w-]+)(?<Value>\s+[^#]+)"
    $BlockStartRegexp = "(?<Start>^\s*\w+\s*{)"
    $BlockStopRegexp = "(?<Stop>})"
    Get-Content $FilePath | % {
        $line = $_
        $line = $line -replace $CommentRegexp, (New-Text '${Comment}' -ForegroundColor $ConfigurationColors.CommentFrontColor).ToString()
        $line = $line -replace $SectionRegexp, (New-Text '${Section}' -ForegroundColor $ConfigurationColors.SectionFrontColor).ToString()
        $line = $line -replace $AssignRegexp, ((New-Text '${Name}' -ForegroundColor $ConfigurationColors.VariableFrontColor).ToString() + (New-Text '${Value}' -ForegroundColor $ConfigurationColors.ValueFrontColor).toString() )
        $line = $line -replace $BlockStartRegexp, (New-Text '${Start}' -ForegroundColor $ConfigurationColors.SectionFrontColor).ToString()
        $line = $line -replace $BlockStopRegexp, (New-Text '${Stop}' -ForegroundColor $ConfigurationColors.SectionFrontColor).ToString()
        $line
    }
}

######################################################################
# function RegistryFileColor                                         #
######################################################################
# Description : Format Registry File based on Regcolors Hash         # 
######################################################################
function RegistryFileColor {
    param(
        [string]$FilePath
    )
    $ConfigurationColors = $CCatColors.ConfigurationColors 
    $KeyRegexp = "(?<Key>^\[[^\]]+\])"
    $PropertyRegexp = '(?<Name>"?\w+"?)=(?<type>(dword|hex|hex\(2\)):)?(?<Value>"?[^"]*"?)'
    $MultiLineRegexp = "(?<Value>^\s.+)"
    Get-Content $FilePath | % {
        $line = $_
        $line = $line -replace $KeyRegexp, (New-Text '${Key}' -ForegroundColor $ConfigurationColors.SectionFrontColor).toString()
        $line = $line -replace $PropertyRegexp, ((New-Text '${Name}' -ForegroundColor $ConfigurationColors.VariableFrontColor).toString() + '=' + (New-Text '${type}' -ForegroundColor $ConfigurationColors.SectionFrontColor).toString() + (New-Text '${Value}' -ForegroundColor $ConfigurationColors.ValueFrontColor).toString())
        $line = $line -replace $MultiLineRegexp, (New-Text '${Value}' -ForegroundColor $ConfigurationColors.ValueFrontColor).toString()
        $line
    }
}
######################################################################
# function New-UnderlineText                                         #
######################################################################
# Description : Like PAnsies New-Text but to print underline one     #
######################################################################
function New-UnderlineText {
    param(
        [string]$text
    )
    return "$([char]27)[4m$text$([char]27)[24m"
}
######################################################################
# function TraceText                                                 #
######################################################################
# Description : Highligth some keyword                               #
######################################################################

function TraceText {
    param(
        [string[]]$Content,
        [hashtable]$TraceText
    )
    $return = $Content | % {
        $_ -replace $TraceText.Object, (New-Text @TraceText).toString()
    }
    $return
}

######################################################################
# function Set-CCarColor                                             #
######################################################################
# Description : Configure your own colors... to be written           #
######################################################################

function Set-CCatColors {
    param(
        [string[]]$CSVColors
    )
    if ($CSVColors) {
        $CCatColors.CSV = $CSVColors
    }
    if ($CSVDelimColor) {
        $CCatColors.CSVDelimColor = $CSVDelimColor
    }
    if ($ConfigurationColors) {
        $CCatColors.ConfigurationColors = $ConfigurationColors
    }
    if ($LogColors) {
        $CCatColors.LogColors = $LogColors
    }
    if ($HostColors) {
        $CCatColors.HostColors = $HostColors
    }
}

function Get-CcatColors {
    $CcatColors
}
Set-Alias -Name "ccat" -Value "Get-ColorizedContent"
Export-ModuleMember -Function "Get-ColorizedContent", "Set-CcatColors", "Get-CcatColors" -Alias "ccat"

######################################################################
# Analyze                                                            #
######################################################################
# PSAvoidUsingCmdletAliases occured 21                               #
# PSReviewUnusedParameter occured 1                                  #
# PSUseShouldProcessForStateChangingFunctions occured 2              #
# PSUseSingularNouns occured 2                                       #
######################################################################


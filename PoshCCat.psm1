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
######################################################################

$CSVColors = @("Blue","Green","Red","Yellow","Orange")
$CSVDelimColor = "Purple"
$LogColors = @{
    DateTimeFrontColor = "Blue"
    ErrorFrontColor = "Red"
    WarningFrontColor = "Yellow"
    HexWordFrontColor = "Green"
    SIDFrontColor = "LightGreen"
    GuIDFrontColor = "DarkGreen"
    IPv4FrontColor = "Orange"
}

function Get-ColorizedContent {
    param(
        [Parameter(Mandatory = $true)]
        [ValidateScript({
            if( (Test-Path $_ |? { $_ -ne $true} -gt 0)){
                Throw [System.IO.FileNotFoundException]
            }else{
                return $true
            }
        })]
        [string[]]$Path
    )
    [System.IO.FileInfo]$File = (Resolve-Path  $Path).Path
    if($File.Extension -eq '.csv'){
        return CsvColor -FilePath $File
    } elseif( $File.Extension -eq '.log') {
        return LogColor -FilePath $File
    }else {
        return Get-Content -path $File
    }
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
    $MaxColor = $CSVColors.Count
    $Delimiter =  ((Get-Content -Path $FilePath)[0].ToCharArray() | group |? { ":",";",",","`t" -contains $_.Name } | sort Count | select -first 1 ).Name
    $csv  = import-csv -delim $Delimiter -Path $FilePath 
    #header
    $i=0
    @($csv[0].psobject.Properties.Name |% { $i++; New-Text $_ -ForegroundColor $CSVColors[$i%$MaxColor] -LeaveColor} ) -join (new-text $Delimiter  -ForegroundColor $CSVDelimColori -LeaveColor)
    $csv |% {
        $i=0
        @($_.psobject.Properties.Value |% { $i++; New-Text $_ -ForegroundColor $CSVColors[$i%$MaxColor] -LeaveColor } ) -join (new-text $Delimiter -ForegroundColor $CSVDelimColor -LeaveColor)
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
    $DateRegexp = "(\d{1,2}[/\- ]\d{1,2}[/\- ]\d{2,4}|20\d{6}|\d{2,4}[/\- ]\d{1,2}[/\- ]\d{1,2}|\d{2}-\w{3}-\d{4})"
    $TimeRegexp = "(\d{1,2}[:]\d{1,2}[:]\d{1,2}\.?\d*)"
    $HexWordRegexp = "(?<HexWord>0x[0-9a-eA-E]{4,8})"
    $PathRegexp = "(?<Before>\W)(?<Path>(\w:[/\\]?|\\\\|//)[\w\\/\- \.$]+(\.[\w]+)?)"
    $SIDRegex = "(?<SID>S-\d-(?:\d+-){1,14}\d+)"
    $GuIDRegex = "(?<GUID>[A-Z0-9]{8}-([A-Z0-9]{4}-){3}[A-Z0-9]{12})"
    $IPv4Regex = "(?<IPV4>([^1-9.][1-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3} )"
    Get-Content $FilePath |% {
        $line = $_
        if( $_ -match $DateRegexp){ 
            $matches.Values | group |% {
                $line = $line.replace($_.Name, (New-Text -ForegroundColor $LogColors.DateTimeFrontColor -Object $_.Name ).toString() )
            }
        }
        if( $_ -match $TimeRegexp){ 
            $matches.Values | group |% {
                $line = $line.replace($_.Name, (New-Text -ForegroundColor $LogColors.DateTimeFrontColor -Object $_.Name ).toString() )
            }
        }
        $line = $line -replace $HexWordRegexp,(new-text '${HexWord}' -ForegroundColor $LogColors.HexWordFrontColor ).toString()
        $line = $line -replace $PathRegexp,('${Before}' + (New-UnderlineText '${Path}' ))
        $line = $line -replace $SIDRegex, (new-text '${SID}' -ForegroundColor $logColors.SIDFrontColor )
        $line = $line -replace $GuIDRegex, (new-text '${GUID}' -ForegroundColor $logColors.GuIDFrontColor )
        $line = $line -replace $IPv4Regex, (new-text '${IPV4}' -ForegroundColor $logColors.IPv4FrontColor )
        $line = $line -replace "(?<Match>Error)",(new-text '${Match}' -ForegroundColor $LogColors.ErrorFrontColor ).toString()
        $line = $line -replace "(?<Match>Warning)",(new-text '${Match}' -ForegroundColor $Logcolors.WarningFrontColor ).toString()
        $line
    }
}

function New-UnderlineText {
    param(
        [string]$text
    )
    return "$([char]27)[4m$text$([char]27)[24m"
}

Export-ModuleMember -Function "Get-ColorizedContent"
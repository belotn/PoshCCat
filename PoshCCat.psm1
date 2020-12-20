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
# TODO: Guess delimiter in CsvColor function                         #
# TODO: Add Guess File content, file Type function                   # 
######################################################################

$CSVColors = @("Blue","Green","Red","Yellow","Orange")
$CSVDelimColor = "Purple"
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
    } else {
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
    $csv  = import-csv -delim ';' -Path $FilePath 
    #header
    $i=0
    @($csv[0].psobject.Properties.Name |% { $i++; New-Text $_ -ForegroundColor $CSVColors[$i%$MaxColor] -LeaveColor} ) -join (new-text ';' -ForegroundColor $CSVDelimColori -LeaveColor)
    $csv |% {
        $i=0
        @($_.psobject.Properties.Value |% { $i++; New-Text $_ -ForegroundColor $CSVColors[$i%$MaxColor] -LeaveColor } ) -join (new-text ';' -ForegroundColor $CSVDelimColor -LeaveColor)
    }
}

Export-ModuleMember -Function "Get-ColorizedContent"
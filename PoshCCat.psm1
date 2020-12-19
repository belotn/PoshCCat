######################################################################
# Module : PoshCCat.psm1                                             #
######################################################################
# Description : contains main function and utilities                 #
#                                                                    #  
######################################################################

$CSVColors = @("Blue","Green","Red","Yellow","Orange")
$CSVDelimColor = "Purple"
function Get-ColorizedContent {
    param(
        [string]$FilePath
    )
    $file = get-item $FilePath
    if($file.Extension -eq '.csv'){
        return CsvColor -FilePath $FilePath
    } else {
        return Get-Content -path $FilePath
    }
}

######################################################################
# function CsvColor                                                  #
######################################################################
# TODO: Guess Delim                                                  #
######################################################################

function CsvColor {
    param(
        [string]$FilePath
    )
   $csv  = import-csv -delim ';' -Path $FilePath 
   #header
   $i=0
   @($csv[0].psobject.Properties.Name |% { $i++; New-Text $_ -ForegroundColor $CSVColors[$i%5] -LeaveColor} ) -join (new-text ';' -ForegroundColor $CSVDelimColori -LeaveColor)
   $csv |% {
    $i=0
    @($_.psobject.Properties.Value |% { $i++; New-Text $_ -ForegroundColor $CSVColors[$i%5] -LeaveColor } ) -join (new-text ';' -ForegroundColor $CSVDelimColor -LeaveColor)
   }
}

Export-ModuleMember -Function "Get-ColorizedContent"
$fileNameDate = "01.02.2024.12.45.40-FileDate","01.08.2024.12.45.40-FileDate",
"01.09.2024.12.45.40-FileDate","02.09.2024.12.45.40-FileDate",
"31.08.2024.12.45.40-FileDate","30.08.2024.12.45.40-FileDate",
"28.08.2024.12.45.40-FileDate","04.09.2024.12.45.40-FileDate"

$dateMinus4 = Get-Date (get-date).Adddays(-4).Date -Format dd.MM.yyyy.HH.mm.ss
$dateFormatMinus4 = [datetime]::parseexact($dateMinus4, 'dd.MM.yyyy.HH.mm.ss', $null)

foreach ($file in $fileNameDate)
    {
    $FileSplit = $file.split("-")[0]    
    $fileSplitDate = [datetime]::parseexact($FileSplit, 'dd.MM.yyyy.HH.mm.ss', $null)

    if($dateFormatMinus4 -gt $fileSplitDate)
        {
            write-host $dateFormatMinus4.DateTime is greater than $fileSplitDate.DateTime        
        }
     else
        {
            write-host $dateFormatMinus4.Datetime is greater less $fileSplitDate.DateTime
        }
    }




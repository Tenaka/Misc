    #Working area for scripts   
    #Detect PS or ISE
    $working = "C:\Working"

    if($psise -ne $null)
    {
        $ISEPath = $psise.CurrentFile.FullPath
        $ISEWork = $ISEPath.TrimEnd("NameofScript.ps1")
        New-Item -Path $working -ItemType Directory -Force

    }
    else
    {
        $PSWork = split-path -parent $MyInvocation.MyCommand.Path
        New-Item -Path $working-ItemType Directory -Force
          
    }
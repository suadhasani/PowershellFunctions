function reloadPath(){
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", $env:USERNAME)
}

function switchJDKVersion(){
    # JDK Folder
    $javaBaseFolder = "C:\java"
    $jdkFolders = Get-ChildItem -Path $javaBaseFolder

    "Java Development Kits:`n"
    for ($i=0; $i -lt $jdkFolders.Length; $i++) {
        "[$i] " + $jdkFolders[$i].Name
    }
    $choice = Read-Host "`nPick a JDK"
    $newJDK = ($jdkFolders[$choice] | Select-Object -ExpandProperty Fullname)
    
    $env:JAVA_HOME = $newJDK
    
    $permanent = Read-Host -Prompt "Make changes permanent? [y/n]"
    if ($permanent -match "[yY]"){
        [System.Environment]::SetEnvironmentVariable("JAVA_HOME", $newJDK, $env:USERNAME)
    }
    reloadPath

    "`nJAVA_HOME set to $newJDK`n"
}
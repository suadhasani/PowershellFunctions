# Prints hashes of all files in a directory
function getHashes() {
    $files = Get-ChildItem *
    foreach ($file in $files) {
        $hash = Get-FileHash $file
        Write-Output "$($hash.Hash) - $($file.Name)"
    }
}

# Replaces underscores of all files in the directory with spaces
function replaceUnderscore (){
    Dir | Rename-Item -NewName { $_.Name -replace "_"," " }
}

# Replaces spaces of all files in the directory with underscores
function replaceSpace (){
    Dir | Rename-Item -NewName { $_.Name -replace " ","_" }
}

# Removes files and directories recursively
function rmRecursive([string]$toremove){
    ls $toremove -Recurse | foreach {rm $_}
}

# Adds extensions for all files in the directory
function addExtension ([string]$extension){
    dir | % { mv $_.FullName ( $_.Name + $extension ) }
}

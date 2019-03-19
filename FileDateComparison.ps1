$dir1 = "[comp dir1]"
$dir2 = "[comp dir2]"
$dir3 = "[comp copy to directory]"

$files = Get-ChildItem $dir1 -Recurse -Include *.PIW, *.PDI
$bckFiles =  Get-ChildItem $dir2 -Recurse -Include *.PIW, *.PDI
$compDate=[datetime]”12/30/2018 00:00”

for ($i=0; $i -lt $files.Count; $i++) {

    $replaceFile = $files[$i].FullName.Replace($dir1, "")

    for ($j=0; $j -lt $bckFiles.Count; $j++) {
        
        if ($replaceFile -eq $bckFiles[$j].FullName.Replace($dir2, "")) {
            if ($bckFiles[$j].LastWriteTime -gt $files[$i].LastWriteTime) {
                Write-Host "$($replaceFile)  :  $($files[$i].LastWriteTime) : backup $($bckFiles[$j].LastWriteTime)"

                $destFolder = $bckFiles[$j].DirectoryName.Replace($dir2, $dir3)
                if (!(Test-Path -path $destFolder)) {New-Item $destFolder -Type Directory}
                Copy-Item -Path $bckFiles[$j].FullName -Destination $destFolder
            }
            break

        }
    }
}

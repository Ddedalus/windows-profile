Write-Output "Copying APPDATA files"

$adPath = "C:\users\u1731027\AppData\"
$storePath = "H:\Windows\AppData\"
$adSubdirs = Get-Content -Path "H:\Windows\scripts\app_data_list.txt"

foreach ($dir in $adSubdirs) {
    $fromDir = Join-Path $adPath "$dir"
    $toDir = Join-Path $storePath "$dir"
    if (Test-Path "$fromDir") {
        Remove-Item "$toDir" -Recurse -ErrorAction Ignore
        if(-Not(Test-Path "$toDir")){
            New-Item "$toDir" -ItemType Directory
        }
        robocopy "$fromDir" "$toDir" /mir /xd "**cache*" /xf "**lock*"
        Write-Output "$fromDir copied to $toDir"
    }else {
        Write-Output "$fromDir not found!"
    }
}
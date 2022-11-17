Function Get-Folder($Description)

{
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms")|Out-Null

    $foldername = New-Object System.Windows.Forms.FolderBrowserDialog
    $foldername.Description = $Description
    $foldername.rootfolder = "MyComputer"
    $foldername.SelectedPath = ""

    if($foldername.ShowDialog() -eq "OK")
    {
        $folder += $foldername.SelectedPath
    }
    return $folder
}

$sourcefolder = Get-Folder("Select Source Folder")
$destinationfolder = Get-Folder("Select Desination Folder")

Get-ChildItem -Path $sourcefolder -Filter *.csv | Select-Object -ExpandProperty FullName | Import-Csv | Export-Csv $destinationfolder\merged.csv -NoTypeInformation -Append
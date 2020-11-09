#Written by Kenneth Sherwood Munk
#This is a free to use tool users may modify and republish as they wish.


Write-Output "Welcome to the batch extractor\n\n";
Write-Output -NoNewLine "Would you like to extract all adjacent files with prompting? "
$willConfirm = Read-Host "( [N] / Y )"


Switch($willConfirm){
    Y {Write-Host "The tool will display a confirmation prompt for each file"}
    Default {Write-Host "The tool will NOT display a confirmation prompt for each file"}
}

$zips = Get-ChildItem -Filter *.zip -Name;

foreach($file in $zips){
    
    Write-Output $zips;

    Switch($willConfirm){
        Y {Expand-Archive $file -Force -Confirm}
        Default {Expand-Archive $file -Force}
    }
}

Write-Host -NoNewline 'Press any key to continue...';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
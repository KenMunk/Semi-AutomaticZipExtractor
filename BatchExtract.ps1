#Written by Kenneth Sherwood Munk
#This is a free to use tool users may modify and republish as they wish.

function unpackAll{
    
    $potentialPackages = Get-ChildItem -File -Name

    foreach($package in $potentialPackages){
        
        unpack -file $package.ToString()

    }

    $foundDirectories = Get-ChildItem -Directory -Name

    foreach($directory in $foundDirectories){
        
        Write-Host "scanning directory $directory"
        cd $directory
        unpackAll
        cd ..

    }


}

function unpack{
    
    param ( [string] $file = "")

    $fileTokens = $file.Split(".")

    $fileType = $fileTokens[$fileTokens.Length - 1]

    Write-Host $fileType

    Switch($fileType){
        "zip"
        {
            Write-Host "zip file detected"
        }
        "7z"
        {
            Write-Host "7z file detected"
        }
        "rar"
        {
            Write-Host "rar, a file detected"
        }
        "tar"
        {
            Write-Host "tar file detected"
        }
        Default
        {
            Write-Host "$fileType is not supported, file issue against github repository if you need support added for this"
        }
    }


}

$scriptLocationRaw = $MyInvocation.MyCommand.Definition.Split("\")
$scriptLocation = $scriptLocationRaw[0]
[int] $scriptPathLength = $scriptLocationRaw.Length - 1

for([int]$branch = 1; $branch -lt $scriptPathLength; $branch++){
    
    $scriptLocation += "\"+$scriptLocationRaw[$branch]

}

Write-Host "Script directory: $scriptLocation"
Write-Host $PWD

cd $PWD 


Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
unpackAll
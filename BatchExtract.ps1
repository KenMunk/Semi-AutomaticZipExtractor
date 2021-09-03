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

    Switch($fileType.ToLower()){
        "zip"
        {
            Write-Host "zip file detected"
            Break
        }
        "7z"
        {
            Write-Host "7z file detected"
            Break
        }
        "rar"
        {
            Write-Host "rar, a file detected"
            Break
        }
        "tar"
        {
            Write-Host "tar file detected"
            Break
        }
        "iso"{
            Break
        }
        "wim"
        {
            Break
        }
        "img"
        {
            Break
        }
        Default
        {
            Write-Host "$fileType is not supported, file issue against github repository if you need support added for this"
        }
    }


}

function extract {
    param ( [string] $file = "", [Bool] $confirm = 0)

    if($confirm){
        
        $confirmed = 0
        
        DO{
            
            $response = Read-Host "$file could potentially be a huge file, are you sure you want to unpack this? [yes/no]"
            switch($response.ToLower()){

                "yes"
                {
                    $confirmed += 1
                    Break
                }
                "no"
                {
                    return
                }
                Default
                {
                    #nothing, keep trying
                }

            }


        }while($confirmed -eq 0)

        

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
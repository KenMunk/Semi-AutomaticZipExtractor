
$scriptLocationRaw = $MyInvocation.MyCommand.Definition.Split("\")
$scriptLocation = $scriptLocationRaw[0]
[int] $scriptPathLength = $scriptLocationRaw.Length - 1

for([int]$branch = 1; $branch -lt $scriptPathLength; $branch++){
    
    $scriptLocation += "\"+$scriptLocationRaw[$branch]

}

Set-Alias -Option AllScope -Name BatchExtract -Value "$scriptLocation\BatchExtract.bat" -PassThru -Force

$originalPath = (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path
$updatedPath = "$originalPath;$scriptLocation\BatchExtract.bat;$scriptLocation\7z1900-extra"
Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $updatedPath -Force 
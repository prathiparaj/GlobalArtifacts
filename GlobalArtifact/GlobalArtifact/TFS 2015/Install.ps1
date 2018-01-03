function Create-Folder {
    Param ([string]$path)
    if ((Test-Path $path) -eq $false) 
    {
        Write-Host "$path doesn't exist. Creating now.."
        New-Item -ItemType "directory" -Path $path
    }
}

function Download-File{
    Param ([string]$src, [string] $dst)

    (New-Object System.Net.WebClient).DownloadFile($src,$dst)
    #Invoke-WebRequest $src -OutFile $dst
}

function WaitForFile($File) {
  while(!(Test-Path $File)) {    
    Start-Sleep -s 10;   
  }  
} 


#Setup Folders

$setupFolder = "c:\Software-Modules"
Create-Folder "$setupFolder"

#Create-Folder "c:\Spring-Framework"




if((Test-Path "$setupFolder\tfpt.msi") -eq $false)
{
  
        Download-File "https://globalartifactstg.blob.core.windows.net/globalsoftwarelink4artifact/tfpt.msi" "$setupFolder\tfpt.msi"  
}

if((Test-Path "$setupFolder\tfptinstaller.bat") -eq $false)
{
  
        Download-File "https://globalartifactstg.blob.core.windows.net/globalsoftwarelink4artifact/tfptinstall.bat" "$setupFolder\tfptinstall.bat"  
}



Start-Process -FilePath $setupFolder\tfptinstaller.bat


#$env:Path += ";C:\mysql-5.7.20-winx64\bin"

#mysqld --initialize
#mysqld
#& cmd /c  'mysqld --initialize' 
#& cmd /c  'mysqld'
Start-Sleep -s 20
Remove-Item –path "$setupFolder\tfpt.msi" -Recurse
Remove-Item –path "$setupFolder\tfptinstall.bat" -Recurse


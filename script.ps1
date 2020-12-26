$DateJson = Get-Content .\pullDate.json | ConvertFrom-Json
$CurrentDate = "08-17-2021"
$CommitNumber = 1
# $CurrentDate = Get-Date -Format "MM-dd-yyyy"

function CheckJsonValue {
        if ($CurrentDate -in $DateJson.psobject.properties.name -and $DateJson.$CurrentDate -eq "special")
            {return $true}
        elseif ($CurrentDate -in $DateJson.psobject.properties.name -and $DateJson.$CurrentDate -eq "normal") 
            {return $false}
        else {
            Write-Host "Not today"
            break
        }       
    }

function MakePullRequest {    
    if (CheckJsonValue) {
        New-Item -Path ./files/commitFile.txt -ItemType File;
        for($i=1; $i -le 5; $i++) 
            { Write-Output "Commit Number: $($CommitNumber)" >> ./files/commitFile.txt; git add . ; git commit -m "commit number: $($CommitNumber)" ; git push origin main; $CommitNumber++}
    }
    elseif (!(CheckJsonValue)) {
        Test-Path .\files
        Write-Host "Normal pull"
    }
}


# Make_PullRequest
MakePullRequest
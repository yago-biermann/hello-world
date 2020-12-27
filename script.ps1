. "./tests/tests.ps1"

$DateJson = Get-Content .\commitDate.json | ConvertFrom-Json
$CurrentDate = "08-17-2021"
# $CurrentDate = Get-Date -Format "MM-dd-yyyy"

function GetLastCommit {
    $LastCommit = Get-Content -Path ".\files\commitFile.txt" -Tail 1
    [int]$CommitNumber = $LastCommit -replace "[a-z\s\:]"
    return $CommitNumber
}

function CheckJsonValue {
    if ($CurrentDate -in $DateJson.psobject.properties.name -and $DateJson.$CurrentDate -eq "special")
    { return $true }
    elseif ($CurrentDate -in $DateJson.psobject.properties.name -and $DateJson.$CurrentDate -eq "normal") 
    { return $false }
    else {
        Write-Host "Not today"
        break
    }       
}
# git add . ; git commit -m "commit number: $($CommitNumber)" ; git push origin main;
# Add-Content -Path "./files/commitFile.txt" -Value "Commit Number: $($CommitNumber)"
function MakeCommit {
    $CommitNumber = GetLastCommit    
    if (CheckJsonValue) { 
        # New-Item -Path ./files/commitFile.txt -ItemType File;
        for ($i = 1; $i -le 5; $i++) {
            git add .;
            git commit -m "commit number: $($CommitNumber)";
            git push origin main; 
            Add-Content -Path "./files/commitFile.txt" -Value "Commit Number: $($CommitNumber +1)";
            $CommitNumber++;
        }
    }
    elseif (!(CheckJsonValue)) {
        Test-Path .\files
        Write-Host "Normal pull"
    }
}

Test-GetLastCommit
MakeCommit
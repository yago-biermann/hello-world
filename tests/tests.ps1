function TestImportModule {
    return $true
}

function Test-GetLastCommit {
    $LastCommit = Get-Content -Path ".\files\commitFile.txt" -Tail 1
    if ($null -eq $LastCommit) {
        Write-Output "File empty! Writing the firts line..."
        Add-Content -Path ".\files\commitFile.txt" -Value "Initial commit number: 0"
    }
    elseif ($LastCommit -match '\:*[a-z]$') {
        Write-Output "Commit numbers are broken, you can fix them by manually modifying commits that have strings after the colon"
        break
    }
}

function Test-Files {
    
}

function Test-GitConfigs {
    
}
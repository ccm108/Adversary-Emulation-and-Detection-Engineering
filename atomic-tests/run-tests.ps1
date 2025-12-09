<#  
    Cybersecurity Atomic Test Runner
    This script runs selected MITRE ATT&CK Atomic Red Team tests
    and logs output to /Logs for documentation.
#>

# ---------------------------
# CONFIGURATION
# ---------------------------

$TestIDs = @(
    "T1053.005",   # Scheduled Task / Job (Persistence)
    "T1036",       # Masquerading
    "T1574.001",   # DLL Side-Loading
    "T1566,002",   # Phishing
    "T1047"        # Windows Management Instrumentation
)

$LogDir = "Logs"
if (!(Test-Path $LogDir)) {
    New-Item -ItemType Directory -Path $LogDir | Out-Null
}

$TimeStamp = (Get-Date -Format "yyyy-MM-dd_HH-mm-ss")
$LogFile = "$LogDir\atomic-test-log_$TimeStamp.txt"

# ---------------------------
# FUNCTION TO RUN ATOMIC TEST
# ---------------------------

function Run-Atomic {
    param (
        [string]$AttackID
    )

    Write-Host "-------------------------------------------------" -ForegroundColor Cyan
    Write-Host "Running Atomic Test for $AttackID" -ForegroundColor Yellow
    Write-Host "-------------------------------------------------`n"

    try {
        $result = Invoke-AtomicTest $AttackID -Execution Lever -ErrorAction Stop | Out-String
        Add-Content -Path $LogFile -Value "`n===== $AttackID =====`n$result"
        Write-Host "Test Completed: $AttackID" -ForegroundColor Green
    }
    catch {
        $err = $_.Exception.Message
        Add-Content -Path $LogFile -Value "`n===== $AttackID FAILED =====`n$err"
        Write-Host "Test Failed: $AttackID" -ForegroundColor Red
    }
}

# ---------------------------
# RUN ALL SELECTED TESTS
# ---------------------------

Write-Host "`nRunning Atomic Tests..." -ForegroundColor Cyan
foreach ($id in $TestIDs) {
    Run-Atomic -AttackID $id
}

Write-Host "`nAll tests finished."
Write-Host "Log saved to: $LogFile" -ForegroundColor Green

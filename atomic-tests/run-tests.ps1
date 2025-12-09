<#
    Cybersecurity Atomic Test Runner
    --------------------------------
    Author: Jacob Komi
    Course: COSC 435 - Computer & Network Security
    Purpose:
        This script executes selected MITRE ATT&CK techniques 
        using Atomic Red Team’s Invoke-AtomicTest framework.

        All results are logged inside the ./Logs directory 
        with timestamps for documentation and analysis.

    Requirements:
        - PowerShell 5+
        - Atomic Red Team installed
        - Execution policy set to allow scripts:
              Set-ExecutionPolicy Bypass -Scope Process -Force
#>

# ============================
# CONFIGURATION SECTION
# ============================

# MITRE ATT&CK Technique IDs to execute.
# Each corresponds to an Atomic Red Team implementation.
$TestIDs = @(
    "T1053.005",   # Scheduled Task Persistence
    "T1036",       # Masquerading (Renaming binaries)
    "T1574.002",   # DLL Side-Loading (Hijack Execution Flow)
    "T1566.002",   # Spearphishing Link
    "T1047"        # Windows Management Instrumentation (WMI Execution)
)

# Directory where logs will be written.
$LogDir = "Logs"

# Create the directory if it does not exist.
if (!(Test-Path $LogDir)) {
    New-Item -ItemType Directory -Path $LogDir | Out-Null
}

# Generate a timestamped log file for tracking results.
$TimeStamp = (Get-Date -Format "yyyy-MM-dd_HH-mm-ss")
$LogFile = "$LogDir\atomic-test-log_$TimeStamp.txt"


# ============================
# FUNCTION: Run-Atomic
# Executes each ATT&CK technique safely and logs results.
# ============================

function Run-Atomic {
    param (
        [string]$AttackID
    )

    Write-Host "-------------------------------------------------" -ForegroundColor Cyan
    Write-Host " Running Atomic Test for: $AttackID" -ForegroundColor Yellow
    Write-Host "-------------------------------------------------`n"

    try {
        # Execute the Atomic Red Team test.
        # Execution flag ensures proper test execution behavior.
        $result = Invoke-AtomicTest $AttackID -Execution Lever -ErrorAction Stop | Out-String
        
        # Append test output to log file.
        Add-Content -Path $LogFile -Value "`n===== $AttackID SUCCESS =====`n$result"
        
        Write-Host "Test Completed Successfully: $AttackID" -ForegroundColor Green
    }
    catch {
        # Capture and log errors if a test fails.
        $err = $_.Exception.Message
        Add-Content -Path $LogFile -Value "`n===== $AttackID FAILED =====`n$err"
        
        Write-Host "Test Failed: $AttackID" -ForegroundColor Red
    }
}


# ============================
# RUN ALL ATOMIC TESTS
# ============================

Write-Host "`nStarting Execution of Atomic Red Team Tests..." -ForegroundColor Cyan

foreach ($id in $TestIDs) {
    Run-Atomic -AttackID $id
}

Write-Host "`nAll tests completed." -ForegroundColor Cyan
Write-Host "Logs saved to: $LogFile" -ForegroundColor Green

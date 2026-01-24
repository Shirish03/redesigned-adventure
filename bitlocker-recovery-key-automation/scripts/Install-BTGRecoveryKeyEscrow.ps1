# =====================================================================
# Script Name : Install-BTGRecoveryKeyEscrow.ps1
# Author      : Shirish
#
# Description :
# Deploys the BitLocker-to-Go recovery key escrow retry solution by:
#   1. Copying the PowerShell script to ProgramData
#   2. Registering an event-triggered scheduled task (Event ID 846)
#      using the provided XML file
#
# =====================================================================

# -------------------------------
# Variables
# -------------------------------
$ScriptSourceName = "BTG_RecoveryKey_Escrow_Retry.ps1"
$TargetScriptDir  = "$env:ProgramData\BitLocker\Scripts"
$TargetScriptPath = Join-Path $TargetScriptDir $ScriptSourceName

$TaskXmlName = "BitLockerToGo-Escrow-Retry.xml"
$TaskXmlPath = Join-Path $PSScriptRoot "..\tasks\$TaskXmlName"

if (Test-Path $TaskXmlPath) {
    $TaskXmlPath = (Resolve-Path $TaskXmlPath).Path
} else {
    Write-Error "Scheduled Task XML not found! Please ensure it exists at: $TaskXmlPath"
    exit 1
}


$TaskName         = "BitLockerToGo-RecoveryKey-Escrow-Retry"

# -------------------------------
# Ensure Script Directory Exists
# -------------------------------
if (-not (Test-Path $TargetScriptDir)) {
    Write-Output "Creating script directory at $TargetScriptDir"
    New-Item -Path $TargetScriptDir -ItemType Directory -Force | Out-Null
}

# -------------------------------
# Copy Main Script
# -------------------------------
$SourceScriptPath = Join-Path $PSScriptRoot $ScriptSourceName
if (-not (Test-Path $SourceScriptPath)) {
    Write-Error "Source script not found: $SourceScriptPath"
    exit 1
}

Write-Output "Copying $ScriptSourceName to $TargetScriptPath"
Copy-Item -Path $SourceScriptPath -Destination $TargetScriptPath -Force

# -------------------------------
# Validate Task XML Exists
# -------------------------------
if (-not (Test-Path $TaskXmlPath)) {
    Write-Error "Scheduled Task XML not found: $TaskXmlPath"
    exit 1
}

# -------------------------------
# Remove Existing Scheduled Task (if any)
# -------------------------------
if (Get-ScheduledTask -TaskName $TaskName -ErrorAction SilentlyContinue) {
    Write-Output "Existing task found. Removing $TaskName"
    Unregister-ScheduledTask -TaskName $TaskName -Confirm:$false
}

# -------------------------------
# Register Scheduled Task using XML
# -------------------------------
Write-Output "Importing Scheduled Task from XML: $TaskXmlPath"
schtasks.exe /Create /TN "$TaskName" /XML "$TaskXmlPath" /F

Write-Output "Deployment completed successfully."

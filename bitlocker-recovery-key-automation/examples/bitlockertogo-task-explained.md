# Event-Triggered Scheduled Task (Example)

This document explains the structure of the example scheduled task
used to react to BitLocker Event ID 846.

## Key Elements

- **Trigger**
  - Event-based trigger listening to:
    - Log: Microsoft-Windows-BitLocker-API/Management
    - Event ID: 846

- **Action**
  - Executes PowerShell
  - Invokes a retry script located under ProgramData

## Why This Matters

Using an event-triggered task allows the solution to react
immediately to BitLocker escrow failures without relying on
polling or user action.

# BitLocker-to-Go Recovery Key Escrow – Event-Driven Design

## Overview

While backing up **OS drive** BitLocker recovery keys to Entra ID is well supported today,  
**BitLocker-to-Go recovery key escrow for removable media** remains a gray area in **Hybrid Entra ID and Intune-managed Windows environments**.

In regulated environments where:
- BitLocker is mandatory for removable media
- USB usage cannot be fully disabled
- Devices are cloud-managed

this creates an important **design gap**:

> How do we reliably back up BitLocker-to-Go recovery keys without relying on end users?

This repository demonstrates an **event-driven, system-level approach** to address that gap.

---

## Problem Statement

When BitLocker-to-Go is enforced via policy, recovery key backup attempts may fail under certain conditions, resulting in:

- Recovery keys not being escrowed centrally
- Dependence on end users to save recovery information
- Gaps in auditability and recovery readiness

Windows logs this condition using:

- **Event ID 846**  
  *(BitLocker recovery key backup failure)*

This solution reacts to that signal and **automatically retries recovery key escrow** in a controlled and auditable way.

---

## Design Principles

This solution was built with the following principles:

- **Event-driven** – React only when a failure is detected
- **User-independent** – Runs as SYSTEM
- **Minimal surface area** – Uses native Windows and BitLocker components
- **Separation of concerns** – Deployment, trigger, and logic are distinct
- **Public-safe** – No org-specific configuration or secrets

---

## High-Level Architecture


# redesigned-adventure

A collection of endpoint security automation patterns and design explorations
for modern, cloud-managed Windows environments.

This repository serves as a workspace for documenting real-world security
control gaps encountered during endpoint modernization, along with
event-driven and operationally practical approaches used to address them.

The focus is not on turnkey tooling, but on **patterns, behavior, and design
decisions** that emerge in complex enterprise environments.

---

## Current Projects

### 🔐 Hybrid Entra ID – BitLocker-to-Go Key Escrow Pattern

**Folder:** `hybrid-entra-btg-key-escrow-pattern`

Documents an event-driven approach to handling BitLocker-to-Go recovery key
escrow failures on Hybrid Entra ID joined Windows devices, where native
Intune and policy-based behavior may be inconsistent.

Key concepts explored:
- Observing BitLocker API failure events
- Event-triggered remediation via scheduled tasks
- Programmatic recovery key identification
- Retrying escrow without relying on end-user action

---

## Repository Philosophy

- Focus on **design patterns**, not just scripts
- Prefer **event-driven automation** over polling
- Assume **enterprise constraints** (change control, audits, limited agents)
- Avoid embedding tenant-specific or sensitive information

---

## Disclaimer

Content in this repository is provided as reference material and
design guidance. Implementations may require adaptation based on
environment, configuration, and security requirements.

Always validate behavior in a controlled environment before
production use.

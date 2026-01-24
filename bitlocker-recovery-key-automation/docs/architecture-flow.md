# BitLocker-to-Go Recovery Key Escrow – Architecture Flow

## Context

In Hybrid Entra ID environments, BitLocker-to-Go recovery key backup
to Entra ID may fail silently or emit failure events even when
policy settings are correctly configured.

This design leverages observable system behavior rather than
configuration enforcement alone.

## Event-Driven Approach

- Windows emits Event ID 846 when BitLocker-to-Go key escrow fails
- The event includes the removable drive letter
- This signal is used as a deterministic retry trigger

## Why Scheduled Tasks?

Scheduled tasks provide:
- Native OS-level execution
- No dependency on external agents
- Immediate reaction to system events

This approach aligns with environments where additional agents
or services are restricted.

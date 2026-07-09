# Service Dependencies

## Backend (Phase 2)

```
api-gateway
  → auth-service (JWT validation)
  → household-service, pantry-service, recipe-service
  → ai-runtime → Anthropic API
               → pantry-service (context)
workflow-service → Redis BullMQ
notification-service → FCM, APNs
```

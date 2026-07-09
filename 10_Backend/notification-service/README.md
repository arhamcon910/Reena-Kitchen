# Notification Service

**Tech:** NestJS + FCM/APNs | **Port:** 3008 | **Status:** 📋 Phase 2

## Responsibility

Notification Service handles its domain within the REENA backend microservices.

## Health Check

```
GET /health → {"status": "ok", "service": "notification-service"}
```

## Environment

```env
NODE_ENV=production
DATABASE_URL=postgresql://...
PORT=3008
```

## Local Dev

```bash
npm install && npm run start:dev
```

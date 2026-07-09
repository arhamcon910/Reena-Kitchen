# Workflow Service

**Tech:** NestJS + BullMQ | **Port:** 3007 | **Status:** 📋 Phase 2

## Responsibility

Workflow Service handles its domain within the REENA backend microservices.

## Health Check

```
GET /health → {"status": "ok", "service": "workflow-service"}
```

## Environment

```env
NODE_ENV=production
DATABASE_URL=postgresql://...
PORT=3007
```

## Local Dev

```bash
npm install && npm run start:dev
```

# Finance Service

**Tech:** NestJS + PostgreSQL | **Port:** 3006 | **Status:** 📋 Phase 2

## Responsibility

Finance Service handles its domain within the REENA backend microservices.

## Health Check

```
GET /health → {"status": "ok", "service": "finance-service"}
```

## Environment

```env
NODE_ENV=production
DATABASE_URL=postgresql://...
PORT=3006
```

## Local Dev

```bash
npm install && npm run start:dev
```

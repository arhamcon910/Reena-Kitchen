# Shopping Service

**Tech:** NestJS + PostgreSQL | **Port:** 3005 | **Status:** 📋 Phase 2

## Responsibility

Shopping Service handles its domain within the REENA backend microservices.

## Health Check

```
GET /health → {"status": "ok", "service": "shopping-service"}
```

## Environment

```env
NODE_ENV=production
DATABASE_URL=postgresql://...
PORT=3005
```

## Local Dev

```bash
npm install && npm run start:dev
```

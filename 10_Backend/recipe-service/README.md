# Recipe Service

**Tech:** NestJS + PostgreSQL | **Port:** 3004 | **Status:** 📋 Phase 2

## Responsibility

Recipe Service handles its domain within the REENA backend microservices.

## Health Check

```
GET /health → {"status": "ok", "service": "recipe-service"}
```

## Environment

```env
NODE_ENV=production
DATABASE_URL=postgresql://...
PORT=3004
```

## Local Dev

```bash
npm install && npm run start:dev
```

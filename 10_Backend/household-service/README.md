# Household Service

**Tech:** NestJS + PostgreSQL | **Port:** 3002 | **Status:** 📋 Phase 2

## Responsibility

Household Service handles its domain within the REENA backend microservices.

## Health Check

```
GET /health → {"status": "ok", "service": "household-service"}
```

## Environment

```env
NODE_ENV=production
DATABASE_URL=postgresql://...
PORT=3002
```

## Local Dev

```bash
npm install && npm run start:dev
```

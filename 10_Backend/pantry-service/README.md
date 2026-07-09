# Pantry Service

**Tech:** NestJS + PostgreSQL | **Port:** 3003 | **Status:** 📋 Phase 2

## Responsibility

Pantry Service handles its domain within the REENA backend microservices.

## Health Check

```
GET /health → {"status": "ok", "service": "pantry-service"}
```

## Environment

```env
NODE_ENV=production
DATABASE_URL=postgresql://...
PORT=3003
```

## Local Dev

```bash
npm install && npm run start:dev
```

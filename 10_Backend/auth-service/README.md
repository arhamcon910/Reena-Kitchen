# Auth Service

**Tech:** NestJS + Supabase Auth | **Port:** 3001 | **Status:** 📋 Phase 2

## Responsibility

Auth Service handles its domain within the REENA backend microservices.

## Health Check

```
GET /health → {"status": "ok", "service": "auth-service"}
```

## Environment

```env
NODE_ENV=production
DATABASE_URL=postgresql://...
PORT=3001
```

## Local Dev

```bash
npm install && npm run start:dev
```

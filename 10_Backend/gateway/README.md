# API Gateway

**Tech:** NestJS + Kong | **Port:** 3000 | **Status:** 📋 Phase 2

## Responsibility

API Gateway handles its domain within the REENA backend microservices.

## Health Check

```
GET /health → {"status": "ok", "service": "gateway"}
```

## Environment

```env
NODE_ENV=production
DATABASE_URL=postgresql://...
PORT=3000
```

## Local Dev

```bash
npm install && npm run start:dev
```

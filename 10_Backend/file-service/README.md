# File Service

**Tech:** NestJS + S3 | **Port:** 3009 | **Status:** 📋 Phase 2

## Responsibility

File Service handles its domain within the REENA backend microservices.

## Health Check

```
GET /health → {"status": "ok", "service": "file-service"}
```

## Environment

```env
NODE_ENV=production
DATABASE_URL=postgresql://...
PORT=3009
```

## Local Dev

```bash
npm install && npm run start:dev
```

# AI Runtime

**Tech:** NestJS + LangChain | **Port:** 3010 | **Status:** 📋 Phase 2

## Responsibility

AI Runtime handles its domain within the REENA backend microservices.

## Health Check

```
GET /health → {"status": "ok", "service": "ai-runtime"}
```

## Environment

```env
NODE_ENV=production
DATABASE_URL=postgresql://...
PORT=3010
```

## Local Dev

```bash
npm install && npm run start:dev
```

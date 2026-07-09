# Backend Integration

## Architecture (Phase 2)

```
Flutter App ─HTTPS+JWT→ API Gateway (Kong) → NestJS Services
                                              ↓
                                          Supabase PostgreSQL
                                          Redis (cache + queues)
```

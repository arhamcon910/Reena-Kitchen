# REENA Household Service

**Sprint S003** | Port 3002

Manages households and their members.

## Quick Start

```bash
npm install
copy .env.example .env
npx prisma migrate dev --name init
npm run build
npm run start
```

## Endpoints

### Households
| Method | Path | Description |
|---|---|---|
| POST | /households | Create household |
| GET | /households | List all |
| GET | /households/:id | Get by ID |
| PATCH | /households/:id | Update |
| DELETE | /households/:id | Delete |

### Members
| Method | Path | Description |
|---|---|---|
| POST | /households/:id/members | Add member |
| GET | /households/:id/members | List members |
| GET | /households/:id/members/:memberId | Get member |
| PATCH | /households/:id/members/:memberId | Update |
| DELETE | /households/:id/members/:memberId | Remove |

### System
| GET | /health | Health check |
| GET | /api/docs | Swagger UI |

# REENA Pantry Service

**Sprint S004** | Port 3003 | Database: reena_pantry_db

Manages household pantry items and ingredients.

## Quick Start

```bash
npm install
copy .env.example .env
npx prisma migrate dev --name init
npm run build
npm run start
```

## Endpoints

| Method | Path | Description |
|---|---|---|
| POST | /pantry/:householdId/items | Add item |
| POST | /pantry/:householdId/items/bulk | Add multiple items |
| GET | /pantry/:householdId/items | List all items |
| GET | /pantry/:householdId/items/in-stock | In-stock items only |
| GET | /pantry/:householdId/items/:id | Get item |
| PATCH | /pantry/:householdId/items/:id | Update item |
| DELETE | /pantry/:householdId/items/:id | Remove item |
| GET | /health | Health check |
| GET | /api/docs | Swagger UI |

## Categories

VEGETABLE · FRUIT · GRAIN · DAIRY · SPICE · OIL · LEGUME · NUT · HERB · OTHER

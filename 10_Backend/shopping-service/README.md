# REENA Shopping Service

**Port:** 3005 | **Database:** reena_shopping_db

## Quick Start

```bash
npm install
copy .env.example .env
npx prisma migrate dev --name init
npx prisma generate
npm run build
npm run start
```

## Endpoints

| Method | Path | Description |
|---|---|---|
| POST | /shopping/:hId/lists | Create list |
| POST | /shopping/:hId/lists/generate | Generate from ingredients |
| GET | /shopping/:hId/lists | All lists |
| GET | /shopping/:hId/lists/:id | Get list + items |
| PATCH | /shopping/:hId/lists/:id/complete | Mark complete |
| DELETE | /shopping/:hId/lists/:id | Delete list |
| POST | /shopping/:hId/lists/:id/items | Add item |
| PATCH | /shopping/:hId/lists/:id/items/:itemId | Update/purchase item |
| PATCH | /shopping/:hId/lists/:id/items/mark-all-purchased | Mark all done |
| DELETE | /shopping/:hId/lists/:id/items/:itemId | Remove item |
| GET | /health | Health check |
| GET | /api/docs | Swagger UI |

## Key Feature — Generate from Ingredients

```bash
POST /shopping/:householdId/lists/generate
{
  "name": "Weekly Groceries",
  "ingredients": ["yellow dal", "onion", "tomato", "ghee", "cumin"],
  "pantryItems": ["onion", "tomato"]
}
# Returns list with only: yellow dal, ghee, cumin (onion + tomato excluded)
```

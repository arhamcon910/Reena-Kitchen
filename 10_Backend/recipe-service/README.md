# REENA Recipe Service

**Sprint S005** | Port 3004 | Database: reena_recipe_db

Vegetarian Indian recipe catalogue with search and festival filtering.

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
| POST | /recipes | Create recipe |
| POST | /recipes/seed | Seed 8 default recipes |
| GET | /recipes | Search/list all |
| GET | /recipes?q=dal | Full-text search |
| GET | /recipes?category=DINNER | Filter by meal |
| GET | /recipes?festival=Diwali | Festival recipes |
| GET | /recipes?vegetarianOnly=true | Veg only |
| GET | /recipes?maxMinutes=20 | Quick meals |
| GET | /recipes/category/:category | By category |
| GET | /recipes/festival/:festival | By festival |
| GET | /recipes/:id | Get by ID |
| PATCH | /recipes/:id | Update |
| DELETE | /recipes/:id | Delete |
| GET | /health | Health check |
| GET | /api/docs | Swagger UI |

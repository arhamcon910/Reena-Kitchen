# REENA API

**Sprint S002** | Auth + Users + Prisma | PostgreSQL

---

## Quick Start

```bash
# 1. Install dependencies
npm install

# 2. Configure environment
cp .env.example .env
# Edit .env — set DATABASE_URL and JWT_SECRET

# 3. Run database migration
npx prisma migrate dev --name init

# 4. Start development server
npm run start:dev
```

---

## Environment Variables

| Variable | Example | Description |
|---|---|---|
| `PORT` | `3001` | HTTP port |
| `DATABASE_URL` | `postgresql://postgres:pass@localhost:5432/reena_db` | PostgreSQL connection |
| `JWT_SECRET` | `long-random-string` | JWT signing secret |
| `JWT_EXPIRES_IN` | `7d` | Token expiry |

---

## API Endpoints

### Auth
| Method | Path | Auth | Description |
|---|---|---|---|
| `POST` | `/auth/register` | None | Register new user |
| `POST` | `/auth/login` | None | Login → access token |
| `GET` | `/auth/me` | JWT | Get current user |

### Users
| Method | Path | Auth | Description |
|---|---|---|---|
| `GET` | `/users/me` | JWT | Get profile |
| `PATCH` | `/users/me` | JWT | Update profile |
| `DELETE` | `/users/me` | JWT | Delete account |
| `GET` | `/users/:id` | JWT | Get user by ID |

### System
| Method | Path | Auth | Description |
|---|---|---|---|
| `GET` | `/health` | None | Health check |
| `GET` | `/api/docs` | None | Swagger UI |

---

## Database

```bash
# Create migration
npx prisma migrate dev --name <migration-name>

# View data in Prisma Studio
npx prisma studio

# Reset database
npx prisma migrate reset

# Generate Prisma client after schema change
npx prisma generate
```

---

## Testing Auth Flow

```bash
# Register
curl -X POST http://localhost:3001/auth/register \
  -H "Content-Type: application/json" \
  -d '{"email":"test@reena.ai","password":"Password123!","name":"Test User"}'

# Login
curl -X POST http://localhost:3001/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"test@reena.ai","password":"Password123!"}'

# Get profile (replace TOKEN with the accessToken from login)
curl http://localhost:3001/auth/me \
  -H "Authorization: Bearer TOKEN"
```

---

*REENA AI Kitchen · API · Sprint S002 · 2026-07-11*

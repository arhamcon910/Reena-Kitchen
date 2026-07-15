# Installation Steps

Run these commands from `10_Backend/api/` in order:

```bash
# 1. Install new dependencies
npm install @nestjs/config
npm install @nestjs/swagger swagger-ui-express
npm install class-validator class-transformer

# 2. Copy environment file
cp .env.example .env

# 3. Build to verify TypeScript compiles
npm run build

# 4. Start server
npm run start

# 5. Verify health endpoint
curl http://localhost:3000/health

# 6. Open Swagger
start http://localhost:3000/api/docs
```

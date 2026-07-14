-- CreateEnum
CREATE TYPE "MealCategory" AS ENUM ('BREAKFAST', 'LUNCH', 'DINNER', 'SNACK', 'DESSERT', 'DRINK');

-- CreateEnum
CREATE TYPE "SpiceLevel" AS ENUM ('MILD', 'MEDIUM', 'HOT');

-- CreateTable
CREATE TABLE "recipes" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "cuisine" TEXT NOT NULL DEFAULT 'Indian',
    "category" "MealCategory" NOT NULL,
    "spice_level" "SpiceLevel" NOT NULL DEFAULT 'MEDIUM',
    "is_vegetarian" BOOLEAN NOT NULL DEFAULT true,
    "prep_minutes" INTEGER NOT NULL DEFAULT 0,
    "cook_minutes" INTEGER NOT NULL,
    "servings" INTEGER NOT NULL DEFAULT 4,
    "calories" INTEGER,
    "protein_g" DOUBLE PRECISION,
    "fibre_g" DOUBLE PRECISION,
    "cost_inr" INTEGER,
    "ingredients" TEXT[],
    "tags" TEXT[],
    "festivals" TEXT[],
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "recipes_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "recipes_category_idx" ON "recipes"("category");

-- CreateIndex
CREATE INDEX "recipes_is_vegetarian_idx" ON "recipes"("is_vegetarian");

-- CreateIndex
CREATE INDEX "recipes_cuisine_idx" ON "recipes"("cuisine");

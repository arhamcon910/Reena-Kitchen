-- CreateEnum
CREATE TYPE "ItemCategory" AS ENUM ('VEGETABLE', 'FRUIT', 'GRAIN', 'DAIRY', 'SPICE', 'OIL', 'LEGUME', 'NUT', 'HERB', 'OTHER');

-- CreateTable
CREATE TABLE "pantry_items" (
    "id" TEXT NOT NULL,
    "household_id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "quantity" DOUBLE PRECISION,
    "unit" TEXT,
    "category" "ItemCategory" NOT NULL DEFAULT 'OTHER',
    "in_stock" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "pantry_items_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "pantry_items_household_id_idx" ON "pantry_items"("household_id");

-- CreateIndex
CREATE INDEX "pantry_items_household_id_in_stock_idx" ON "pantry_items"("household_id", "in_stock");

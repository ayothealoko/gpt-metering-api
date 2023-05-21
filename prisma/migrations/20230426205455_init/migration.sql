/*
  Warnings:

  - You are about to drop the column `promptTokenCost` on the `RequestCall` table. All the data in the column will be lost.
  - You are about to drop the column `responseTokenCost` on the `RequestCall` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "RequestCall" DROP COLUMN "promptTokenCost",
DROP COLUMN "responseTokenCost";

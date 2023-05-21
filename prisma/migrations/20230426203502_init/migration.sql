/*
  Warnings:

  - You are about to drop the column `aiModel` on the `Meter` table. All the data in the column will be lost.
  - You are about to alter the column `softQuota` on the `Meter` table. The data in that column could be lost. The data in that column will be cast from `Decimal(15,4)` to `Integer`.
  - You are about to alter the column `hardQuota` on the `Meter` table. The data in that column could be lost. The data in that column will be cast from `Decimal(15,4)` to `Integer`.
  - You are about to alter the column `promptTokenCost` on the `RequestCall` table. The data in that column could be lost. The data in that column will be cast from `Decimal(15,4)` to `Integer`.
  - You are about to alter the column `responseTokenCost` on the `RequestCall` table. The data in that column could be lost. The data in that column will be cast from `Decimal(15,4)` to `Integer`.
  - Added the required column `aiModel` to the `RequestCall` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Meter" DROP COLUMN "aiModel",
ALTER COLUMN "softQuota" SET DATA TYPE INTEGER,
ALTER COLUMN "hardQuota" SET DATA TYPE INTEGER;

-- AlterTable
ALTER TABLE "RequestCall" ADD COLUMN     "aiModel" "AiModel" NOT NULL,
ALTER COLUMN "promptTokenCost" SET DATA TYPE INTEGER,
ALTER COLUMN "responseTokenCost" SET DATA TYPE INTEGER;

/*
  Warnings:

  - You are about to drop the column `aiModel` on the `RequestCall` table. All the data in the column will be lost.
  - Added the required column `aiModelId` to the `RequestCall` table without a default value. This is not possible if the table is not empty.

*/
-- AlterEnum
-- This migration adds more than one value to an enum.
-- With PostgreSQL versions 11 and earlier, this is not possible
-- in a single migration. This can be worked around by creating
-- multiple migrations, each migration adding only one value to
-- the enum.


ALTER TYPE "PeriodType" ADD VALUE 'DAILY';
ALTER TYPE "PeriodType" ADD VALUE 'WEEKLY';

-- AlterTable
ALTER TABLE "RequestCall" DROP COLUMN "aiModel",
ADD COLUMN     "aiModelId" TEXT NOT NULL;

-- DropEnum
DROP TYPE "AiModel";

-- CreateTable
CREATE TABLE "AiModel" (
    "aiModelId" TEXT NOT NULL,
    "modelName" TEXT NOT NULL,
    "promptCost" INTEGER NOT NULL,
    "completeionCost" INTEGER NOT NULL,

    CONSTRAINT "AiModel_pkey" PRIMARY KEY ("aiModelId")
);

-- AddForeignKey
ALTER TABLE "RequestCall" ADD CONSTRAINT "RequestCall_aiModelId_fkey" FOREIGN KEY ("aiModelId") REFERENCES "AiModel"("aiModelId") ON DELETE RESTRICT ON UPDATE CASCADE;

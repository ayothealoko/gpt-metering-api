/*
  Warnings:

  - A unique constraint covering the columns `[meterPeriodCuid]` on the table `MeterPeriod` will be added. If there are existing duplicate values, this will fail.
  - The required column `meterPeriodCuid` was added to the `MeterPeriod` table with a prisma-level default value. This is not possible if the table is not empty. Please add this column as optional, then populate it before making it required.

*/
-- AlterTable
ALTER TABLE "MeterPeriod" ADD COLUMN     "meterPeriodCuid" TEXT NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "MeterPeriod_meterPeriodCuid_key" ON "MeterPeriod"("meterPeriodCuid");

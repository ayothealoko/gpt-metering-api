/*
  Warnings:

  - You are about to drop the column `periodType` on the `Meter` table. All the data in the column will be lost.
  - Added the required column `periodType` to the `MeterPeriod` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Meter" DROP COLUMN "periodType";

-- AlterTable
ALTER TABLE "MeterPeriod" ADD COLUMN     "periodType" "PeriodType" NOT NULL;

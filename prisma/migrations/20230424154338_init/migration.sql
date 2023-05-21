/*
  Warnings:

  - You are about to drop the `Period` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `periodType` to the `Meter` table without a default value. This is not possible if the table is not empty.
  - Added the required column `recurring` to the `Meter` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Period" DROP CONSTRAINT "Period_meterId_fkey";

-- AlterTable
ALTER TABLE "Meter" ADD COLUMN     "periodType" "PeriodType" NOT NULL,
ADD COLUMN     "recurring" BOOLEAN NOT NULL;

-- DropTable
DROP TABLE "Period";

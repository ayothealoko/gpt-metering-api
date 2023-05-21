/*
  Warnings:

  - Changed the type of `aiModel` on the `Meter` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- AlterTable
ALTER TABLE "Meter" DROP COLUMN "aiModel",
ADD COLUMN     "aiModel" "AiModel" NOT NULL;

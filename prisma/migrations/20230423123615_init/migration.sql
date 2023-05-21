/*
  Warnings:

  - You are about to drop the column `PersonCuid` on the `Person` table. All the data in the column will be lost.
  - The required column `apiKeyCuid` was added to the `ApiKey` table with a prisma-level default value. This is not possible if the table is not empty. Please add this column as optional, then populate it before making it required.
  - The required column `personCuid` was added to the `Person` table with a prisma-level default value. This is not possible if the table is not empty. Please add this column as optional, then populate it before making it required.

*/
-- DropForeignKey
ALTER TABLE "ApiKey" DROP CONSTRAINT "ApiKey_personId_fkey";

-- DropForeignKey
ALTER TABLE "Customer" DROP CONSTRAINT "Customer_personId_fkey";

-- DropForeignKey
ALTER TABLE "Period" DROP CONSTRAINT "Period_meterId_fkey";

-- AlterTable
ALTER TABLE "ApiKey" ADD COLUMN     "apiKeyCuid" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "Person" DROP COLUMN "PersonCuid",
ADD COLUMN     "personCuid" TEXT NOT NULL;

-- AddForeignKey
ALTER TABLE "ApiKey" ADD CONSTRAINT "ApiKey_personId_fkey" FOREIGN KEY ("personId") REFERENCES "Person"("personId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Customer" ADD CONSTRAINT "Customer_personId_fkey" FOREIGN KEY ("personId") REFERENCES "Person"("personId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Period" ADD CONSTRAINT "Period_meterId_fkey" FOREIGN KEY ("meterId") REFERENCES "Meter"("meterId") ON DELETE CASCADE ON UPDATE CASCADE;

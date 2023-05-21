/*
  Warnings:

  - You are about to drop the column `recuring` on the `Period` table. All the data in the column will be lost.
  - Added the required column `recurring` to the `Period` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Period" DROP COLUMN "recuring",
ADD COLUMN     "recurring" BOOLEAN NOT NULL;

/*
  Warnings:

  - You are about to drop the column `userId` on the `ApiKey` table. All the data in the column will be lost.
  - You are about to drop the column `userId` on the `Customer` table. All the data in the column will be lost.
  - You are about to drop the `User` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[personId]` on the table `Customer` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `personId` to the `ApiKey` table without a default value. This is not possible if the table is not empty.
  - Added the required column `personId` to the `Customer` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "ApiKey" DROP CONSTRAINT "ApiKey_userId_fkey";

-- DropForeignKey
ALTER TABLE "Customer" DROP CONSTRAINT "Customer_userId_fkey";

-- DropIndex
DROP INDEX "Customer_userId_key";

-- AlterTable
ALTER TABLE "ApiKey" DROP COLUMN "userId",
ADD COLUMN     "personId" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "Customer" DROP COLUMN "userId",
ADD COLUMN     "personId" TEXT NOT NULL;

-- DropTable
DROP TABLE "User";

-- CreateTable
CREATE TABLE "Person" (
    "personId" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "dateCreated" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "dateModified" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "hash" TEXT NOT NULL,

    CONSTRAINT "Person_pkey" PRIMARY KEY ("personId")
);

-- CreateIndex
CREATE UNIQUE INDEX "Person_email_key" ON "Person"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Customer_personId_key" ON "Customer"("personId");

-- AddForeignKey
ALTER TABLE "ApiKey" ADD CONSTRAINT "ApiKey_personId_fkey" FOREIGN KEY ("personId") REFERENCES "Person"("personId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Customer" ADD CONSTRAINT "Customer_personId_fkey" FOREIGN KEY ("personId") REFERENCES "Person"("personId") ON DELETE RESTRICT ON UPDATE CASCADE;

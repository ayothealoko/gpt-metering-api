/*
  Warnings:

  - The primary key for the `User` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `date_create` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `date_modified` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `id` on the `User` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[email]` on the table `User` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `email` to the `User` table without a default value. This is not possible if the table is not empty.
  - The required column `userId` was added to the `User` table with a prisma-level default value. This is not possible if the table is not empty. Please add this column as optional, then populate it before making it required.

*/
-- CreateEnum
CREATE TYPE "PeriodType" AS ENUM ('MONTHLY', 'YEARLY');

-- CreateEnum
CREATE TYPE "AiModel" AS ENUM ('GPT4_8k', 'GPT4_32k');

-- AlterTable
ALTER TABLE "User" DROP CONSTRAINT "User_pkey",
DROP COLUMN "date_create",
DROP COLUMN "date_modified",
DROP COLUMN "id",
ADD COLUMN     "dateCreated" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "dateModified" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "email" TEXT NOT NULL,
ADD COLUMN     "userId" TEXT NOT NULL,
ADD CONSTRAINT "User_pkey" PRIMARY KEY ("userId");

-- CreateTable
CREATE TABLE "ApiKey" (
    "apiKeyid" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "isValid" BOOLEAN NOT NULL DEFAULT true,
    "dateCreated" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "dateModified" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ApiKey_pkey" PRIMARY KEY ("apiKeyid")
);

-- CreateTable
CREATE TABLE "Customer" (
    "customerId" TEXT NOT NULL,
    "customerCuid" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "dateCreated" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "dateModified" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Customer_pkey" PRIMARY KEY ("customerId")
);

-- CreateTable
CREATE TABLE "MeterGroup" (
    "meterGroupId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "dateCreated" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "dateModified" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "MeterGroup_pkey" PRIMARY KEY ("meterGroupId")
);

-- CreateTable
CREATE TABLE "Period" (
    "periodId" TEXT NOT NULL,
    "periodType" "PeriodType" NOT NULL,
    "recuring" BOOLEAN NOT NULL,
    "meterId" TEXT NOT NULL,
    "dateCreated" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "dateModified" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Period_pkey" PRIMARY KEY ("periodId")
);

-- CreateTable
CREATE TABLE "RequestCall" (
    "requestCallId" TEXT NOT NULL,
    "meterId" TEXT NOT NULL,
    "promptTokenCount" INTEGER NOT NULL,
    "promptTokenCost" DECIMAL(15,4) NOT NULL,
    "responseTokenCount" INTEGER NOT NULL,
    "responseTokenCost" DECIMAL(15,4) NOT NULL,
    "dateCreated" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "dateModified" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "RequestCall_pkey" PRIMARY KEY ("requestCallId")
);

-- CreateTable
CREATE TABLE "Meter" (
    "meterId" TEXT NOT NULL,
    "meterCuid" TEXT NOT NULL,
    "meterGroupId" TEXT,
    "customerId" TEXT NOT NULL,
    "softQuota" DECIMAL(15,4) NOT NULL,
    "hardQuota" DECIMAL(15,4) NOT NULL,
    "aiModel" TEXT NOT NULL,
    "dateCreated" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "dateModified" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Meter_pkey" PRIMARY KEY ("meterId")
);

-- CreateIndex
CREATE UNIQUE INDEX "Customer_userId_key" ON "Customer"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- AddForeignKey
ALTER TABLE "ApiKey" ADD CONSTRAINT "ApiKey_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Customer" ADD CONSTRAINT "Customer_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Period" ADD CONSTRAINT "Period_meterId_fkey" FOREIGN KEY ("meterId") REFERENCES "Meter"("meterId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RequestCall" ADD CONSTRAINT "RequestCall_meterId_fkey" FOREIGN KEY ("meterId") REFERENCES "Meter"("meterId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Meter" ADD CONSTRAINT "Meter_meterGroupId_fkey" FOREIGN KEY ("meterGroupId") REFERENCES "MeterGroup"("meterGroupId") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Meter" ADD CONSTRAINT "Meter_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES "Customer"("customerId") ON DELETE RESTRICT ON UPDATE CASCADE;

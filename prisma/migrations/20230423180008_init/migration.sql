/*
  Warnings:

  - A unique constraint covering the columns `[apiKeyCuid]` on the table `ApiKey` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[customerCuid]` on the table `Customer` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[meterCuid]` on the table `Meter` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[personCuid]` on the table `Person` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "ApiKey_apiKeyCuid_key" ON "ApiKey"("apiKeyCuid");

-- CreateIndex
CREATE UNIQUE INDEX "Customer_customerCuid_key" ON "Customer"("customerCuid");

-- CreateIndex
CREATE UNIQUE INDEX "Meter_meterCuid_key" ON "Meter"("meterCuid");

-- CreateIndex
CREATE UNIQUE INDEX "Person_personCuid_key" ON "Person"("personCuid");

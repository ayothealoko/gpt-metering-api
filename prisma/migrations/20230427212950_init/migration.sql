/*
  Warnings:

  - A unique constraint covering the columns `[modelName]` on the table `AiModel` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "AiModel_modelName_key" ON "AiModel"("modelName");

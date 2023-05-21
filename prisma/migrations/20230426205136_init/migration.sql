/*
  Warnings:

  - The values [GPT4_8k,GPT4_32k] on the enum `AiModel` will be removed. If these variants are still used in the database, this will fail.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "AiModel_new" AS ENUM ('GPT4', 'GPT3');
ALTER TABLE "RequestCall" ALTER COLUMN "aiModel" TYPE "AiModel_new" USING ("aiModel"::text::"AiModel_new");
ALTER TYPE "AiModel" RENAME TO "AiModel_old";
ALTER TYPE "AiModel_new" RENAME TO "AiModel";
DROP TYPE "AiModel_old";
COMMIT;

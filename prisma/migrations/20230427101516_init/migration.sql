-- CreateTable
CREATE TABLE "MeterPeriod" (
    "meterPerionId" TEXT NOT NULL,
    "meterId" TEXT NOT NULL,
    "startDate" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "endDate" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "isCanceled" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "MeterPeriod_pkey" PRIMARY KEY ("meterPerionId")
);

-- AddForeignKey
ALTER TABLE "MeterPeriod" ADD CONSTRAINT "MeterPeriod_meterId_fkey" FOREIGN KEY ("meterId") REFERENCES "Meter"("meterId") ON DELETE RESTRICT ON UPDATE CASCADE;

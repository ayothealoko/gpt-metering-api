import { getApiKeyModel } from "../model/apiKey.js";
import { getCustomerModelById } from "../model/customer.js";
import { getMeterModelByCuid } from "../model/meter.js";
import { MeterPeriod } from "@prisma/client";
import { createMeterPeriodModel } from "../model/meterPeriod.js";
import { AppError } from "../errors/appError.js";

export async function createMeterPeriodService(
  apiKey: string,
  meterCuid: string,
  startDate: Date,
  endDate: Date,
  periodType: MeterPeriod["periodType"]
): Promise<string> {
  const [apiModel, meterModel] = await Promise.all([
    getApiKeyModel(apiKey),
    getMeterModelByCuid(meterCuid),
  ]);

  const customerModel = await getCustomerModelById(meterModel.customerId);

  if (apiModel.personId === customerModel.personId) {
    const meterPeriod = await createMeterPeriodModel(
      meterCuid,
      startDate,
      endDate,
      periodType
    );
    return meterPeriod.meterPeriodCuid;
  } else {
    throw new AppError("No access to resource");
  }
}

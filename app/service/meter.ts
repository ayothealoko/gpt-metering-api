import { AppError } from "../errors/appError.js";
import { getApiKeyModel } from "../model/apiKey.js";
import { getCustomerModelByCuid } from "../model/customer.js";
import { createMeterModel } from "../model/meter.js";
import { Meter } from "@prisma/client";

export async function createMeterService(
  apiKey: string,
  customerCuid: string,
  softQuota: number,
  hardQuota: number,
  recurring: boolean
): Promise<string> {
  const [apiModel, customerModel] = await Promise.all([
    getApiKeyModel(apiKey),
    getCustomerModelByCuid(customerCuid),
  ]);

  if (apiModel.personId === customerModel.personId) {
    const meter = await createMeterModel(
      customerCuid,
      softQuota,
      hardQuota,
      recurring
    );
    return meter.meterCuid;
  } else {
    throw new AppError("No access to resource");
  }
}

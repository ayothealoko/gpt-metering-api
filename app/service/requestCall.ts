import { getMeterModelByCuid } from "../model/meter.js";
import { getApiKeyModel } from "../model/apiKey.js";
import { getCustomerModelById } from "../model/customer.js";
import { createRequestCallModel } from "../model/requestCall.js";
import { getAiModelByName } from "../model/aiModel.js";
import { AppError } from "../errors/appError.js";

export async function createRequestCallService(
  apiKey: string,
  meterCuid: string,
  promptTokenCount: number,
  responseTokenCount: number,
  aiModelName: string
) {
  const [apiModel, meterModel] = await Promise.all([
    getApiKeyModel(apiKey),
    getMeterModelByCuid(meterCuid),
  ]);

  const customerModel = await getCustomerModelById(meterModel.customerId);
  const aiModel = await getAiModelByName(aiModelName);

  try {
    if (apiModel.personId === customerModel.personId) {
      const quota = await createRequestCallModel(
        meterCuid,
        promptTokenCount,
        responseTokenCount,
        aiModel.aiModelId
      );
      return quota;
    }
    throw new AppError("No access to resource");
  } catch {
    throw new AppError("No access to resource");
  }
}

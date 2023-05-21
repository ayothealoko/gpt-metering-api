import { getMeterModelByCuid } from "../model/meter.js";
import { getApiKeyModel } from "../model/apiKey.js";
import { getCustomerModelById } from "../model/customer.js";
import { getSumForRequestCallModelByMeterId } from "../model/requestCall.js";
import { getRecentMeterModelPeriodByMeterId } from "../model/meterPeriod.js";
import { getAiModelById } from "../model/aiModel.js";
import { AppError } from "../errors/appError.js";

export type QuotaLimit = "below" | "softLimit" | "hardLimit" | "error";

export async function checkQuotaService(
  apiKey: string,
  meterCuid: string
): Promise<QuotaLimit> {
  const [apiModel, meterModel] = await Promise.all([
    getApiKeyModel(apiKey),
    getMeterModelByCuid(meterCuid),
  ]);

  const customerModel = await getCustomerModelById(meterModel.customerId);

  try {
    if (apiModel.personId === customerModel.personId) {
      const period = await getRecentMeterModelPeriodByMeterId(
        meterModel.meterId
      );
      if (period === null) {
        throw new AppError("No Valid Period Object");
      }
      const requestSums = await getSumForRequestCallModelByMeterId(
        meterModel.meterId,
        period.startDate,
        period.endDate
      );

      const aiModelPromise = requestSums.map((group) => {
        const aiModel = getAiModelById(group.aiModelId);
        return aiModel;
      });

      const aiModels = await Promise.all(aiModelPromise);

      const requestCost = requestSums.map((group, i) => {
        const promptTokenCount = group._sum.promptTokenCount;
        const promptPer1kTokens = Math.ceil(promptTokenCount / 1000);
        const responseTokenCount = group._sum.promptTokenCount;
        const responsePer1kTokens = Math.ceil(responseTokenCount / 1000);
        const aiModel = aiModels[i];
        const total =
          aiModel.promptCost * promptPer1kTokens +
          aiModel.completeionCost * responsePer1kTokens;
        return total;
      });

      const total = requestCost.reduce((totalCost, cost) => {
        return totalCost + cost;
      }, 0);

      if (total < meterModel.hardQuota) {
        if (total < meterModel.softQuota) {
          return "below";
        }
        return "softLimit";
      }
      return "hardLimit";
    }
  } catch {
    throw new AppError("No access to resource");
  }
}

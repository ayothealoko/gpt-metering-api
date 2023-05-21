import { getApiKeyModel } from "../model/apiKey.js";
import { createCustomerModel } from "../model/customer.js";

export async function createCustomerService(
  customerName: string,
  apiKeyCuid: string
): Promise<string> {
  const apiKeyModel = await getApiKeyModel(apiKeyCuid);
  const userId = apiKeyModel.personId;
  const customerModel = await createCustomerModel(customerName, userId);
  return customerModel.customerCuid;
}

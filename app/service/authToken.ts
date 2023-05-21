import { getApiKeyModel } from "../model/apiKey.js";

// Returns CUID
export async function authTokenService(token: string): Promise<boolean> {
  const apiKeyModel = await getApiKeyModel(token);
  if (apiKeyModel !== null && apiKeyModel.isValid === true) {
    return true;
  }
  // Return false if null or not valid
  return false;
}

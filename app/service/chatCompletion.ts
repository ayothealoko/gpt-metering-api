import axios from "axios";
import { getApiKeyModel } from "../model/apiKey.js";
import { getCustomerModelById } from "../model/customer.js";
import { getMeterModelByCuid } from "../model/meter.js";
import { AppError } from "../errors/appError.js";

interface MessagesItem {
  role: string;
  content: string;
  name?: string;
}

export async function postChatCompleteionService(
  apiKey: string,
  openai_api_key: string,
  //CUID
  meter_id: string,
  model: string,
  messages: MessagesItem[],
  temperature?: number,
  top_p?: number,
  n?: number,
  stop?: string | string[],
  max_tokens?: number,
  presence_penalty?: number,
  logit_bias?: object,
  user?: string
) {
  const [apiModel, meterModel] = await Promise.all([
    getApiKeyModel(apiKey),
    getMeterModelByCuid(meter_id),
  ]);

  const customerModel = await getCustomerModelById(meterModel.customerId);

  try {
    if (apiModel.personId === customerModel.personId) {
      const chatResponse = await axios.post(
        "https://api.openai.com/v1/chat/completions",
        {
          model,
          messages,
          temperature,
          top_p,
          n,
          stop,
          max_tokens,
          presence_penalty,
          logit_bias,
          user,
        },
        {
          headers: {
            Authorization: `Bearer ${openai_api_key}`,
          },
        }
      );

      return chatResponse.data;
    }
  } catch {
    throw new AppError("No access to resource");
  }
}

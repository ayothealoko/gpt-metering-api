import { Request, Response } from "express";
import { postChatCompleteionService } from "../service/chatCompletion.js";
import { createRequestCallService } from "../service/requestCall.js";
import { checkQuotaService } from "../service/quota.js";

export const postChatCompletionController = async (
  req: Request,
  res: Response
) => {
  const body = req.body;
  const apiKey = req.headers.authorization.split(" ")[1];
  const quotaCheck = await checkQuotaService(apiKey, body.meter_id);
  if (quotaCheck === "softLimit" || quotaCheck === "below") {
    const chatResponse = await postChatCompleteionService(
      apiKey,
      body.openai_api_key,
      body.meter_id,
      body.model,
      body.messages,
      body.temperature,
      body.top_p,
      body.n,
      body.stop,
      body.max_tokens,
      body.presence_penalty,
      body.logit_bias,
      body.user
    );
    const { prompt_tokens, completion_tokens, total_tokens } =
      chatResponse.usage;
    const requestCall = await createRequestCallService(
      apiKey,
      body.meter_id,
      prompt_tokens,
      completion_tokens,
      body.model
    );
    console.log(requestCall);
    res.status(200);
    res.send(chatResponse);
  } else {
    res.status(402);
    res.send("Exeeded quota");
  }
};

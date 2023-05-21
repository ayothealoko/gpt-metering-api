import { Request, Response } from "express";
import { createMeterService } from "../service/meter.js";

export const createMeterController = async (req: Request, res: Response) => {
  const body = req.body;
  const apiKey = req.headers.authorization.split(" ")[1];

  const meterCuid = await createMeterService(
    apiKey,
    body.customerId,
    body.softQuota,
    body.hardQuota,
    body.recurring
  );
  res.status(200);
  res.send(meterCuid);
};

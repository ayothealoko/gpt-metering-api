import { Request, Response } from "express";
import { createMeterPeriodService } from "../service/meterPeriod.js";
import { periodEndDate } from "../helpers/modelrange.js";

export const createMeterPeriodController = async (
  req: Request,
  res: Response
) => {
  const body = req.body;
  const apiKey = req.headers.authorization.split(" ")[1];
  const startDate = new Date(body.startDate);
  const endDate = periodEndDate(body.periodType, startDate);
  const meterCuid = await createMeterPeriodService(
    apiKey,
    body.meterId,
    startDate,
    endDate,
    body.periodType
  );
  res.status(200);
  res.send(meterCuid);
};

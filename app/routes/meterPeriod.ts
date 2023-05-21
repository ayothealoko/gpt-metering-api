import { authToken } from "../middleware/authToken.js";
import { jsonParser } from "../middleware/bodyparser.js";
import { Router } from "express";
import { createMeterPeriodSchema } from "../validation/meterPeriod.js";
import { createMeterPeriodController } from "../controllers/meterPeriod.js";
import { tryCatch } from "../helpers/tryCatch.js";

const router = Router();

const postMiddleware = [jsonParser, authToken, createMeterPeriodSchema];

router.post("/", postMiddleware, tryCatch(createMeterPeriodController));

export default router;

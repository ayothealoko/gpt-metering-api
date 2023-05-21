import { createMeterController } from "../controllers/meter.js";
import { tryCatch } from "../helpers/tryCatch.js";
import { authToken } from "../middleware/authToken.js";
import { jsonParser } from "../middleware/bodyparser.js";
import { createMeterSchema } from "../validation/meter.js";
import { Router } from "express";

const router = Router();

const postMiddleware = [jsonParser, authToken, createMeterSchema];

router.post("/", postMiddleware, tryCatch(createMeterController));

export default router;

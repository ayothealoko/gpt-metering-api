import { createCustomerController } from "../controllers/customer.js";
import { authToken } from "../middleware/authToken.js";
import { jsonParser } from "../middleware/bodyparser.js";
import { createCustomerSchema } from "../validation/customer.js";
import { Router } from "express";

const router = Router();

const postMiddleware = [jsonParser, authToken, createCustomerSchema];

router.post("/", postMiddleware, createCustomerController);

export default router;

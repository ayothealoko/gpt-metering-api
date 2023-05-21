import { createUserController } from "../controllers/user.js";
import { jsonParser } from "../middleware/bodyparser.js";
import { createUserSchema } from "../validation/user.js";
import { Request, Response, Router } from "express";
import { tryCatch } from "../helpers/tryCatch.js";

const router = Router();

const postMiddleware = [jsonParser, createUserSchema];

router.post("/", postMiddleware, tryCatch(createUserController));

export default router;

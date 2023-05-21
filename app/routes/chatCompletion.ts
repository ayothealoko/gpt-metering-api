import { postChatCompletionController } from "../controllers/chatCompletion.js";
import { authToken } from "../middleware/authToken.js";
import { jsonParser } from "../middleware/bodyparser.js";
import { postChateCompletionSchema } from "../validation/chatCompletion.js";
import { Router } from "express";

const router = Router();

const postMiddleware = [jsonParser, authToken, postChateCompletionSchema];

router.post("/", postMiddleware, postChatCompletionController);

export default router;

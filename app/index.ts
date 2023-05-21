import express, { Express } from "express";
import * as dotenv from "dotenv";
import {
  chatCompletion,
  customerRouter,
  meterPeriod,
  meterRouter,
  userRouter,
} from "./routes/index.js";
import { apiErrorHandler } from "./middleware/apiErrorHandler.js";

dotenv.config();
const app: Express = express();

app.use("/v1/user", userRouter);
app.use("/v1/customer", customerRouter);
app.use("/v1/meter", meterRouter);
app.use("/v1/meter/period", meterPeriod);
app.use("/v1/chat/completion", chatCompletion);
app.use("/v1", apiErrorHandler);

const server = app.listen(8000, function () {
  let host = "null";
  let port = -1;
  const address = server.address();

  if (address !== null && typeof address !== "string") {
    host = address.address;

    port = address.port;
  }

  console.log("App listening at http://%s:%s", host, port);
});

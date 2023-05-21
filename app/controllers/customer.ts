import { Request, Response } from "express";
import { createCustomerService } from "../service/customer.js";

export const createCustomerController = async (req: Request, res: Response) => {
  const body = req.body;
  const apiKey = req.headers.authorization.split(" ")[1];
  const customerId = await createCustomerService(body.name, apiKey);
  res.status(200);
  res.send(customerId);
};

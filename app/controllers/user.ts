import { Request, Response } from "express";
import { CreateUserService, createUserService } from "../service/user.js";
export const createUserController = async (req: Request, res: Response) => {
  const body = req.body;
  const user: CreateUserService = {
    email: body.email,
    name: body.name,
    password: body.password,
  };
  const personId = await createUserService(user);
  res.status(200);
  res.send(personId);
};

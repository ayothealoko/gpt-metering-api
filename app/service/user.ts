import bcrypt from "bcrypt";
import { SALTROUNDS } from "../constants.js";
import { createUserModel } from "../model/user.js";

export interface CreateUserService {
  email: string;
  name: string;
  password: string;
}

// Returns CUID
export async function createUserService(
  user: CreateUserService
): Promise<string> {
  const hashPwd = await bcrypt.hash(user.password, SALTROUNDS);
  const createdUser = await createUserModel({ ...user, hash: hashPwd });
  return createdUser.personCuid;
}

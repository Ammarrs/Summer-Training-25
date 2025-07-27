import { Request, Response } from "express";
import bcrypt from 'bcrypt';
import { registerValidation } from "../models/user";
import { findUserByEmail, createUser } from "../repo/userRepo";

type UserInput = {
  username: string;
  email: string;
  password: string;
  college: string;
  major: string;
};

export const register = async (req: Request, res: Response) => {
  try {
    const { error } = registerValidation(req.body);
    if (error) {
      return res.status(400).json({ error: error.details[0].message });
    }

    const { username, email, password, college, major} = req.body;

    const existingUser = await findUserByEmail(email);
    if (existingUser) {
      res.status(409).json({ error: "Email already in use" })
    }

    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(password, salt);

    const newUser: UserInput = {
      username,
      email,
      password: hashedPassword,
      college,
      major
    };

    const savedUser = await createUser(newUser);
    return res.status(200).json({ message: "User created Successfully" });
  } catch (err) {
    console.log("error: ", err);
    return res.status(500).json({ error: "internal server error" });
  }
}
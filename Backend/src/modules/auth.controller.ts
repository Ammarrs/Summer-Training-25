import { Request, Response } from "express";
import bcrypt from 'bcrypt';
import jwt from 'jsonwebtoken';
import { Gender, loginValidation, registerValidation, userModel } from "../models/user";
import { findUserByEmail, createUser } from "../repo/userRepo";
import { sendEmail } from "../utils/sendEmail";
import { mongo } from "mongoose";

const secretKey = process.env.JWT_SECRET || "supersecretsecret";
const host = process.env.HOST || "localhost";

type UserInput = {
  username: string;
  email: string;
  password: string;
  college: string;
  major: string;
  gender: Gender;
};

export const register = async (req: Request, res: Response) => {
  try {
    const { error } = registerValidation(req.body);
    if (error) {
      return res.status(400).json({ error: error.details[0].message });
    }

    const { username, email, password, college, major, gender } = req.body;

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
      major,
      gender,
    };

    const savedUser = await createUser(newUser);

    if (!savedUser) {
      return res.status(500).json({ error: "User could not be saved." });
    }

    const emailToken = jwt.sign(
      { userId: savedUser._id },
      secretKey,
      { expiresIn: "1h" }
    );

    const verifyUrl = `http://${host}:5000/api/auth/verify-email?token=${emailToken}`;

    await sendEmail(
      newUser.email,
      "Verify Your Email",
      `<h1>Click below to verify</h1><a href="${verifyUrl}">Verify Email</a>`
    );

    return res.status(200).json({ message: "User created Successfully" });
  } catch (err) {
    console.log("error: ", err);
    return res.status(500).json({ error: "internal server error" });
  }
}

export const login = async (req: Request, res: Response) => {
  try {
    const { error } = loginValidation(req.body);
    if (error) {
      return res.status(400).json({ error: error.details[0].message });
    }

    const { email, password } = req.body;

    const user = await findUserByEmail(email);
    if(!user) {
      return res.status(401).json({ error: "invalid email or password" });
    }

    //! user can be null -> resolved
    const isMatch = await bcrypt.compare(password, user.password);

    if(!isMatch) {
      res.status(401).json({ error: "invalid email or password" });
    }

    const token = jwt.sign({userId: user?._id, email: user?.email}, secretKey, { expiresIn: "1d" });

    return res.status(200).json({ message: "login successful", token, user: {
      username: user?.username,
      email: user?.email,
      college: user?.college,
      major: user?.major,
    } });
  } catch (err) {
    console.log("Login error: ", err);
    return res.status(500).json({ error: "internal server error" })
  }
}

//* view problems is user.userId or user._id ?
// todo make the function if needed
//? what is that 
export const updateUser = async (req: Request, res:Response) => {
  const userId = (req as any).user.userId;
}

// todo make the function if needed
export const deleteUser = async (req: Request, res: Response) => {

}


export const verifyEmail = async (req: Request, res: Response) => {
  const token = req.query.token as string;

  if(!token) return res.status(400).json({ error: "Token missing" });

  try {
    const decoded = jwt.verify(token, secretKey);
    const userId = typeof decoded === "object" && "userId" in decoded ? (decoded as { userId: string }).userId : null;
    if (!userId) {
      return res.status(400).json({ error: "Invalid token payload" });
    }
    const user = await userModel.findById(userId);
    if(!user) return res.status(404).json({ error: "user not found" });

    if(user.verified) return res.status(200).json({ message: "Already verified" });

    user.verified = true;
    await user.save();

    res.status(200).json({ message: "Email verified successfully" });
  } catch (err) {
    res.status(400).json({ error: "Invalid or expired token" });
  }
}


export const forgotPassword = async (req:Request, res: Response) => {
  const { email } = req.body;

  try {
    const user = await userModel.findOne({ email });
    if (!user) {
      return res.status(404).json({ error: "email not found" });
    }

    const resetToken = jwt.sign(
      { userId: user._id },
      secretKey,
      { expiresIn: "15m" }
    );

    //todo: convert localhost with the process.env.HOST
    const resetUrl = `http://${host}:5000/api/auth/reset-password?token=${resetToken}`;

    await sendEmail(
      user.email,
      "Reset your password",
      `<h1>Password Reset</h1><p>Click below to reset your password:</p><a href="${resetUrl}">Reset Password</a>`
    );

    res.status(200).json({ message: "reset link sent to email" });

  } catch (error) {
    res.status(500).json({ error: "internal server error" });
  }
}

export const resetPassword = async (req: Request, res: Response) => {
  const token = req.query.token as string;
  const { password, confirmPassword } = req.body;

  if(!token) return res.status(400).json({ error: "invalid token" });

  if(password != confirmPassword) return res.status(400).json({ error: "password don't match" });

  try {
    const decode = jwt.verify(token, secretKey!) as { userId: string };
    const hashedPassword = await bcrypt.hash(password, 10);

    const user = await userModel.findByIdAndUpdate(decode.userId, { password: hashedPassword }, { new: true });

    if(!user) {
      return res.status(404).json({ error: "user not found" });
    }

    res.status(200).json({ message: "password updated" })
  } catch (error) {
    res.status(400).json({ error: "invalid token" });
  }

}
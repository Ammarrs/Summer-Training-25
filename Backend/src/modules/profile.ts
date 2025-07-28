import { Request, Response } from "express";
import { findUserById, updateUser } from "../repo/userRepo";

export const getProfile = async (req: Request, res: Response) => {
  const userId = (req as any).user.userId;

  const user = await findUserById(userId);
  if (!user) return res.status(404).json({ error: "User not found" });

  res.status(200).json({
    username: user.username,
    email: user.email,
    college: user.college,
    major: user.major
  });
};

export const updateProfile = async (req: Request, res: Response) => {
  const userId = (req as any).user.userId;
  const updates = req.body; // assume you're validating this in frontend

  const updated = await updateUser(userId, updates);
  if (!updated) return res.status(404).json({ error: "User not found" });

  res.status(200).json({ message: "Profile updated successfully" });
};

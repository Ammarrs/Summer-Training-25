import { Request, Response, NextFunction } from "express";
import jwt from 'jsonwebtoken';

const secretKey = process.env.JWT_SECRET || "supersecretsecret";

export const authenticate = (req: Request, res: Response, next: NextFunction) => {
  //! authorization does not exist in the header -> fixed headers not header
  const authHeader = req.headers.authorization;


  if (!authHeader || !authHeader.startsWith("Bearer ")) {
    return res.status(401).json({ error: "Access denied, no token provided." })
  }

  const token = authHeader.split(" ")[1];

  try {
    const decode = jwt.verify(token, secretKey);
    (req as any).user = decode;
    next();
  } catch (error) {
    return res.status(403).json({ error: "Invalid Token" });
  }
}
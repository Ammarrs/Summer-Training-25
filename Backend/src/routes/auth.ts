import express, { Request, Response } from 'express';
import { login, register, resetPassword, updateUser, deleteUser, forgotPassword, verifyEmail } from '../modules/auth.controller';
import { authenticate } from "../middlewares/auth";
const router = express.Router();

router.post("/register", register);
router.post("/login", login);
router.post("/forgot-password", forgotPassword);
router.post("/reset-password", resetPassword); // token in query body has new pass
router.get("/verify-email", verifyEmail)

//? will be provided after finishing the functions
//? router.put("/update", authenticate, updateUser);
//? router.delete("/delete", authenticate, deleteUser);

export default router;
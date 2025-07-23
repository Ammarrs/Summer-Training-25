import express, { Request, Response } from 'express';
import { register } from '../modules/auth';
const router = express.Router();

router.post("/register", register);

export default router;
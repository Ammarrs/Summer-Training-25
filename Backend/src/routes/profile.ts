import express from "express";
import { getProfile, updateProfile } from "../modules/profile";
import { authenticate } from "../middlewares/auth";

const router = express.Router();

router.get("/", authenticate, getProfile);
router.put("/", authenticate, updateProfile);

export default router;

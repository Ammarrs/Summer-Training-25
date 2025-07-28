import { Router } from "express";
import { analyzePerformance } from "../modules/performance";

const router = Router();

router.post("/performance", analyzePerformance);

export default router;

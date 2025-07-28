import { Request, Response } from "express";
import { sendToPerformanceAnalyzer } from "../utils/ai";

export const analyzePerformance = async (req: Request, res: Response) => {
  try {
    const result = await sendToPerformanceAnalyzer(req.body);
    return res.status(200).json({ message: "Analysis complete", result });
  } catch (err: any) {
    return res.status(500).json({ error: err.message });
  }
};

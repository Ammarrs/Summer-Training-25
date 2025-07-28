import express from "express";
import multer from "multer";
import { sendChatMessage, sendMood } from "../utils/aiClient";

const upload = multer();
const router = express.Router();

router.post("/chat", upload.single("file"), async (req, res) => {
  try {
    const file = req.file?.buffer;
    const message = req.body.message;
    const response = await sendChatMessage(message, file);
    res.json(response);
  } catch (err: any) {
    res.status(500).json({ error: "AI Chat failed", details: err.message });
  }
});

router.post("/mood", async (req, res) => {
  try {
    const { mood } = req.body;
    const response = await sendMood(mood);
    res.json(response);
  } catch (err) {
    res.status(500).json({ error: "AI Mood failed", details: err.message });
  }
});

export default router;

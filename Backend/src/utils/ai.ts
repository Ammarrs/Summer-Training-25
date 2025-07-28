import axios from "axios";
import { ScheduleInput } from "../types/schedule";

const ai_url = process.env.AI_SERVICE_URL || "http://localhost:5000/generate-schedule";
const reschedule_url = process.env.AI_RESCHEDULE_URL || "http://localhost:5000/reschedule";
const ai_analyze_url = process.env.AI_ANALYZE_URL || "http://localhost:5000/analyze";

export const sendToAi = async (data: ScheduleInput) =>  {
  try {
    const response = await axios.post(ai_url, data);
    return response.data;
  } catch (error: any) {
    throw new Error("Failed to connect to ai service");
  }
}

export const sendRescheduleToAi = async (data: any) => {
  try {
    const response = await axios.post(reschedule_url, data);
    return response.data;
  } catch (error: any) {
    console.error("AI Rescheduler error:", error.response?.data || error.message);
    throw new Error("Failed to connect to AI rescheduler");
  }
};

export const sendToPerformanceAnalyzer = async (data: any) => {
  try {
    const res = await axios.post(ai_analyze_url, data);
    return res.data;
  } catch (err: any) {
    console.error("AI Analyze Error:", err.response?.data || err.message);
    throw new Error("Failed to analyze study performance");
  }
};

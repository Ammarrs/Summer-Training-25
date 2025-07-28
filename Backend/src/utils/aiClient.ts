import axios from "axios";
import FormData from "form-data";
const AI_BASE_URL = "http://192.168.1.101:5050"; // update IP & port

export const sendChatMessage = async (message: string, file?: Buffer) => {
  const formData = new FormData();
  formData.append("message", message);
  if (file) formData.append("file", file, "study.pdf");

  const response = await axios.post(`${AI_BASE_URL}/chat`, formData, {
    headers: formData.getHeaders()
  });

  return response.data;
};

export const sendMood = async (mood: string) => {
  const res = await axios.post(`${AI_BASE_URL}/mood`, { mood });
  return res.data;
};

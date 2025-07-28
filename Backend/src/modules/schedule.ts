import { Request, Response } from 'express';
import { scheduleValidation, rescheduleValidation } from '../validations/schedule';
import { sendToAi, sendRescheduleToAi } from '../utils/ai';

export const generateSchedule = async (req: Request, res: Response) => {
  try {
    const { error } = scheduleValidation(req.body);
    if(error) {
      return res.status(400).json({ error: error.details[0].message });
    }

    const scheduleData = req.body;

    // TODO: send to ai logic
    const aiResponse = await sendToAi(scheduleData);

    return res.status(200).json({ message: "schedule resieved successfully", data: scheduleData });
  } catch (error) {
    return res.status(500).json({ error: "internal server error" });
  }
}

export const reschedule = async (req: Request, res: Response) => {
  const { error } = rescheduleValidation(req.body);
  if (error) return res.status(400).json({ error: error.details[0].message });

  try {
    const newSchedule = await sendRescheduleToAi(req.body);
    return res.status(200).json({ message: "Schedule updated", schedule: newSchedule });
  } catch (err: any) {
    return res.status(500).json({ error: err.message });
  }
}


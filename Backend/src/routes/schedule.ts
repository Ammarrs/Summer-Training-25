import { Router } from 'express';
import { generateSchedule, reschedule } from '../modules/schedule';
const router = Router();

router.post("/schedule", generateSchedule);
router.post("/reschedule", reschedule);

export default router;
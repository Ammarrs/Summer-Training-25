import Joi from "joi";

export const scheduleValidation = (data: any) => {
  return Joi.object({
    courses: Joi.array().items(
      Joi.object({
        name: Joi.string().required(),
        type: Joi.string().valid("theoretical", "practical").required(),
        structure: Joi.string().valid("chapter", "topic").required(),
        difficulty: Joi.string().valid("easy", "medium", "hard").required(),
      })
    ).min(1).required(),

    availability: Joi.object().pattern(
      Joi.string(), // Day name (e.g. "Monday")
      Joi.array().items(
        Joi.string().pattern(/^([01]\d|2[0-3]):(00|30)$/).required()
      )
    ).required(),

    schedule_scope: Joi.string().valid("week", "month").required(),

    study_preferences: Joi.object({
      study_speed: Joi.string().valid("slow", "average", "fast").required(),
      memorization_vs_understanding: Joi.number().min(0).max(10).required(),
      self_rating: Joi.number().min(1).max(5).required(),
      session_style: Joi.string().valid("continuous", "interrupted").required(),
    }).required(),

    max_blocks_per_day: Joi.number().min(1).max(12).optional(),
  }).validate(data);
}

export const rescheduleValidation = (data: any) => {
  const schema = Joi.object({
    original_schedule: Joi.array().items(
      Joi.object({
        day: Joi.string().required(),
        time: Joi.string().required(),
        course: Joi.string().required(),
        part: Joi.string().required(),
      })
    ).required(),
    unfinished_blocks: Joi.array().items(
      Joi.object({
        day: Joi.string().required(),
        time: Joi.string().required(),
        course: Joi.string().required(),
        part: Joi.string().required(),
      })
    ).required(),
    updated_availability: Joi.object().pattern(
      Joi.string(),
      Joi.array().items(Joi.string())
    ).required(),
    max_blocks_per_day: Joi.number().optional()
  });

  return schema.validate(data);
};
export type CourseType = "thoeretical" | "practical";
export type StructureType = "topic" | "chapter";
export type StudySpeed = "slow" | "average" | "fast";
export type StudyStyle = "continues" | "interrupted";

export interface TimeSlot {
  startTime: string; //? e.g. 01:00
  endTime: string; //? same
}

export interface Availability {
  [day: string]: string[]
}

// export interface Availability {
//   day: string;
//   slots: TimeSlot[];
// }

export interface Course {
  name: string;
  type: CourseType;
  structure: StructureType;
  difficulty: "easy" | "medium" | "hard";
}

export interface StudyPreferences {
  studySpeed: StudySpeed;
  ability: number; // memorization 0 to 10 understanding
  self_rating: number; // 1 to 5
  session_style: StudyStyle;
}

export interface ScheduleInput {
  courses: Course[];
  numberOfAvailableDays: number;
  availability: Availability;
  schedule_scope: "week" | "month";
  study_preferences: StudyPreferences;
  max_blocks_per_day?: number;
}


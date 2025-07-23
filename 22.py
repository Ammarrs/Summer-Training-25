from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from typing import List, Dict
from collections import defaultdict

app = FastAPI()

# --- Models ---
class Course(BaseModel):
    name: str
    type: str  # "theoretical" or "practical"
    structure: str  # "chapter" or "topic"
    difficulty: str  # "easy", "medium", "hard"

class ScheduleRequest(BaseModel):
    courses: List[Course]
    availability: Dict[str, List[str]]  # e.g. {"Monday": ["14:00", "14:30"]}
    schedule_scope: str  # "day", "week", or "month"
    max_blocks_per_day: int = 4  # Optional with default

class ScheduleItem(BaseModel):
    day: str
    time: str
    course: str
    part: str

# --- Difficulty Score Mapping ---
difficulty_score = {"easy": 1, "medium": 2, "hard": 3}

# --- Capitalize Helper ---
def capitalize(word: str) -> str:
    return word[0].upper() + word[1:] if word else word

# --- Endpoint ---
@app.post("/generate-schedule", response_model=List[ScheduleItem])
def generate_schedule(data: ScheduleRequest):
    courses = data.courses
    availability = data.availability
    max_blocks_per_day = data.max_blocks_per_day

    # Step 1: Compute needed study blocks per course
    course_blocks = {
        course.name: difficulty_score[course.difficulty] * 4
        for course in courses
    }

    # Step 2: Flatten timeslots
    all_slots = []
    for day, times in availability.items():
        for time in times:
            all_slots.append((day, time))

    total_needed = sum(course_blocks.values())
    if total_needed > len(all_slots):
        raise HTTPException(status_code=400, detail="Not enough available timeslots.")

    # Step 3: Sort courses by difficulty (hardest first)
    sorted_courses = sorted(courses, key=lambda c: difficulty_score[c.difficulty], reverse=True)

    # Step 4: Schedule with per-day limit
    schedule = []
    blocks_per_day = defaultdict(int)
    slot_index = 0

    for course in sorted_courses:
        blocks = course_blocks[course.name]
        part_number = 1

        while blocks > 0 and slot_index < len(all_slots):
            day, time = all_slots[slot_index]

            if blocks_per_day[day] >= max_blocks_per_day:
                slot_index += 1
                continue

            part = f"{capitalize(course.structure)} {part_number}"
            schedule.append(ScheduleItem(
                day=day,
                time=time,
                course=course.name,
                part=part
            ))

            blocks_per_day[day] += 1
            blocks -= 1
            part_number += 1
            slot_index += 1

    return schedule

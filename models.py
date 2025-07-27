from typing import List, Dict
from dataclasses import dataclass

@dataclass
class Course:
    name: str
    type: str         # "theoretical" or "practical"
    structure: str    # "chapter" or "topic"
    difficulty: str   # "easy", "medium", or "hard"

@dataclass
class ScheduleRequest:
    courses: List[Course]
    availability: Dict[str, List[str]]
    schedule_scope: str         # "day", "week", or "month"
    max_blocks_per_day: int = 4

@dataclass
class ScheduleItem:
    day: str
    time: str
    course: str
    part: str
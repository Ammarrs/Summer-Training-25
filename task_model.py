from dataclasses import dataclass

@dataclass
class TaskModel:
    course: str
    part: str
    status: str
    actual_time: int
    difficulty: int

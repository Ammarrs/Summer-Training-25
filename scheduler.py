from collections import defaultdict
from models import Course, ScheduleRequest, ScheduleItem
from utils import difficulty_score, capitalize

def generate_schedule(data: ScheduleRequest) -> list[ScheduleItem]:
    courses = data.courses
    availability = data.availability
    max_blocks_per_day = data.max_blocks_per_day

    course_blocks = {
        course.name: difficulty_score[course.difficulty] * 4
        for course in courses
    }

    all_slots = []
    for day, times in availability.items():
        for time in times:
            all_slots.append((day, time))

    total_needed = sum(course_blocks.values())
    if total_needed > len(all_slots):
        raise ValueError("Not enough available timeslots.")

    sorted_courses = sorted(courses, key=lambda c: difficulty_score[c.difficulty], reverse=True)

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

            schedule.append(ScheduleItem(
                day=day,
                time=time,
                course=course.name,
                part=f"{capitalize(course.structure)} {part_number}"
            ))

            blocks_per_day[day] += 1
            blocks -= 1
            part_number += 1
            slot_index += 1

    return schedule
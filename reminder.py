#not complete
import os
import json
from datetime import datetime

def load_schedule(user_id: str):
    file_path = f"data/{user_id}_schedule.json"
    if os.path.exists(file_path):
        with open(file_path, "r") as f:
            return json.load(f)
    return None

def get_today_tasks(user_id: str) -> list:
    schedule = load_schedule(user_id)
    if not schedule:
        return []

    today_key = f"day_{get_study_day(user_id)}"
    return schedule.get(today_key, [])

def get_study_day(user_id: str) -> int:
   
    start_date_path = f"data/{user_id}_start_date.txt"
    today = datetime.now().date()

    if not os.path.exists(start_date_path):
        with open(start_date_path, "w") as f:
            f.write(today.isoformat())
        return 1

    with open(start_date_path, "r") as f:
        start_date = datetime.fromisoformat(f.read()).date()

    delta = (today - start_date).days + 1
    return max(1, delta)

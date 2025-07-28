from collections import defaultdict
from helper import clamp_difficulty
from task_model import TaskModel

class PerformanceAnalyzer:

    def analyze(self, tasks: list[TaskModel]) -> dict:
        SLOT_TIME = 30
        total_tasks = len(tasks)
        done_tasks = [t for t in tasks if t.status == 'done']

        completion_score = (len(done_tasks) / total_tasks) * 100 if total_tasks else 0

        efficiency_sum = 0
        total_effort = 0
        course_progress = defaultdict(list)
        course_scores = defaultdict(list)

        for t in done_tasks:
            course = t.course
            part = t.part
            actual = t.actual_time
            difficulty = clamp_difficulty(t.difficulty)

            course_progress[course].append(part)

            efficiency = (SLOT_TIME / actual) * 100 if actual > 0 else 0
            efficiency_sum += efficiency

            effort = (actual / SLOT_TIME) * difficulty
            total_effort += effort

            course_scores[course].append((efficiency, effort))

        avg_efficiency = efficiency_sum / len(done_tasks) if done_tasks else 0
        efficiency_score = min(avg_efficiency, 100)

        avg_effort = total_effort / len(done_tasks) if done_tasks else 5
        effort_score = min((5 / avg_effort) * 100, 100)

        final_score = 0.4 * completion_score + 0.3 * efficiency_score + 0.3 * effort_score
        grade = self._get_grade(final_score)

        weak_courses = []
        strong_courses = []
        for course, scores in course_scores.items():
            avg_eff = sum(s[0] for s in scores) / len(scores)
            avg_effort = sum(s[1] for s in scores) / len(scores)
            if avg_eff < 60 or avg_effort > 1.5:
                weak_courses.append(course)
            elif avg_eff >= 80 and avg_effort <= 1.2:
                strong_courses.append(course)

        return {
            "completion": f"{len(done_tasks)} / {total_tasks}",
            "completion_score": round(completion_score, 2),
            "efficiency_score": round(efficiency_score, 2),
            "effort_score": round(effort_score, 2),
            "final_score": round(final_score, 2),
            "grade": grade,
            "course_progress": course_progress,
            "weak_courses": weak_courses,
            "strong_courses": strong_courses
        }

    def _get_grade(self, score):
        if score >= 90: return "A"
        elif score >= 80: return "B"
        elif score >= 70: return "C"
        elif score >= 60: return "D"
        elif score >= 50: return "E"
        else: return "F"

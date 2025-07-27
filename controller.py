from service import PerformanceAnalyzer
from task_model import TaskModel

def handle_performance_report(data):
    tasks_data = data.get("tasks", [])
    tasks = [TaskModel(**task) for task in tasks_data]

    analyzer = PerformanceAnalyzer()
    report = analyzer.analyze(tasks)
    return report

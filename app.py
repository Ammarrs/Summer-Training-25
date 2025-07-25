from flask import Flask, request, jsonify
from models import Course, ScheduleRequest, ScheduleItem
from scheduler import generate_schedule

app = Flask(__name__)

@app.route("/generate-schedule", methods=["POST"])
def schedule_endpoint():
    try:
        data = request.get_json()

        courses = [Course(**c) for c in data.get("courses", [])]
        availability = data.get("availability", {})
        schedule_scope = data.get("schedule_scope", "week")
        max_blocks_per_day = data.get("max_blocks_per_day", 4)

        request_data = ScheduleRequest(
            courses=courses,
            availability=availability,
            schedule_scope=schedule_scope,
            max_blocks_per_day=max_blocks_per_day
        )

        result = generate_schedule(request_data)

        return jsonify([item.__dict__ for item in result])

    except ValueError as ve:
        return jsonify({"error": str(ve)}), 400
    except Exception as e:
        return jsonify({"error": "Invalid input or server error."}), 500

if __name__ == "__main__":
    app.run(debug=True)
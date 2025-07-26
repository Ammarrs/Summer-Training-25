from flask import Blueprint, request, jsonify
from controller import handle_performance_report

performance_api = Blueprint('performance_api', __name__)

@performance_api.route("/analyze", methods=["POST"])
def analyze():
    data = request.get_json()
    result = handle_performance_report(data)
    return jsonify(result)

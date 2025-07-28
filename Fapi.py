from flask import Flask, request, jsonify
from chatbot import extract_text_from_pdf, summarize_text, generate_questions, handle_chat
from mood_based import get_mood_response
from reminder import get_today_tasks

app = Flask(__name__)

@app.post('/mood')
def mood_response():
    data = request.get_json()
    mood = data.get('mood', '').lower()

    response = get_mood_response(mood)
    return jsonify(response)

@app.get("/get-reminder")
def get_reminder():
    user_id = request.args.get("user_id", "default_user")
    tasks = get_today_tasks(user_id)

    if not tasks:
        return jsonify({
            "message": "You don't have any tasks for today!",
            "tasks": []
        })

    message = "Don't forget your tasks today!"
    return jsonify({
        "message": message,
        "tasks": tasks
    })



@app.post("/chat")
def chat():
    if 'message' not in request.form:
        return jsonify({"error": "Please include a message in the request."}), 400

    message = request.form['message']
    file = request.files.get('file')  # Optional PDF file

    file_bytes = file.read() if file else None

    try:
        response = handle_chat(message, file_bytes)
        return jsonify({"response": response})
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.post('/process_pdf')
def process_pdf():
    if 'file' not in request.files or 'mode' not in request.form:
        return jsonify({'error': 'Please upload a file and specify mode (summary/questions/both)'}), 400

    file = request.files['file']
    mode = request.form['mode'].strip().lower()
    file_bytes = file.read()

    try:
        text = extract_text_from_pdf(file_bytes)

        if mode == 'summary':
            result = summarize_text(text)
            return jsonify({'summary': result})
        
        elif mode == 'questions':
            result = generate_questions(text)
            return jsonify({'questions': result})
        
        elif mode == 'both':
            summary = summarize_text(text)
            questions = generate_questions(text)
            return jsonify({
                'summary': summary,
                'questions': questions
            })

        else:
            return jsonify({'error': 'Invalid mode. Use "summary", "questions", or "both".'}), 400

    except Exception as e:
        print("Error:", str(e))   #ده هيطبع الايرور الحقيقي في التيرمنال
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True)
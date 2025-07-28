import random

mood_responses = {
    "super": {
        "messages": [
            "You're on fire today! Keep it up!",
            "Amazing energy! Let's make the most of it!",
        ],
        "question": "You're full of energy! Would you like to add more study tasks today?",
        "options": ["Add Tasks", "Keep plan"]
    },
    "cheerful": {
        "messages": [
            "You're in a great mood! Let's get productive",
            "Smiles and studies go well together",
        ],
        "question": "Feeling cheerful! Want to schedule a fun subject today?",
        "options": ["Reschedle", "keep Plan"]
    },
    "happy": {
        "messages": [
            "Great vibes! Keep pushing forward!",
            "You're doing well! Let's keep that momentum!",
        ],
        "question": "Feeling happy today. Want to boost your study load?",
        "options": ["Add Task", "Keep Plan"]
    },
    "normal": {
        "messages": [
            "A normal day is a good day to grow. Let's get started!",
            "Consistency beats mood. Let's go!",
        ],
        "question": "Wanna continue as planned or add a task?",
        "options": ["Keep plan", "Add Task"]
    },
    "tired": {
        "messages": [
            "It's okay to feel tired. Let's do something light.",
            "Rest is important too. Let's go easy today.",
        ],
        "question": "You're feeling tired. Want to reduce today's load?",
        "options": ["Reduce Tasks", "Skip Today", "Take Break"]
    },
    "sad": {
        "messages": [
            "You're not alone. Let's take it one small step at a time.",
            "Sending you good energy. Just do your best.",
        ],
        "question": "Would you prefer light tasks or take a break today?",
        "options": ["Reduce Tasks", "Skip Today"]
    },
    "bored": {
        "messages": [
            "Let's shake things up! Try a new topic today.",
            "Boredom is a sign to challenge yourself!",
        ],
        "question": "Want to try something new or gamify your session?",
        "options": ["Reschedle","Keep plan"]
    }
}

def get_mood_response(mood: str):
    mood = mood.lower()
    if mood not in mood_responses:
        return {
            "message": "Mood not recognized.",
            "question": "",
            "options": []
        }
    
    data = mood_responses[mood]
    return {
        "message": random.choice(data["messages"]),
        "question": data["question"],
        "options": data["options"]
    }
import transformers as t
import fitz  # PyMuPDF
import random
from chats import chat_with_student

summarizer = t.pipeline("summarization", model="facebook/bart-large-cnn")
question_generator = t.pipeline("text-generation", model="gpt2")

def extract_text_from_pdf(file_bytes):
    doc = fitz.open(stream=file_bytes, filetype="pdf")
    text = ""
    for page in doc:
        text += page.get_text()
    return text


def summarize_text(text):
    if len(text) > 1024:
        text = text[:1024]
    summary = summarizer(text, max_length=200, min_length=30, do_sample=False)
    return summary[0]['summary_text']

def generate_questions(text):
    if len(text) > 700:
        text = text[:700]
    
    prompt = f"Generate 3 quiz questions from the following study material:\n{text}\nQuestions:"
    output = question_generator(prompt, max_length=200, num_return_sequences=1)[0]['generated_text']
    return output.split("Questions:")[-1].strip()

def generate_praise():
    praise_list = [
        "Great job! Keep it up.",
        "Awesome work! Proud of you.",
        "You did amazing!",
        "Task complete! You're crushing it!",
        "Every step takes you closer to your goal!",
        "You're brilliant! Keep shining!",
        "Your success is showing—keep going!",
        "You're doing fantastic!",
        "That's the spirit! Keep going!",
        "Nothing can stop you—well done!",
        "Excellent work!",
        "Your effort truly stands out!",
        "You're proving yourself every day!",
        "Stay strong—you're on the right track!",
        "I'm really proud of you!"
    ]
    return random.choice(praise_list)

def generate_productivity_tip(msg):
    msg = msg.lower()

    if any(word in msg for word in ["no time", "busy", "fast", "in a rush", "pressure", "tight schedule", "short on time"]):
        return random.choice([
            "If time is short, focus on one high-impact task instead of doing everything.",
            "You don't need hours—just 20 focused minutes can make a difference.",
            "Try time blocking: schedule small focused chunks and stick to them.",
            "Start with a task that energizes you—it'll give you momentum for the rest."
        ])

    elif any(word in msg for word in ["can't focus", "distraction", "distracted", "unfocused", "tired", "drained", "bored"]):
        return random.choice([
            "Clear your workspace—remove anything not related to the task.",
            "Use the '5-minute rule': commit to studying for just 5 minutes to get started.",
            "Try ambient music or noise blockers to reduce distractions.",
            "Break tasks into micro-goals—your brain likes quick wins."
        ])

    elif any(word in msg for word in ["exam", "final", "quiz", "review", "test", "assessment"]):
        return random.choice([
            "Simulate test conditions—set a timer and practice like it's real.",
            "Review by teaching: explain the topic out loud to yourself or a friend.",
            "Focus on understanding, not just memorizing. Concepts stick better.",
            "Use active recall and spaced repetition to boost retention."
        ])

    elif any(word in msg for word in ["smart", "tips", "tricks", "hack", "efficient", "strategy", "technique"]):
        return random.choice([
            "Use the Pomodoro technique: 25 minutes deep focus, 5-minute break.",
            "Chunk your study sessions: group similar topics to build context faster.",
            "Summarize each lesson in 3 key points—it'll help with clarity.",
            "Write your own quiz questions to engage with the material creatively."
        ])

    elif any(word in msg for word in ["stuck", "lost", "unmotivated", "discouraged", "lazy", "don't feel like it", "overwhelmed", "burnt out"]):
        return random.choice([
            "Motivation comes after action—just take a small step.",
            "Your future self will thank you for starting today.",
            "Instead of aiming for perfect, aim for done. Then improve.",
            "Remind yourself why you started—reconnect with your purpose."
        ])

    else:
        return random.choice([
            "Start with a clear and simple goal—clarity beats confusion.",
            "Stay hydrated and take regular short breaks to refresh your mind.",
            "Study in intervals—your brain absorbs more with short, repeated sessions.",
            "Avoid multitasking—it kills focus. One task at a time is more effective.",
            "Track your progress, not just your effort. Celebrate small wins!"
        ])
# Chatbot handler
def handle_chat(message, file_bytes=None):
    msg = message.lower()

    if any(kw in msg for kw in ["خلصت", "انتهيت", "done", "finished", "completed", "أنجزت", "أنهيت", "i did it", "نجحت", "achieved", "نجاح"]):
        return generate_praise()

    elif any(kw in msg for kw in ["ملخص", "تلخيص", "summary", "summarize"]):
        if file_bytes:
            text = extract_text_from_pdf(file_bytes)
            return summarize_text(text)
        else:
            return "Please upload a PDF file so I can summarize it."

    elif any(kw in msg for kw in ["سؤال", "أسئلة", "مراجعة", "question", "questions", "quiz", "اختبار"]):
        if file_bytes:
            text = extract_text_from_pdf(file_bytes)
            return generate_questions(text)
        else:
            return "Please upload a PDF file so I can generate questions."

    elif any(kw in msg for kw in ["نصيحة", "إنتاجية", "tip", "tips", "study", "help", "busy"]):
        return generate_productivity_tip(msg)

    elif any(kw in msg for kw in ["anxious", "nervous", "worried", "stressed", "afraid"]):
        return random.choice([
            "It's okay to feel nervous—studying step by step will calm you down.",
            "Start with an easy subject to build confidence.",
            "You've got this—being anxious means you care!"
        ])
    return chat_with_student(message)
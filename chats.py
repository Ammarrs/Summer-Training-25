import transformers as t 
import torch
import random

tokenizer = t.GPT2Tokenizer.from_pretrained("gpt2")
model = t.GPT2LMHeadModel.from_pretrained("gpt2")
model.eval()

bot_responses = {
    "hello": [
        "Hi there! Ready to dive into your study session?",
        "Hello! Let's make this day productive!",
        "Hey! How can I support your study today?",
        "Welcome back! Let's achieve something great today.",
        "Hi! What's your focus for today?"
    ],
    "hi": [
        "Hey there! What are we working on today?",
        "Hi again! Let's make progress together.",
        "Hello! Any questions or topics you'd like to tackle?",
        "Ready to learn something new?",
        "Glad to see you! Let's get started."
    ],
    "i'm tired": [
        "It's okay to feel tired. Take a 5-minute break and come back refreshed.",
        "You're doing your best—maybe a power nap or some stretching would help.",
        "Don't push yourself too hard. Let's slow down a bit today.",
        "Try a quick walk or drink some water—it might boost your energy.",
        "Let's pick an easy topic while your energy is low."
    ],
    "i'm sad": [
        "I'm here for you. Studying can wait if you need a moment.",
        "It's okay to feel sad. Want to talk about it?",
        "You've got this—even the tough days pass.",
        "I believe in you, even if today feels hard.",
        "Sometimes learning is also about taking care of your emotions."
    ],
    "i'm happy": [
        "That's great! Let's use that good mood to learn something cool!",
        "Amazing! You're unstoppable today.",
        "Positive vibes = productive sessions!",
        "Let's channel that happiness into your goals.",
        "Glad to hear that! Let's make today count."
    ],
    "i'm stressed": [
        "Deep breath. You've handled harder things before.",
        "One step at a time. Let's make a small plan together.",
        "Stress is normal—want me to suggest a short task?",
        "Let's break things down so it feels more manageable.",
        "You're not alone in this. Let me help simplify things."
    ],
    "i'm bored": [
        "Want to switch subjects for a bit?",
        "Let's try a quiz or game-style challenge!",
        "Boredom means it's time to shake things up.",
        "How about we do a quick review together?",
        "Want me to tell you a productivity tip?"
    ],
    "i don't understand": [
        "No problem! Let me explain it in a different way.",
        "Can you tell me what part is confusing?",
        "Learning takes time—let's go step by step.",
        "How about we break it into smaller parts?",
        "Try giving an example—you might already know more than you think."
    ],
    "this is hard": [
        "It's okay. Difficult means you're learning.",
        "Let's work through it together.",
        "Every expert started where you are.",
        "Try again—learning takes patience.",
        "Want a simpler explanation?"
    ],
    "how": [
        "Let's go through it step by step.",
        "Here's a way to think about it...",
        "Want a visual example or a simple explanation?",
        "I can break it down for you—just ask.",
        "Tell me what you've tried so far."
    ],
    "what should i do": [
        "Start by reviewing your last session.",
        "Pick one small thing to focus on.",
        "Let's look at your goal and build from there.",
        "How about setting a 25-minute timer and focusing on one task?",
        "Check your to-do list—what's most important?"
    ],
    "i feel lazy": [
        "Let's just start with 5 minutes. You'll gain momentum.",
        "Even small progress is good progress.",
        "Motivation comes after action—let's begin!",
        "Maybe a short reward after studying would help?",
        "We can do this together—just start small."
    ]
}

keywords = list(bot_responses.keys())

def chat_with_student(user_input):
    user_input = user_input.lower().strip()

    for key in keywords:
        if key in user_input:
            return random.choice(bot_responses[key])

    input_ids = tokenizer.encode(user_input, return_tensors='pt')
    with torch.no_grad():
        output = model.generate(
            input_ids,
            max_length=60,
            pad_token_id=tokenizer.eos_token_id,
            do_sample=True,
            top_k=20,
            top_p=0.95
        )
    reply = tokenizer.decode(output[0], skip_special_tokens=True)
    return reply[len(user_input):].strip()
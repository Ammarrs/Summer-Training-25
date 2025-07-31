# 📘 User Manual: How to Run the Full Project

This manual explains how to set up and run the complete project, including the Flutter frontend, Node.js backend, and Flask-based AI service.

---

## 🗂️ Project Structure

```
project-root/
├── frontend/        # Flutter app
├── backend/         # Node.js + Express + MongoDB
└── /                # Flask AI service
```

---

## 🧠 Requirements

### ✅ Global Tools

| Tool    | Version (or later) | Download Link |
| ------- | ------------------ | ------------- |
| Node.js | 18+                |               |

| [https://nodejs.org/](https://nodejs.org/) |                 |                                                                              |
| ------------------------------------------ | --------------- | ---------------------------------------------------------------------------- |
| npm                                        | 9+              | Comes with Node                                                              |
| Python                                     | 3.9+            | [https://python.org/](https://python.org/)                                   |
| pip                                        | latest          | Comes with Python                                                            |
| MongoDB                                    | Any local/cloud | [https://www.mongodb.com/try/download](https://www.mongodb.com/try/download) |
| Flutter SDK                                | 3.0+            | [https://flutter.dev/docs/get-started](https://flutter.dev/docs/get-started) |

---

## 🚀 How to Run the Project

### 1️⃣ Run the Flutter Frontend

**Location:**

```
cd frontend/
```

**Run the app:**

```bash
flutter pub get
flutter run
```

> ✅ Ensure an emulator is running or a device is connected.

---

### 2️⃣ Run the Backend (Node.js + Express)

**Location:**

```
cd backend/
```

**Install dependencies:**

```bash
npm install
```

**Set up environment variables:** Create a `.env` file:

```env
PORT=3000
MONGO_URI=mongodb://localhost:27017/your-db
JWT_SECRET=yourSuperSecretKey
```

**Run the server:**

```bash
npm run dev
```

> ✅ If `nodemon` is not installed:

```bash
npm install -g nodemon
```

---

### 3️⃣ Run the AI Service (Python Flask)

**Location:**

```
cd /
```

**Create and activate virtual environment:**

```bash
python -m venv venv
venv\Scripts\activate      # Windows
# or
source venv/bin/activate   # Mac/Linux
```

**Install dependencies:**

```bash
pip install -r requirements.txt
```

**Run the Flask app:**

```bash
flask run
```

> ✅ Set FLASK_APP if using a blueprint structure:

```bash
set FLASK_APP=app.py       # Windows
export FLASK_APP=app.py    # Mac/Linux
```

Or if using `app/__init__.py`:

```bash
set FLASK_APP=app
```

---

## 🌐 Connecting Everything Together

### 💬 Frontend ↔ Backend

- Define backend base URL in Flutter (e.g., `http://localhost:3000/`)

### 🧠 Backend ↔ AI

- Use HTTP requests from Express to Flask:

```ts
await axios.post("http://localhost:5000/ai-endpoint", {
  /* data */
});
```

- Ensure CORS is enabled in Flask.

---

## 🧪 Testing the Integration

- ✅ Run Flutter → check UI loads
- ✅ Test backend API (register/login)
- ✅ Test AI feature flow: Flutter → Backend → AI → Backend → Flutter

---

## 🧹 Clean Shutdown

```bash
# Stop Flutter
Ctrl + C

# Stop Node.js
Ctrl + C

# Stop Flask
Ctrl + C

# Deactivate Python venv
deactivate
```

---

## 🧾 Notes

- Do not commit `.env` files.
- Document all API routes (Postman or Markdown).
- You can use Docker or `concurrently` later for multi-service startup.

---

> Built with 💻 by the team — keep coding, keep crushing!

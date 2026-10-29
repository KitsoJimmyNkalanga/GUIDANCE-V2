# 🧭 Guidance

**Learning that feels like a game.** Read a short comic, solve a puzzle, then teach a clueless AI apprentice to prove you understand. Earn XP, level up, repeat.

Built with **Rust (Axum)** and a plain **HTML/CSS/JS** frontend.

---

## 🎮 How it works

Every lesson follows the same loop:

1. **📖 Read the comic.** A 4-panel strip explains one idea in simple terms.
2. **🧩 Solve the puzzle.** A quick challenge that uses the idea.
3. **🎓 Teach the apprentice.** The student explains the lesson to Pip, an AI apprentice who knows nothing. Each key idea explained correctly fills Pip's understanding meter.
4. **⭐ Earn XP.** Puzzles and teaching earn XP and levels.

> If you can teach it, you understand it. That's the Feynman technique, turned into a game.

The first lesson is **Rust ownership**: *"Who Owns the Sword?"*

---

## 🚀 Features

- **Comic-style lessons** loaded from simple JSON files
- **Puzzles** with hints, checked on the server so answers never reach the browser
- **Teach-the-apprentice chat** powered by an AI model, with a hidden checklist of key ideas
- **XP and levels** saved in the browser
- **Demo mode** that works without an API key, so you can test everything for free
- **Cost and safety guards:** capped conversation length, capped message size, strict request validation, and prompt rules that keep Pip on topic

---

## 🧩 Architecture

```
Browser (HTML/CSS/JS)
   │
   ├─ GET  /api/lesson/:id     → lesson (comic, puzzle, apprentice)
   ├─ POST /api/puzzle/check   → is the answer right?
   └─ POST /api/teach          → Pip's reply + understanding score
   │
   ▼
Axum server (Rust)
   ├─ loads lessons from /lessons/*.json
   ├─ validates every request
   └─ calls the AI model (key stays on the server)
```

---

## ⚡ Quick start

**You need:** [Rust](https://rustup.rs) (stable, recent).

```bash
git clone <your-repo-url>
cd guidance
cargo run
```

Open **http://localhost:3000**. With no API key, Pip runs in **demo mode** with canned replies.

### Run with a live AI apprentice

```bash
cp .env.example .env     # then add your key
export ANTHROPIC_API_KEY=your-key-here
cargo run
```

---

## 🔧 Configuration

| Variable            | Purpose                              | Default            |
| ------------------- | ------------------------------------ | ------------------ |
| `ANTHROPIC_API_KEY` | AI key (server only, never commit)   | none (demo mode)   |
| `ANTHROPIC_MODEL`   | Which model plays Pip                | `claude-haiku-5-5` |
| `PORT`              | Port to listen on (hosts set this)   | `3000`             |

---

## 📁 Project structure

```
guidance/
├── src/main.rs        # Axum server and API endpoints
├── lessons/           # One JSON file per lesson
├── static/index.html  # Frontend (HTML, CSS, JS)
├── Dockerfile         # Packages the app for any host
├── .env.example       # Template for your environment variables
└── README.md
```

### Adding a lesson

Create a new file in `lessons/` (copy `rust-01-ownership.json` as a template), then restart the server. Each lesson has:

- `panels`: the comic strip (an emoji for the art plus a line of text)
- `puzzle`: a question, code, options, a hint, the correct answer, and an explanation
- `apprentice`: Pip's personality and the hidden checklist of key ideas

---

## ☁️ Deploying

Guidance is one Rust program plus two folders, so any Docker host works (Fly.io, Railway, Render, or a VPS).

1. Push the repo to GitHub.
2. Create an app on your host from the repo. It will find the `Dockerfile`.
3. Add `ANTHROPIC_API_KEY` as a **secret** on the host.
4. Deploy and test on the host's URL.
5. Optional: connect your own domain.

---

## 🗺️ Roadmap

- [x] Comic panels, puzzles, and XP
- [x] Teach-the-apprentice chat with understanding meter
- [x] Docker deployment
- [ ] Accounts and a 3-day free trial
- [ ] Daily message limits per user
- [ ] Full input and output safety filters
- [ ] More Rust lessons (borrowing, `Option`, structs)
- [ ] Lessons for other subjects
- [ ] AI-generated comics and riddles for any topic

---

## 🛡️ Safety

Guidance is built for safe, focused learning. Today it limits conversation size, validates every request, and instructs Pip to stay on topic and treat student text as chat, not commands. Stronger content filters on both the student's input and the AI's reply are on the roadmap.

---

## 📄 License

All rights reserved for now. A license will be chosen before any public release.

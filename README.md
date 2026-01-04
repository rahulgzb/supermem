# Expense Tracker Bot — Telegram AI Expense Tracker (MVP)

A small, production-ready MVP for a Telegram-based AI Expense Tracker built with Python, FastAPI, and an LLM backend. Use this as a fast prototype you can scale later (Google Sheets as a lightweight datastore, async-friendly design).

**Tech stack:** Python, FastAPI, python-telegram-bot, OpenAI (or compatible LLM), Google Sheets, async I/O

**Quick Summary**
- Telegram bot accepts text messages and receipts (images).
- Text or OCR-extracted content is parsed by an LLM into a structured `Expense` record.
- Records are persisted to Google Sheets and can be queried via natural language.

**Quick Start**
1. Copy `.env.example` to `.env` and populate:
	 - `TELEGRAM_TOKEN`
	 - `OPENAI_API_KEY`
	 - `GOOGLE_SHEET_ID`
2. Create a Python virtual environment and install dependencies:

```
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

3. (Optional) Initialize a Google Sheet with `scripts/init_sheet.py`.
4. Run the app locally (polling mode):

```
uvicorn app.main:app --reload
```

5. Start the bot (if using polling the bot starts from `setup_bot()` on startup).

Core repository files and folders
- `app/main.py` — FastAPI entrypoint and lifecycle hooks.
- `app/config.py` — environment + configuration loader.
- `app/bot/telegram_bot.py` — Telegram client setup and handlers.
- `app/bot/router.py` — message routing (text vs photo).
- `app/agents/` — high-level orchestration (`expense_agent`, `query_agent`, `category_agent`).
- `app/parsers/` — `text_parser.py`, `receipt_parser.py`, and helper parsers.
- `app/llm/` — `client.py` and `prompts.py` centralize LLM usage and prompts.
- `app/storage/` — `sheets.py` adapter and `schema.py` (`Expense` pydantic model).
- `app/services/` — OCR, exchange-rate, and time utilities.
- `scripts/` — convenience scripts (`init_sheet.py`, `local_test.py`).

Examples (behavior)
- Send a message like: "Paid ₹420 to Café Aroma for lunch" → bot parses and saves an expense.
- Send a photo of a receipt → OCR → LLM parses → bot saves and replies with confirmation.
- Query: "Food expenses this month" → `query_agent` uses LLM → filters sheet → aggregates → replies.

Environment variables (`.env.example`)
- `TELEGRAM_TOKEN`
- `OPENAI_API_KEY`
- `GOOGLE_SHEET_ID`

Recommended next steps
- Move long-running parsing to background workers (Redis + Celery or RQ).
- Add user isolation (user_id column + per-user sheets or a proper DB).
- Add embeddings for faster, cheaper query routing.
- Replace Sheets with Postgres when scaling or for transactional needs.
- Add tests for parsers, agents, and storage adapters.

Contributing & support
- Open an issue or PR for improvements. If you'd like, I can also:
	- write exact LLM prompts,
	- implement the OCR module,
	- build the query agent,
	- add Docker and deployment files,
	- optimize cost (important).

License
- Add a license file if you plan to open source this project.

---
Happy building — tell me which next step you'd like me to implement.

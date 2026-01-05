# ---------- Base Image ----------
FROM python:3.11-slim

# ---------- Environment ----------
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV POETRY_VERSION=2.2.1
ENV POETRY_NO_INTERACTION=1
ENV POETRY_VIRTUALENVS_CREATE=false

# ---------- System Dependencies ----------
RUN apt-get update && apt-get install -y \
    curl \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# ---------- Install Poetry ----------
RUN curl -sSL https://install.python-poetry.org | python3 -

ENV PATH="/root/.local/bin:$PATH"

# ---------- Set Workdir ----------
WORKDIR /app

# ---------- Copy Poetry Files ----------
COPY pyproject.toml poetry.lock* /app/

# ---------- Install Dependencies ----------
RUN poetry install --no-root --only main

# ---------- Copy Application ----------
COPY . /app

# ---------- Expose Port (optional) ----------
EXPOSE 8000

# ---------- Run App ----------
CMD ["python", "main.py"]

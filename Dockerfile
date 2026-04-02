# ── Backend — FastAPI / Uvicorn ───────────────────────────────────────────────
FROM python:3.11-slim

# poppler-utils is required by pdfplumber for PDF text extraction
RUN apt-get update \
    && apt-get install -y --no-install-recommends poppler-utils \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

ENV BACKEND_PORT=8282

# Run with uvicorn in production mode (no --reload)
EXPOSE 8282
CMD ["sh", "-c", "uvicorn main:app --host 0.0.0.0 --port ${BACKEND_PORT}"]

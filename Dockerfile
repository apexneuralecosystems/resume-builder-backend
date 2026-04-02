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

EXPOSE 8000

# Run with uvicorn in production mode (no --reload)
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]

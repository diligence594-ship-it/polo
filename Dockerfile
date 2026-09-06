FROM python:3.10-slim-bookworm

# System dependencies with updated Bookworm mirrors
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    ffmpeg \
    wget \
    bash \
    procps \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Requirements install
COPY requirements.txt .

RUN pip3 install --no-cache-dir -U pip wheel && \
    pip3 install --no-cache-dir -U -r requirements.txt

# Project code
COPY . .

EXPOSE 5000

# Start command
CMD ["bash", "-c", "flask run -h 0.0.0.0 -p 5000 & python3 -m devgagan"]

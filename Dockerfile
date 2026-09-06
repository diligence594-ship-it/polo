FROM python:3.10-slim-bullseye

# Debian frontend non-interactive setup
ENV DEBIAN_FRONTEND=noninteractive

# Stable system dependencies without broken/archived packages
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

# Dependency layer caching
COPY requirements.txt .

RUN pip3 install --no-cache-dir -U pip wheel && \
    pip3 install --no-cache-dir -U -r requirements.txt

COPY . .

EXPOSE 5000

CMD ["bash", "-c", "flask run -h 0.0.0.0 -p 5000 & python3 -m devgagan"]

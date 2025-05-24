FROM python:3.10-slim

WORKDIR /app

# OSパッケージ（pyopenjtalk に必要なビルドツール）をインストール
RUN apt-get update && apt-get install -y \
    mecab \
    libmecab-dev \
    mecab-ipadic-utf8 \
    build-essential \
    cmake \
    && rm -rf /var/lib/apt/lists/*

# Pythonパッケージのインストール
COPY requirements.txt .
RUN pip install --upgrade pip setuptools wheel
RUN pip install --prefer-binary --no-cache-dir -r requirements.txt
RUN pip install pyopenjtalk

# アプリのコードをコピー
COPY . .

CMD ["python", "main.py"]

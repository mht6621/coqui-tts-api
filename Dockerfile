# ベースイメージ（軽量で安定）
FROM python:3.10-slim

# 作業ディレクトリを設定
WORKDIR /app

# Pythonのキャッシュを減らすための環境変数（おまじない的）
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# 必要なシステムパッケージのインストール
RUN apt-get update && apt-get install -y \
    ffmpeg \
    libsndfile1 \
    git \
    && apt-get clean

# requirements.txt を先にコピーして依存をインストール（キャッシュ活用のため）
COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install --prefer-binary --no-cache-dir -r requirements.txt

# アプリの中身をコピー
COPY . .

# 本番起動コマンド（Flaskアプリ）
CMD ["python", "main.py"]

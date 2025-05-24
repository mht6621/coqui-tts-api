FROM python:3.10-slim

WORKDIR /app

# 必要ファイルを先にコピーして pip install
COPY requirements.txt .

# pip をアップグレードしてから依存関係をインストール
RUN pip install --upgrade pip setuptools wheel
RUN pip install --prefer-binary --no-cache-dir -r requirements.txt

# アプリのソースコードをコピー
COPY . .

# アプリを起動
CMD ["python", "main.py"]

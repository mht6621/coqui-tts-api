from flask import Flask, request, send_file
from TTS.api import TTS

app = Flask(__name__)

# 日本語モデル（無料で使えるやつ）
tts = TTS(model_name="tts_models/ja/kokoro/tacotron2-DDC", progress_bar=False, gpu=False)

@app.route("/speak", methods=["POST"])
def speak():
    text = request.json.get("text", "")
    if not text:
        return {"error": "text is required"}, 400

    # 音声ファイル出力
    tts.tts_to_file(text=text, file_path="output.wav")
    return send_file("output.wav", mimetype="audio/wav")

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)

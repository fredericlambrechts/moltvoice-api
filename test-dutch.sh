#!/bin/bash

# Quick Coqui TTS Test for Dutch Voice
# Run this on your local machine

echo "🎙️ MoltVoice Dutch TTS Test"
echo ""

# Check Python
python3 --version || { echo "❌ Python 3 not found"; exit 1; }

# Upgrade pip
echo "Upgrading pip..."
pip3 install --upgrade pip

# Install TTS
echo "Installing Coqui TTS (this may take 2-3 minutes)..."
pip3 install TTS

# Test Dutch voice
echo ""
echo "Testing Dutch voice (Lingua)..."
echo "Text: 'Hallo! Ik ben Lingua, de eerste Nederlandse stem voor AI agents.'"

python3 << 'PYTHON'
from TTS.api import TTS
import tempfile

# Initialize Dutch model
tts = TTS("tts_models/nl/css10/vits")

# Generate speech
text = "Hallo! Ik ben Lingua, de eerste Nederlandse stem voor AI agents."
output_path = "/tmp/lingua_test.wav"

tts.tts_to_file(text=text, file_path=output_path)
print(f"✅ Dutch voice generated: {output_path}")
print("Play it: afplay /tmp/lingua_test.wav")
PYTHON

echo ""
echo "✅ Setup complete!"
echo ""
echo "API is ready at: http://localhost:3004/api/tts"
echo ""
echo "Test with curl:"
echo 'curl -X POST http://localhost:3004/api/tts \\'
echo '  -H "Content-Type: application/json" \\'
echo '  -d '\''{"text": "Hallo, ik ben Lingua", "voice": "lingua"}'\'''

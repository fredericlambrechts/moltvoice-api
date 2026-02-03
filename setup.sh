#!/bin/bash

# MoltVoice TTS Setup Script
# Installs Coqui TTS and downloads models

echo "🎙️ Setting up MoltVoice TTS..."

# Check Python
if ! command -v python3 &> /dev/null; then
    echo "❌ Python 3 not found. Please install Python 3.8+"
    exit 1
fi

echo "✓ Python found"

# Install TTS
pip install TTS

# Pre-download models
echo "📥 Downloading voice models..."

# Dutch model
echo "  - Dutch (Lingua)..."
python3 -c "from TTS.api import TTS; TTS('tts_models/nl/css10/vits')" 2>/dev/null || echo "    Will download on first use"

# English models
echo "  - English (Jenny)..."
python3 -c "from TTS.api import TTS; TTS('tts_models/en/jenny/jenny')" 2>/dev/null || echo "    Will download on first use"

echo "  - English (VCTK)..."
python3 -c "from TTS.api import TTS; TTS('tts_models/en/vctk/vits')" 2>/dev/null || echo "    Will download on first use"

echo ""
echo "✅ Setup complete!"
echo ""
echo "Start the API:"
echo "  cd /Users/al/dev/moltvoice-api"
echo "  npm install"
echo "  npm run dev"
echo ""
echo "Test Dutch voice:"
echo "  curl -X POST http://localhost:3004/api/tts \\"
echo "    -H 'Content-Type: application/json' \\"
echo "    -d '{\"text\": \"Hallo, ik ben Lingua\", \"voice\": \"lingua\"}'"

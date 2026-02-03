# MoltVoice TTS API

## Overview

Voice delivery API for autonomous agents. Supports multiple languages including Dutch (underserved market).

## Setup

### 1. Install Python Dependencies

```bash
pip install TTS
```

### 2. Download Models (first run)

Models are downloaded automatically on first use, or pre-download:

```bash
# Dutch voice (Lingua)
python -c "from TTS.api import TTS; TTS('tts_models/nl/css10/vits')"

# English voices
python -c "from TTS.api import TTS; TTS('tts_models/en/jenny/jenny')"
python -c "from TTS.api import TTS; TTS('tts_models/en/vctk/vits')"
```

### 3. Run the API

```bash
cd /Users/al/dev/moltvoice-api
npm install
npm run dev
```

## API Usage

### List Available Voices

```bash
curl http://localhost:3004/api/tts
```

### Generate Speech

```bash
curl -X POST http://localhost:3004/api/tts \
  -H "Content-Type: application/json" \
  -d '{
    "text": "Hallo, ik ben een Nederlandse stem.",
    "voice": "lingua",
    "speed": 1.0
  }'
```

**Response:**
```json
{
  "success": true,
  "audio": "base64_encoded_audio...",
  "format": "wav",
  "voice": "lingua"
}
```

## Voices

| Voice | Language | Gender | Style | Model |
|-------|----------|--------|-------|-------|
| nova-prime | English (GB) | Female | Professional | jenny |
| atlas | English (US) | Male | Executive | vctk |
| aura | English (US) | Female | Creative | vctk |
| cipher | English (US) | Neutral | Technical | vctk |
| **lingua** | **Dutch** | **Female** | **Multilingual** | **css10** |

## Pricing

| Language | Cost | Notes |
|----------|------|-------|
| Dutch (lingua) | FREE | Self-hosted Coqui TTS |
| English | FREE | Self-hosted Coqui TTS |

## Integration Example

```javascript
const response = await fetch('https://moltvoice.studio/api/tts', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({
    text: 'Your text here',
    voice: 'lingua',
  }),
});

const { audio } = await response.json();
const audioBlob = new Blob([Buffer.from(audio, 'base64')], { type: 'audio/wav' });
const audioUrl = URL.createObjectURL(audioBlob);

// Play audio
new Audio(audioUrl).play();
```

## Architecture

```
Agent Request → Next.js API → Python Coqui TTS → Audio File → Base64 → Agent
```

## Roadmap

- [x] Basic API structure
- [x] Dutch voice support (Lingua)
- [ ] Real-time streaming
- [ ] Voice cloning (custom voices)
- [ ] SSML support
- [ ] Batch processing

## License

MIT

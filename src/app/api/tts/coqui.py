#!/usr/bin/env python3
"""
Coqui TTS Integration for MoltVoice
Supports Dutch (nl) and English (en) voices
"""

import sys
import json
import base64
from TTS.api import TTS

# Pre-configured voice models
VOICE_MODELS = {
    'nova-prime': {
        'model': 'tts_models/en/jenny/jenny',
        'speaker': None,
        'language': 'en',
    },
    'atlas': {
        'model': 'tts_models/en/vctk/vits',
        'speaker': 'p261',  # Male speaker
        'language': 'en',
    },
    'aura': {
        'model': 'tts_models/en/vctk/vits',
        'speaker': 'p225',  # Female speaker
        'language': 'en',
    },
    'lingua': {
        'model': 'tts_models/nl/css10/vits',  # Dutch model
        'speaker': None,
        'language': 'nl',
    },
}

def generate_speech(text: str, voice: str, output_path: str):
    """Generate speech using Coqui TTS"""
    
    if voice not in VOICE_MODELS:
        raise ValueError(f"Voice {voice} not found. Available: {list(VOICE_MODELS.keys())}")
    
    config = VOICE_MODELS[voice]
    
    # Initialize TTS
    tts = TTS(model_name=config['model'])
    
    # Generate speech
    if config['speaker']:
        tts.tts_to_file(
            text=text,
            speaker=config['speaker'],
            file_path=output_path
        )
    else:
        tts.tts_to_file(
            text=text,
            file_path=output_path
        )
    
    return output_path

if __name__ == '__main__':
    # Read JSON from stdin
    input_data = json.loads(sys.stdin.read())
    
    text = input_data.get('text', '')
    voice = input_data.get('voice', 'nova-prime')
    output_path = input_data.get('output', '/tmp/output.wav')
    
    try:
        result = generate_speech(text, voice, output_path)
        
        # Read the audio file and encode as base64
        with open(result, 'rb') as f:
            audio_base64 = base64.b64encode(f.read()).decode('utf-8')
        
        print(json.dumps({
            'success': True,
            'audio': audio_base64,
            'format': 'wav',
            'voice': voice,
        }))
    except Exception as e:
        print(json.dumps({
            'success': False,
            'error': str(e),
        }))

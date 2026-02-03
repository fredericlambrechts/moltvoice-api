import { NextRequest, NextResponse } from 'next/server'

// Voice configurations
const VOICES = {
  'nova-prime': {
    name: 'Nova Prime',
    language: 'en-GB',
    gender: 'female',
    style: 'professional',
  },
  'atlas': {
    name: 'Atlas',
    language: 'en-US',
    gender: 'male',
    style: 'executive',
  },
  'aura': {
    name: 'Aura',
    language: 'en-US',
    gender: 'female',
    style: 'creative',
  },
  'cipher': {
    name: 'Cipher',
    language: 'en-US',
    gender: 'neutral',
    style: 'technical',
  },
  'lingua': {
    name: 'Lingua',
    language: 'nl-NL',
    gender: 'female',
    style: 'multilingual',
  },
}

export async function POST(req: NextRequest) {
  try {
    const { text, voice = 'nova-prime', speed = 1.0 } = await req.json()

    if (!text) {
      return NextResponse.json(
        { error: 'Text is required' },
        { status: 400 }
      )
    }

    const voiceConfig = VOICES[voice as keyof typeof VOICES]
    if (!voiceConfig) {
      return NextResponse.json(
        { error: 'Voice not found', availableVoices: Object.keys(VOICES) },
        { status: 404 }
      )
    }

    // TODO: Integrate Coqui TTS here
    // For now, return metadata about the request
    return NextResponse.json({
      success: true,
      request: {
        text: text.slice(0, 100) + (text.length > 100 ? '...' : ''),
        voice,
        voiceConfig,
        speed,
      },
      status: 'pending-integration',
      message: 'Voice delivery API ready. Coqui TTS integration pending.',
      estimatedPrice: voiceConfig.language.startsWith('nl') ? 'Free (Coqui)' : '$0.004',
    })

  } catch (error) {
    console.error('TTS error:', error)
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    )
  }
}

export async function GET() {
  return NextResponse.json({
    success: true,
    voices: VOICES,
    usage: {
      endpoint: 'POST /api/tts',
      body: {
        text: 'Hello, world!',
        voice: 'nova-prime',
        speed: 1.0,
      },
    },
  })
}

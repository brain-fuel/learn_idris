# Chapter 24 — Text-to-Speech (espeak-ng shell-out)

**You'll learn:** TTS is another shell-out chapter. `espeak-ng` is a small, free, on-device TTS engine — give it text, it speaks it through the speakers. Speech-to-text (the opposite direction) uses `whisper.cpp` for local inference; both are pure subprocess invocations from Idris.

## Status

Not yet authored. See [`../ch01-basics/`](../ch01-basics/) for the chapter template. This is the curriculum capstone.

## Idris realization

```idris
speak : (text : String) -> IO ()
speak t = do
  _ <- system ("espeak-ng -v en " ++ shellQuote t)
  pure ()
```

For STT, save mic audio (`arecord -d 5 input.wav`), transcribe (`whisper-cli -f input.wav -m models/ggml-base.en.bin`), parse the output text.

## External tool dependencies

- `espeak-ng` — `sudo apt install espeak-ng`.
- `whisper.cpp` — clone <https://github.com/ggerganov/whisper.cpp>, `make`, download a model.
- `arecord` (from `alsa-utils`) for capturing mic.

## Pack dependencies

None.

## Miniproject (when authored)

A read-aloud reminder bot: `remind in 30m "stand up"` schedules a notification at the right time, then speaks the message via `espeak-ng`.

This is the **end of the curriculum**. After this, the learner has:
- Worked through all 24 ABS topics in Idris.
- Built 24 miniprojects, each in idiomatic Idris.
- Met totality, dependent types, parser combinators, and the JSON/HTTP ecosystem.
- Practiced shelling out to system tools — a real skill, not a fallback.

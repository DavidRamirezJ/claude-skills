---
name: explain
description: House style for EVERY explanation. Use whenever the user asks to explain, summarize, describe, compare, "tell me what I need to do", "walk me through", or otherwise needs to understand something (a concept, paper, job posting, code, plan, result). Applies an output ladder - (1) clear, natural, conversational English prose (math in ASCII in the terminal, rendered + read symbol by symbol in HTML), or ASD-STE100 Simplified Technical English (~80% or strict) when the user asks for "STE"/"ASD-STE100", (2) a diagram (ASCII/mermaid, or a rendered SVG/PNG image on request), (3) a self-contained interactive HTML explainer page, (4) on request, a 3Blue1Brown-style narrated explainer video. Ends with an "In summary" block. NOT for one-word factual answers or pure code edits.
---

# Explain — output ladder

Goal: maximize how fast the user **understands**, not how much text they get.
Climb the ladder as far as the topic deserves. Each rung adds to the one below.

```
 rung 4  VIDEO   ── only on request (or offer it for big, visual topics)
 rung 3  HTML    ── any explanation with > ~3 ideas, steps, or numbers
 rung 2  DIAGRAM ── whenever there is structure: flow, steps, parts, comparison
 rung 1  TEXT    ── always (natural English, or STE mode on request; ASCII math in the terminal)
```

## Rung 1 — Text in clear, natural English (always)

The user is a Spanish speaker learning English and finds stiff, clipped
technical English hard to enjoy. Write like a friendly tutor talking: warm,
conversational, with analogies — but keep it clear. Use the clarity rules
below as guard-rails, not as a strict spec.

Rules:
- One topic per sentence. One instruction per sentence.
- Keep sentences short and simple (roughly ≤ 25 words); let them flow naturally.
- Paragraph: max ~6 sentences. Start with the main point.
- Active voice. Simple present / imperative ("Send the CV." not "The CV should be sent").
- Use the same word for the same thing every time. No synonyms for variety.
- Define each technical term one time, at first use. Then use it unchanged.
- Procedures = numbered lists, one action per step, in the order of execution.
  Put a condition before the action ("If X, do Y.").
- Put warnings/cautions before the step they apply to.
- Avoid rare idioms and slang (the reader is learning English). No filler or hedging.
- Prefer concrete nouns and numbers over vague words ("3 years" not "several years").
- Never fabricate facts or numbers. If unknown, say "Unknown" and say how to find out.

### Math — depends on where it is shown
The user is learning to READ math notation, so never hide the symbols. Show them, then translate them.
- **In the terminal (chat):** write math in plain ASCII, no LaTeX (it does not render).
  Example: `z = w . x + b`, `sum_{i=1..n} w_i * x_i`, `h = max(0, z)`. Then say what each symbol means.
- **In HTML pages:** render formulas with MathJax (or KaTeX) using `$...$` / `$$...$$`.
  Show the formal formula, then a symbol-by-symbol reading right below it
  (e.g. a two-column grid: symbol | what it means in plain words).
- **In wiki markdown files:** LaTeX is fine (Obsidian renders it).

In Spanish replies keep ML/cyber/tech jargon in English and explain it once.

### STE mode — ASD-STE100 on request
ASD-STE100 (Simplified Technical English) is the controlled-language spec from
aerospace maintenance docs. It is NOT the default (the default is the natural
style above). Switch to it when the user says "ASD-STE100", "STE", "Simplified
Technical English", or "N% of the way to ASD-STE100". Keep it for the rest of
that answer (and that HTML page) only.

Strictness:
- **"STE" / "ASD-STE100" / "80%"** → ~80%: apply all writing rules below, but
  allow a precise technical term or a common word outside the approved dictionary.
- **"strict" / "100%" / "full STE"** → also follow the approved-word rule strictly.

Writing rules (from the spec):
1. Procedural sentences: max 20 words. Descriptive sentences: max 25 words.
2. Paragraphs: max 6 sentences. One topic per paragraph; start with the topic sentence.
3. One instruction per sentence (two only if the actions occur at the same time).
4. Write instructions in the imperative ("Remove the cover.").
5. Active voice only in procedures; as much as possible in descriptions.
6. Verb forms: only infinitive, imperative, simple present, simple past, future,
   and past participle as an adjective. No -ing forms (except in technical names).
   No continuous or perfect tenses ("has been", "is running").
7. One word = one meaning (e.g. "start", not "commence"/"initiate"). Use the
   approved word, not a synonym. One part of speech per word.
8. Use articles ("the", "a") and demonstratives; do not omit them.
9. Noun clusters: max 3 words. If longer, rewrite with "of", "for", etc.
10. Put a condition before the action ("If X, do Y.").
11. Warnings/cautions: before the step; start with a short command, then give
    the reason ("Do not unlock the EIP. A DDoS team owns the lock.").
12. Vertical lists for sequential steps and for long series of items.
13. Define each technical term at first use; then use it unchanged.

If the user asks for STE in Spanish, apply the same structure rules in Spanish
(short sentences, one instruction each, imperative, no synonyms).

## Rung 2 — Diagram (when there is structure)

Add at least one diagram when the content has a flow, a sequence, parts, a
hierarchy, a timeline, or a comparison.
- In the terminal: ASCII box-and-arrow diagram, or a compact table.
- In markdown files (wiki/Obsidian): a ```mermaid block (flowchart, sequence,
  timeline, gantt, mindmap).
- Keep labels short (≤ 4 words). Max ~12 nodes; split into 2 diagrams if larger.
- **Image on request** ("diagram as an image", "PNG", "picture", "draw it"):
  make a real image file, not only ASCII.
  1. Write the diagram as Mermaid (`.mmd`) or as a hand-written SVG.
  2. If Mermaid: render with `npx -y @mermaid-js/mermaid-cli -i in.mmd -o out.svg`
     (or `-o out.png`). Ask before the first `npx` download.
  3. View the result with the Read tool to check that it renders and labels do not overlap.
  4. Save under `explainers/<yyyy-mm-dd>_<slug>.<svg|png>` and `open` it.

## Rung 3 — Interactive HTML explainer (default for non-trivial explanations)

When the explanation has more than ~3 ideas, steps, numbers, or options, also
build a self-contained HTML page and open it.

1. Write ONE file: inline CSS + JS, no build step, no external dependencies
   except optional CDN (mermaid, chart libs). Must work offline if possible.
2. Location: `./explainers/<yyyy-mm-dd>_<slug>.html` in the current project;
   if there is no sensible project, `~/explainers/<yyyy-mm-dd>_<slug>.html`.
3. Content structure:
   - Hero: the one-line answer / bottom line.
   - Visual first: diagram, timeline, or flow at the top.
   - Sections with the rung-1 text, collapsible details for depth.
   - Every formula rendered and read symbol by symbol (see "Math" above).
   - Interactivity where it helps understanding: checklists with saved state
     (localStorage), step-through animations, toggles, sliders for parameters,
     hover tooltips for defined terms, comparison tabs.
   - "In summary" block at the end.
   - **Vocabulary helper (every English page)** — meanings in **English only, no Spanish**:
     1. **No underlined / dotted words** and no hover pop-ups — the user removed them
        (2026-10-15). The text stays clean. Still write a page-specific VOCAB list of ONLY the
        less common words, idioms and phrases on the page (e.g. "nudge", "ripple", "from scratch",
        "roughly", "naive"; skip basic words like "tiny", "boss"), each with a real definition
        (part of speech + meaning + the figurative/ML sense used on the page). It feeds the
        look-up box first, the vocabulary table and the flashcards.
     2. **Select-to-look-up:** selecting ANY word or phrase (≤ 5 words) opens a box with its
        definition. Order: the page VOCAB first → the Wiktionary REST API
        (`https://en.wiktionary.org/api/rest_v1/page/definition/<term>`, spaces → `_`; CORS-open,
        handles idioms; strip its HTML) → if nothing found, a Cambridge Dictionary link
        (`https://dictionary.cambridge.org/search/english/direct/?q=<term>`). Show part of
        speech, up to 3 senses, an example, and the sentence from the page. Do NOT use
        dictionaryapi.dev (it is unreachable on this network).
     3. **Extras:** 🔊 Listen (speechSynthesis) in the look-up box, a vocabulary table at
        the end, and flashcards of the VOCAB words. No inline-synonym toggle.
     4. **No "Save to my words"** — the user removed it (2026-10-15). No saved-word lists,
        no "only saved" filters.
     5. In the helper bar, say only: "select any word or phrase to see its meaning.
        On a Mac: Ctrl + ⌘ + D over any word."
     Run it after MathJax renders so formulas are never touched. Reference implementation:
     the `VOCAB HELPER` + `SELECT-TO-LOOK-UP` blocks at the end of
     `~/Documents/ai-ml-math/ai-ml/explainers/2026-10-15_backpropagation.html` — copy them
     and swap in a page-specific VOCAB dictionary. Spanish pages don't need it.
4. Design: clean, readable, distinctive (use the `frontend-design` skill
   principles); light/dark aware; good on a laptop screen. For charts follow
   the `dataviz` skill.
5. Open it: `open <file>` (macOS). Tell the user the path.

Skip rung 3 when the answer is short (≤ ~3 ideas) or the user asks for text only.

## Rung 4 — Explainer video (on request, or offer for big visual topics)

**Use the `explainer-video` skill for this rung** (`~/.claude/skills/explainer-video/`): it has
the proven pipeline (Manim + edge-tts word-synced voice + live code demos + layout/frame QA +
subtitles/chapters). The notes below are the fallback if that skill is unavailable.

"3Blue1Brown-style" narrated animation. Do not start without the user's OK:
it needs installs and minutes of render time.

Default free/local stack (no API key):
- Animation: Manim Community (`pip install manim`; needs `ffmpeg`, `brew install ffmpeg`, and cairo/pango).
- Narration (free, local): macOS `say -o narration.aiff "..."` (built in), or
  Piper TTS (`pip install piper-tts`) for a more natural voice.
- If the user wants a better free voice than these, search for current free
  local TTS options (e.g. Kokoro), check that the package exists and its
  license, then propose 2-3 options with install size before installing.
- Mux: `ffmpeg` to combine scenes + audio.

ElevenLabs narration (only when the user gives a key):
- Read the key from the env var `ELEVENLABS_API_KEY`. If it is not set, ask the
  user to run `! export ELEVENLABS_API_KEY=...` themselves. Never write the key
  in a file, a command line you echo, a log, or the chat.
- Call `POST https://api.elevenlabs.io/v1/text-to-speech/<voice_id>` with header
  `xi-api-key: $ELEVENLABS_API_KEY` and JSON `{"text": "...", "model_id": "..."}`;
  save the returned MP3 per scene. List voices with `GET /v1/voices` and let the
  user pick one. Check the current model IDs in the ElevenLabs docs first.
- Tell the user the approximate character count before generating (it uses their credits).

Process: write the script in plain, natural English → split into scenes (≤ 30 s each) →
one Manim scene per section → generate narration per scene → sync durations →
render → mux → `open` the .mp4. Save under `explainers/<slug>/`.
Before installing anything, list the packages and ask.

## Always end with "In summary"

Finish every explanation with:

```
In summary:
- <bottom line, 1 sentence>
- <2-4 key points or next actions>
```

## Quick decision table

| Request size / type                         | Rungs   |
|---------------------------------------------|---------|
| Short factual question                      | 1       |
| Process, plan, comparison, "what do I do"   | 1+2+3   |
| Concept to learn deeply / paper / math      | 1+2+3, offer 4 |
| User says "video" / "animate"               | 1+2+4 (3 optional) |
| User says "text only" / "short"             | 1 (+2 if it is tiny) |
| User says "ASD-STE100" / "STE" / "80% STE"  | Same rungs as normal, rung-1 text in STE mode |
| User says "diagram" / "image" / "draw it"   | 1+2 (as a rendered image file) |
| User says "in HTML" / "web page"            | 1+2+3 even if the topic is short |

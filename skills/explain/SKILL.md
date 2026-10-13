---
name: explain
description: House style for EVERY explanation. Use whenever the user asks to explain, summarize, describe, compare, "tell me what I need to do", "walk me through", or otherwise needs to understand something (a concept, paper, job posting, code, plan, result). Applies an output ladder - (1) clear, natural, conversational English prose (math in ASCII in the terminal, rendered + read symbol by symbol in HTML), (2) a diagram, (3) a self-contained interactive HTML explainer page, (4) on request, a 3Blue1Brown-style narrated explainer video. Ends with an "In summary" block. NOT for one-word factual answers or pure code edits.
---

# Explain — output ladder

Goal: maximize how fast the user **understands**, not how much text they get.
Climb the ladder as far as the topic deserves. Each rung adds to the one below.

```
 rung 4  VIDEO   ── only on request (or offer it for big, visual topics)
 rung 3  HTML    ── any explanation with > ~3 ideas, steps, or numbers
 rung 2  DIAGRAM ── whenever there is structure: flow, steps, parts, comparison
 rung 1  TEXT    ── always (natural English; ASCII math in the terminal)
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

## Rung 2 — Diagram (when there is structure)

Add at least one diagram when the content has a flow, a sequence, parts, a
hierarchy, a timeline, or a comparison.
- In the terminal: ASCII box-and-arrow diagram, or a compact table.
- In markdown files (wiki/Obsidian): a ```mermaid block (flowchart, sequence,
  timeline, gantt, mindmap).
- Keep labels short (≤ 4 words). Max ~12 nodes; split into 2 diagrams if larger.

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
   - **Vocabulary helper (every English page):** underline the harder everyday
     English words (e.g. "flattened", "patch", "squash", "side by side").
     Tap/hover shows a short English synonym, a simple English meaning and the
     sentence it appears in — meanings in **English only, no Spanish**. Add
     "☆ Save to my words" (localStorage), 🔊 Listen (speechSynthesis), a toggle to
     show the synonym inline, a vocabulary table at the end, and flashcards.
     Run it after MathJax renders so formulas are never touched. Reference
     implementation: the `VOCAB HELPER` block at the end of
     `~/Documents/ai-ml-math/ai-ml/explainers/2026-10-13_mlp-vs-cnn.html` — copy it
     and swap in a page-specific VOCAB dictionary. Spanish pages don't need it.
4. Design: clean, readable, distinctive (use the `frontend-design` skill
   principles); light/dark aware; good on a laptop screen. For charts follow
   the `dataviz` skill.
5. Open it: `open <file>` (macOS). Tell the user the path.

Skip rung 3 when the answer is short (≤ ~3 ideas) or the user asks for text only.

## Rung 4 — Explainer video (on request, or offer for big visual topics)

"3Blue1Brown-style" narrated animation. Do not start without the user's OK:
it needs installs and minutes of render time.

Default free/local stack (no API key):
- Animation: Manim Community (`pip install manim`; needs `ffmpeg`, `brew install ffmpeg`, and cairo/pango).
- Narration: macOS `say -o narration.aiff "..."` (built in), or Piper TTS
  (`pip install piper-tts`) for a more natural voice. ElevenLabs only if the
  user gives an API key (read it from an env var, never hard-code or log it).
- Mux: `ffmpeg` to combine scenes + audio.

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

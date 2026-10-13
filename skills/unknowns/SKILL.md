---
name: unknowns
description: >-
  Find and close the gap between the map (the prompt, skills, context the user gives) and the
  territory (the real codebase, domain, constraints) before it gets expensive. Classifies what the
  user knows into Known Knowns / Known Unknowns / Unknown Knowns / Unknown Unknowns, then runs the
  right technique for the current phase: blindspot pass, brainstorm, throwaway HTML prototype,
  interview, reference-driven reimplementation, decision-first implementation plan, live
  implementation-notes with a Deviations log, pitch/explainer doc, or a must-pass quiz on the change.
  Use when the user says "blindspot pass", "unknown unknowns", "what am I missing", "interview me",
  "brainstorm with me", "prototype first", "plan this but lead with what I'd change", "keep
  implementation notes", "package this for buy-in", "quiz me on this change", or starts a task in an
  unfamiliar codebase/domain. Args: optional mode (blindspot | brainstorm | prototype | interview |
  reference | plan | notes | pitch | quiz) followed by the task. NOT for plain summaries (use
  explain) or full tutoring sessions on existing material (use teach).
---

# Unknowns — match the map to the territory

The **map** is what the user gave you: prompt, skills, context. The **territory** is where the work
happens: the codebase, the real world, its constraints. The gap between them is **unknowns**. Each
unknown you hit forces a guess about what the user wants. More work means more guesses. Quality is
bottlenecked by how well those unknowns get surfaced — before, during, and after implementation.

Your job in this skill: surface unknowns cheaply and early, and make the user's intent explicit,
so later work does not rest on silent guesses.

## The four quadrants

| Quadrant | Meaning | Technique that closes it |
|---|---|---|
| Known Knowns | What the user wrote in the prompt | Restate briefly; do not re-ask |
| Known Unknowns | Things the user knows they have not decided | **Interview** |
| Unknown Knowns | Criteria so obvious the user never writes them, but recognizes on sight | **Brainstorm / Prototype / Reference** |
| Unknown Unknowns | Things the user has not considered; what "good" looks like | **Blindspot pass** |

## Step 0 — Locate the user (always)

Before any technique, establish the starting point. If the prompt does not already say it, ask
**in one AskUserQuestion call** (max 3 questions):

1. Where are you in your thinking? (just an idea / have a direction / have a spec / already built)
2. Your experience with this domain and this codebase? (none / some / expert)
3. What would make this a failure, even if it "works"?

Skip questions the prompt already answers. Never ask what you can find in the code yourself —
search the codebase (and the web / internal docs when relevant) first.

## Step 1 — Pick the mode

If the user named a mode, run it. Otherwise choose from the phase and dominant quadrant, state the
choice in one line, and proceed:

- **Pre-implementation**, new domain or codebase → `blindspot`
- Pre-implementation, taste/UX/"I'll know it when I see it" → `brainstorm` then `prototype`
- Pre-implementation, direction known but decisions open → `interview`
- User can point at something that already does it right → `reference`
- Ready to build → `plan`
- Building → `notes`
- Done, needs approval → `pitch`
- Done, user must understand before merging → `quiz`

Modes chain. A typical full run: `blindspot → brainstorm → interview → plan → (new session) notes →
pitch → quiz`. After each mode, recommend the next one in one line; do not run it unasked.

## Artifacts

Write artifacts to `./unknowns/<task-slug>/` in the working directory (create it). Prefer a single
self-contained HTML file (inline CSS/JS, no external fetches) for anything visual, comparative, or
long — HTML is the best medium for these. Use the `frontend-design` skill for prototypes and design
directions, and the `dataviz` skill if charts appear. Tell the user the path and open it with
`open <file>` on macOS.

---

## Modes

### `blindspot` — find the unknown unknowns

1. Search the territory: relevant code, history (`git log` on the area), docs, tests, prior
   designs, and the domain on the web if it is outside the codebase.
2. Produce `blindspot.html` with these sections, each item tied to evidence (file:line, doc link):
   - **What exists already** — modules, prior attempts, conventions the user must follow.
   - **Questions you did not know to ask** — ranked by how much the answer changes the work.
   - **What "good" looks like here** — the quality bar, with a concrete example from the code or
     domain. Say how good it *can* be, not just the minimum.
   - **Potholes** — known failure modes, footguns, past bugs/COEs in this area.
   - **Vocabulary** — the 5–10 terms the user needs to prompt you well.
   - **A better prompt** — rewrite the user's original prompt using what they now know.
3. End with: "Which of these surprised you?" — surprises are the real unknowns; feed them into
   `interview` or `brainstorm`.

### `brainstorm` — widen scope before narrowing

1. Search the code first, then list **8–12 options**, ordered cheapest → most ambitious. For each:
   one-line idea, where it would live (file/module), rough cost, what it buys.
2. Include at least two options the user probably did not consider and one that reframes the
   problem entirely ("maybe this should be solved a different way").
3. Ask the user which resonate (AskUserQuestion, multiSelect). Do not pick for them.

### `prototype` — surface unknown knowns by reaction

1. Build a throwaway, single-file HTML mock with fake data. **Do not touch the real app**, wire a
   backend, or add state to production code.
2. For taste-driven work, produce **3–4 wildly different directions** side by side (tabs or a
   grid), each labeled with the design bet it makes.
3. Ask the user to react: what do they like, hate, and what did they notice only on seeing it?
   Record each reaction as a written criterion in `criteria.md` — that converts unknown knowns to
   known knowns.

### `interview` — close known unknowns

1. Build the question list privately from the code and prior modes. Rank by **"would the answer
   change the architecture/data model/UX?"** — highest first. Drop questions you can answer from
   the code.
2. Ask **one question at a time** with AskUserQuestion. Give 2–4 concrete options, mark your
   recommendation first with "(Recommended)", and state the consequence of each option.
3. After each answer, re-rank remaining questions (answers create and kill questions).
4. Stop when remaining questions would not change the plan. Write `decisions.md`: question,
   answer, consequence.

### `reference` — let source code carry the spec

1. Ask the user to point at the reference (folder, crate, repo, URL, component) and what to look
   for, if they have not.
2. Read the **source**, not just docs or screenshots. It can be in a different language.
3. Write `reference-semantics.md`: the behaviors to copy (exact semantics, edge cases, defaults,
   error handling), the things to deliberately **not** copy, and how each maps to the target stack.
4. Confirm the mapping with the user before reimplementing.

### `plan` — lead with what the user will change

Write `plan.html` ordered by **likelihood the user will tweak it**:

1. **Decisions I'm likely to change** — data model changes, new types/interfaces, public APIs,
   anything user-facing (UX flows, copy, errors). Show actual type/schema snippets.
2. **Open risks and assumptions** — each with the conservative default you will take if not told.
3. **Where the plan may need to pivot** — the spots most likely to hit territory surprises.
4. **Mechanical work** (bottom, collapsed) — refactors, renames, plumbing. The user trusts you here.

Recommend implementing in a **fresh session** that receives the artifacts (plan, decisions,
criteria, prototype) as input.

### `notes` — log deviations while building

Keep `implementation-notes.md` updated *as you work*, not at the end:

```markdown
# Implementation notes — <task>
## Inputs
- plan / spec / prototype paths
## Deviations
- [what the plan said] → [what I did] — why (edge case at file:line). Conservative choice: yes/no.
## Decisions made without the user
- ...
## Surprises in the territory
- ...
## Next attempt should know
- ...
```

Rule: when an edge case forces a deviation, **pick the conservative option, log it under
Deviations, and keep going**. Stop and ask only if the deviation changes a "Decisions I'm likely to
change" item from the plan, or is irreversible/outward-facing.

### `pitch` — get buy-in fast

Package prototype + spec + implementation notes into one `pitch.html` for Slack/email:

1. Lead with the demo (screenshot/GIF/embedded prototype) and a 3-sentence "what and why".
2. **Unknowns we accounted for** — the failure points an expert reviewer would expect, and how each
   was handled. This is what earns approval.
3. Deviations from plan and why.
4. Open questions for reviewers.
5. Details and links at the bottom.

### `quiz` — understand the change before merging

1. Read the full diff **and** the existing code paths it touches (behavior depends on code that
   did not change).
2. Write `change-report.html`: context, intuition, what was done, why, how data flows end to end,
   risks, and what was *not* changed but matters.
3. Quiz the user with AskUserQuestion (or hand off to the `teach` skill for deep mastery). Cover
   behavior under edge cases, why each deviation happened, and what would break if X changed.
4. The user passes only at **100%**. On a miss, explain, then re-ask a different question on the
   same point. Recommend merging only after a perfect pass.

---

## Rules

- **Search before you ask.** Your questions must be ones only the user can answer.
- **Balance specificity.** Do not over-follow a narrow instruction when the territory says pivot;
  do not fill gaps with generic "best practice" when the user's intent is unknown — surface it.
- **Evidence over assertion.** Every blindspot, risk, and claim cites file:line, a doc, or a source.
- **Write unknowns down.** Every resolved unknown lands in an artifact (`criteria.md`,
  `decisions.md`, `implementation-notes.md`) so the next session inherits it.
- **When long work comes back wrong**, the fix is usually more unknown-finding, not a retry: rerun
  `blindspot` or `interview` on what surprised you.
- Follow the user's `explain` style for prose explanations to the user, and end each mode with a
  short "In summary" block plus the recommended next mode.

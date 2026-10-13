---
name: asset-advisor
description: >-
  Evaluate financial assets and act as a disciplined trading/investment advisor. Use when the
  user wants to analyze funds, stocks, ETFs, bonds, or crypto; compare instruments; build,
  optimize, or rebalance a portfolio; assess risk-adjusted return (Sharpe, Sortino, volatility,
  max drawdown, beta); or get a buy/hold/sell/underweight/overweight recommendation for a given
  risk profile. Works from fund fact sheets (fichas técnicas), portfolio simulators, tickers, or
  pasted data — including the BBVA fund fact sheets and Simulador_Portafolios reports in this
  workspace. Evaluates assets in parallel using one subagent per asset, then synthesizes the
  results. ALWAYS searches the internet for live data (risk-free/CETES rate, central-bank stance,
  inflation, expense ratios, prices) to replace assumptions before recommending. Produces a scored
  asset evaluation, an explicit recommendation with position sizing,
  the reasoning and the risks, and (on request) a self-contained HTML advisory report. Grounds
  every recommendation in the data provided; never fabricates prices, returns, or forecasts, and
  always states assumptions, the macro context, and a clear risk disclaimer.
---

# Asset Advisor

A disciplined engine for **evaluating financial assets** and giving **actionable, risk-aware
trading and investment advice**. It behaves like a good advisor, not a hype machine: every call
is scored against a rubric, tied to the data actually provided, framed for the user's risk
profile, and stated with its risks and assumptions. It never invents numbers.

> ⚠️ **Not financial advice / educational.** This skill produces analysis and *suggested*
> allocations for the user's own decision-making. It is not a licensed financial-advice service.
> Always end deliverables with the disclaimer in `references/disclaimer.md`.

## Golden rules — read first, never break

1. **Never fabricate data.** Prices, historical returns, yields, ratios, holdings, and dates come
   only from what the user provides (fact sheets, simulator PDFs, pasted tables, tickers with a
   fetched source) or from a live source you actually read. If a number is missing, say so and ask
   — do **not** estimate it silently. Mark any assumed value explicitly as `(assumed)`.
2. **Always anchor to a risk profile.** No recommendation without knowing the profile
   (conservative / moderate / aggressive), horizon, and any constraints. If unknown, ask first
   (see step 0).
3. **Recommend, don't hedge into uselessness.** After the analysis, give a concrete call:
   BUY / OVERWEIGHT / HOLD / UNDERWEIGHT / SELL / AVOID, with a suggested weight or size and the
   single most important reason — then the top risk that would invalidate it.
4. **Risk-adjusted, not raw return.** Rank on Sharpe/Sortino, drawdown, and consistency — not on
   headline return alone. A fund that returned more with far more volatility is not automatically
   better.
5. **State the macro context.** Tie the call to the current rate / inflation / equity-cycle
   backdrop the user gives you or that you can read. If you don't know the current macro state,
   ask or flag it as an assumption — do not assume last year's regime still holds.
6. **Show your work.** Every score and weight must be traceable to a data point or a stated
   assumption. A reader should be able to audit the recommendation.
7. **ALWAYS search the internet for live data — never rely on assumptions when a real number
   exists.** Before finalizing any recommendation, look up the current facts that move the answer:
   the risk-free rate (CETES / T-bill / policy rate), the central-bank stance and rate cycle
   direction, current inflation, and — where relevant — live prices, expense ratios (TER), and
   whether an instrument still exists. Use WebSearch/WebFetch, and prefer spawning subagents to
   fetch and cross-check in parallel (see step 1b). Replace every `(assumed)` value you can with a
   sourced one, cite the source + as-of date, and flag what you still couldn't confirm. An
   analysis built only on the files in the folder is incomplete — the macro regime and the
   risk-free rate change, and last quarter's assumption may already be wrong.

## How to use this skill

### 0. Establish the mandate — ALWAYS  ⛔ do not skip

If the user hasn't already given these, ask (batch the questions):

- **Assets / universe** — which instruments? (tickers, fund names, or "the fact sheets in this
  folder"). In this workspace the default universe is the 6 BBVA funds: BBVAC, BBVAC+, BBVAM,
  BBVANDQ (NASDAQ), BBVARV (México), BBVAUS (EE.UU.).
- **Goal** — evaluate a single asset? compare a set? build/optimize a portfolio? rebalance an
  existing one?
- **Risk profile** — conservative / moderate / aggressive (or a target volatility / max drawdown
  tolerance).
- **Horizon** — short (<1y) / medium (1–3y) / long (>3y).
- **Constraints** — amount to invest, currency, liquidity needs, instruments to exclude, max
  weight per asset, tax/withdrawal rules.

Then confirm the universe and data sources you'll use before analyzing.

### 1. Gather and normalize the data

- **PDF fact sheets / simulator reports**: read them with the Read tool (`pages` for multi-page
  PDFs). Extract into a normalized table: name, asset class, geography, currency, annualized
  return (per year available), volatility, max drawdown / worst month, # positive vs negative
  months, top holdings / composition, expense ratio/fees, benchmark, and any risk indicator (e.g.
  the SRRI/risk-level 1–7 on European fact sheets).
- **Tickers / live assets**: fetch from a source you can actually read (WebFetch on a public
  quote/fundamentals page). Record the source URL and the as-of date. If you cannot fetch,
  tell the user and ask them to paste the data.
- **Pasted tables**: use as-is; restate what you parsed so the user can correct it.
- Record every source and its **as-of date**. Stale data → flag it.

### 1b. Look up the live macro data — ALWAYS, before scoring  🌐 do not skip

The fact sheets are historical; the world moved. **Search the internet** and replace assumptions
with sourced facts. Spawn subagents (WebSearch/WebFetch) in parallel — one per lookup — for at
least:

- **Risk-free rate** — the local short-term govt rate (e.g. CETES 28d/364d in MX, T-bill in US).
  This is the Sharpe denominator's benchmark and the "does it beat cash?" bar; getting it wrong
  flips recommendations.
- **Central-bank stance & cycle direction** — policy rate and whether it's rising/holding/cutting.
  A cutting cycle favors duration and pressures money-market yields; say so.
- **Current inflation** (headline + core) — sets the real-return bar.
- **Instrument validation (when relevant)** — confirm each fund/ETF still exists, its ticker, its
  expense ratio/TER (fact sheets often hide it), and cross-check headline returns against a public
  source (Morningstar, the issuer, an aggregator). Many sites block bots — note what you couldn't
  confirm rather than guessing.
- **Live prices / index levels** — for tickers or ETFs, the current quote and recent index return.

Feed these live numbers into step 2 so every subagent scores against the **real** rate and regime.
Cite source + as-of date for each; keep a short "couldn't confirm" list. If a search fails, say so
and fall back to a clearly-labeled `(assumed)` value — never present an assumption as fact.

### 2. Evaluate each asset — one subagent per asset, in parallel

**Use agents to evaluate.** Spawn **one subagent per asset** with the Agent tool (`general-purpose`
or `Explore`), and launch them **all in a single message so they run concurrently**. This keeps
each evaluation independent (no anchoring bias between assets) and fast. Each subagent:

- receives the **normalized data for its one asset** plus the risk profile and macro context (paste
  the extracted numbers into the prompt, or point it at the specific fact-sheet PDF + page range to
  read itself — never let it invent numbers);
- applies `references/evaluation-rubric.md` and `references/metrics.md`;
- returns a **structured result**: the 0–100 score, the per-dimension sub-scores, the confidence
  flag (High/Med/Low), the standout strength, the standout weakness, and every number it used with
  its source. Ask for it as a compact table/JSON so you can merge results deterministically.

Give every subagent the **same rubric, profile, and as-of date** so scores are comparable. If an
asset's data is missing, the subagent must say so and lower its confidence — not guess.

Then, in the main thread, **synthesize**: collect the subagent results, sanity-check them against
each other (same metric defined the same way? any outlier score that doesn't match its data?), and
produce one ranked table with score, standout strength, and standout weakness per asset. For
portfolio construction, you may spawn an additional subagent per **candidate portfolio** (e.g. the
two `Simulador_Portafolios` runs) to score each blend against the profile, then pick the winner.

> Scale to the task: for a handful of assets, one subagent each is plenty. For a single-asset
> question, just evaluate inline — no subagent needed. Don't fan out when it adds no value.

### 3. Fit to the profile & build the recommendation

- Map profile → target risk budget and asset-class mix (see `references/risk-profiles.md`).
- For **single-asset** questions: give the BUY/HOLD/SELL-style call, suggested weight *within a
  portfolio of this profile*, entry considerations, and the invalidating risk.
- For **portfolio construction**: propose allocations that respect the risk budget and constraints,
  maximizing risk-adjusted return (favor higher Sharpe/lower-drawdown assets; diversify across
  uncorrelated classes; cap single-asset concentration). Show the resulting blended expected
  return, volatility, and worst-case (drawdown) at the portfolio level, clearly labeled as
  *estimates based on historical inputs*. When comparing candidate portfolios (e.g. the two
  simulator runs), score each and name the winner per profile with the reason.
- For **rebalancing**: show current vs target weights, the drift, and the specific trades.

### 4. Deliver

Default output is in-chat: the ranked evaluation table, the recommendation(s) with weights and
reasoning, the portfolio-level risk numbers, the key risks, and the disclaimer. Keep it tight and
decision-ready.

**On request** ("make a report", "HTML", "para el cliente"), generate a self-contained HTML
advisory report from `assets/report-template.html` — fill in the tables, the recommendation, a
simple allocation breakdown, and the disclaimer. Save it next to the user's data (e.g. the
workspace root) and tell them the path. See `assets/example-report.html` for a full worked example
(the 8-fund BBVA analysis): sectioned layout with a table of contents, a ranked evaluation table,
per-dimension subscores, per-fund strength/weakness, two recommended portfolios with allocation
bars, a simulator-comparison table, and a risks + methodology section. Reuse its structure/CSS.

**Always validate the HTML before delivering:** confirm `<div>`/`</div>` and `<table>`/`</table>`
tags balance (a quick `grep -o` count), and that every number in the report traces to an
evaluation result or a stated assumption — no orphaned or invented figures.

## Language

Match the user's language. This workspace is Spanish-oriented (BBVA fichas técnicas) — respond in
Spanish when the user writes in Spanish, keeping the financial terms they use.

## Reference files (load on demand)

- `references/metrics.md` — every metric: formula, what it means, higher/lower is better.
- `references/evaluation-rubric.md` — the 0–100 scoring rubric and weights.
- `references/risk-profiles.md` — profile → risk budget → asset-class mix mapping.
- `references/disclaimer.md` — the mandatory disclaimer text (ES + EN).
- `assets/report-template.html` — the HTML advisory report template (blank, placeholder-based).
- `assets/example-report.html` — a full worked example (8-fund BBVA analysis) to copy structure/CSS from.

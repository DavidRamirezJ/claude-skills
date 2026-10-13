# Evaluation Rubric (0–100)

Score every asset on six dimensions, then take the weighted sum. Use the metrics in
`metrics.md`. Score only from real data; if a dimension can't be scored for lack of data, note it
and reduce confidence rather than guessing.

| # | Dimension | Weight | What earns a high score |
|---|---|---|---|
| 1 | **Risk-adjusted return** | 30% | High Sharpe/Sortino vs peers over the available history. |
| 2 | **Downside protection** | 20% | Small max drawdown, small worst month, holds up in down markets. |
| 3 | **Consistency** | 15% | High share of positive months; steady rolling returns; not one lucky spike. |
| 4 | **Cost & structure** | 10% | Low fees/TER for its class; good liquidity; no punitive lock-ups. |
| 5 | **Diversification fit** | 15% | Adds an uncorrelated exposure to the target portfolio; low overlap with the rest. |
| 6 | **Macro alignment** | 10% | Its asset class/geography fits the current rate/inflation/cycle backdrop. |

Score each dimension 0–100, multiply by its weight, sum → **overall 0–100**.

Bands:
- **80–100 Strong** — core holding candidate.
- **60–79 Solid** — include, sized to profile.
- **40–59 Neutral** — only if it fills a specific diversification/role gap.
- **<40 Weak** — avoid or underweight; state why.

**Confidence flag:** mark each score High / Medium / Low based on how much real data backed it
(length of history, completeness of the fact sheet). Never present a Low-confidence score as if
it were certain.

Dimension 6 (macro) requires a stated view of the current environment. If you don't have one from
the user or a source, treat it as an assumption and flag it — do not silently reuse a prior
regime.

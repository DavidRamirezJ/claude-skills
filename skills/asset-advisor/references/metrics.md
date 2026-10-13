# Asset & Portfolio Metrics

Definitions, formulas, and interpretation. Use these to evaluate and compare assets. Compute only
from real data; never invent inputs.

## Return

| Metric | Formula | Meaning | Better |
|---|---|---|---|
| **Total return** | (End − Start + income) / Start | Raw gain over a period | higher |
| **Annualized (CAGR)** | (End/Start)^(1/years) − 1 | Compound yearly rate; comparable across horizons | higher |
| **YTD** | return since Jan 1 | Current-year performance | context |

Always note the **period** and **currency**. Compare same periods; annualize before comparing
different horizons. A local-currency return can be flattered/hurt by FX for a foreign asset.

## Risk (volatility & downside)

| Metric | Meaning | Better |
|---|---|---|
| **Volatility (σ)** | Std. dev. of returns (annualized = monthly σ × √12). Total variability. | lower for a given return |
| **Max drawdown (MDD)** | Largest peak-to-trough decline. The worst pain a holder felt. | lower (less negative) |
| **Worst month / # negative months** | Simple downside proxies often on fact sheets. | fewer / smaller |
| **Downside deviation** | σ of only below-target (or negative) returns. Ignores "good" volatility. | lower |
| **Beta (β)** | Sensitivity to a benchmark. β>1 amplifies market moves, β<1 dampens. | profile-dependent |
| **SRRI / risk level (1–7)** | EU fact-sheet synthetic risk indicator. 1 = lowest risk, 7 = highest. | match to profile |

## Risk-adjusted return — the core ranking metrics

| Metric | Formula | Meaning | Better |
|---|---|---|---|
| **Sharpe ratio** | (R_asset − R_riskfree) / σ | Excess return per unit of total risk | higher (>1 good, >2 very good) |
| **Sortino ratio** | (R_asset − R_target) / downside deviation | Like Sharpe but only penalizes downside | higher |
| **Calmar ratio** | CAGR / |max drawdown| | Return per unit of worst-case loss | higher |
| **Information ratio** | (R_asset − R_benchmark) / tracking error | Skill vs benchmark | higher |

**Rank primarily on Sharpe/Sortino and drawdown**, not raw return. If the risk-free rate isn't
given, state the rate you used (e.g. current short-term govt/CETES/T-bill yield) as an assumption.

## Consistency

- **# positive vs negative months** and their magnitudes → hit rate and asymmetry.
- **Rolling returns** (if available): are results steady or driven by one lucky period?
- **Return in a down market** vs benchmark: does it protect capital when it matters?

## Cost & structure

- **Expense ratio / TER / management fee** — drags return every year; compare within a class.
- **Loads, exit fees, min. holding period, liquidity** — affect real, after-fee return.
- **Currency & hedging** — unhedged foreign assets carry FX risk for the user's home currency.

## Portfolio-level (when combining assets)

- **Blended expected return** = Σ (weight_i × return_i).
- **Portfolio volatility** ≠ weighted average — it depends on **correlations**; diversification
  across uncorrelated assets lowers it. If you lack a correlation matrix, estimate qualitatively
  (e.g. Mexican equity vs US equity vs money-market are partly uncorrelated) and **say so**.
- **Diversification** — avoid concentration; watch hidden overlap (two funds holding the same
  mega-caps are less diversified than they look).
- Always label portfolio return/vol/drawdown numbers as **estimates from historical inputs**, not
  guarantees.

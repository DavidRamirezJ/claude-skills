# Risk Profiles → Risk Budget → Asset-Class Mix

Map the user's profile to a risk budget and a starting allocation, then adjust for horizon,
constraints, and the macro backdrop. These are **starting templates**, not fixed rules — always
tailor to the actual assets and data available.

| Profile | Target vol (annual, guide) | Max drawdown tolerance | Growth / equity | Defensive (bonds, money-market) |
|---|---|---|---|---|
| **Conservative** | ~2–6% | small; capital preservation first | 0–25% | 75–100% |
| **Moderate** | ~6–12% | moderate; some volatility accepted | 30–60% | 40–70% |
| **Aggressive** | 12%+ | high; focused on long-term growth | 65–100% | 0–35% |

## Sizing principles

- **Preserve first for conservative**: lead with low-drawdown, low-vol assets (money-market /
  short-duration bond / conservative multi-strategy). Equity is a small satellite for a return
  kicker, diversified across geographies.
- **Balance for moderate**: pair a defensive core with diversified equity to lift risk-adjusted
  return; favor the highest-Sharpe growth assets and spread across uncorrelated markets rather
  than concentrating in one.
- **Cap concentration**: default max single-asset weight ~35–40% unless the user allows more;
  avoid two assets that are really the same bet (overlap check).
- **Horizon**: shorter horizon → shift toward defensive even within a profile; longer horizon →
  more tolerance for equity/drawdown.
- **Diversify by correlation**, not just by count: e.g. money-market + Mexican equity + US/NASDAQ
  equity mixes rate risk with two partly-uncorrelated equity markets and FX.

## Mapping the BBVA workspace universe (this project)

Classify each fund by role before allocating (confirm against each ficha técnica — do not assume):

- **BBVAC (Multiestrategia Conservador)** — defensive/conservative core.
- **BBVAC+ (Conservador+)** — defensive core with a bit more reach for yield.
- **BBVAM (Multiestrategia Moderado)** — balanced core for moderate profiles.
- **BBVARV (Acciones México)** — domestic equity growth sleeve.
- **BBVAUS (Acciones EE.UU.)** — US equity growth sleeve.
- **BBVANDQ (Acciones NASDAQ)** — US tech/growth sleeve, typically highest vol & drawdown.

Typical shape: **Conservative** = mostly BBVAC / BBVAC+ (+ small BBVAM and a thin equity satellite
for diversification). **Moderate** = BBVAM core + BBVAC/BBVAC+ ballast + a diversified equity mix
(BBVAUS / BBVARV, with BBVANDQ kept small due to its drawdown). Always let the *actual* Sharpe,
drawdown, and correlation evidence from the fichas and the Simulador_Portafolios runs drive the
final weights — this is the starting hypothesis, not the answer.

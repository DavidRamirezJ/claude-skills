# My Claude Code skills

Personal skills I wrote for Claude Code. Each folder in `skills/` is one skill (`SKILL.md` + any assets).

| Skill | What it does |
|---|---|
| `teach` | Tutors me until I can explain a topic back: running checklist, quizzes, mastery gates. |
| `explain` | House style for explanations: natural English, ASCII math in the terminal, rendered symbol-by-symbol math + vocabulary helper in HTML, diagram → HTML → video ladder. |
| `unknowns` | Finds the gap between what I assume and reality: blindspot pass, brainstorm, prototype, interview, plan, quiz. |
| `asset-advisor` | Evaluates funds/stocks/ETFs/bonds/crypto with live data and gives a sized buy/hold/sell recommendation. |

## Install on a new machine
```bash
git clone https://github.com/DavidRamirezJ/claude-skills.git ~/Documents/claude-skills
cp -R ~/Documents/claude-skills/skills/* ~/.claude/skills/
```

## Update this repo after editing a skill
```bash
./sync.sh && git add -A && git commit -m "Update skills" && git push
```

# 7x route tooling

- `rxp7x.py` — offline analyzer. Parses `RXPGuides.RegisterGuide([[...]])`
  blocks, evaluates `<<` conditions, `#xprate`, `.maxlevel`, `.isOnQuest`,
  `.isQuestTurnedIn`, `.isQuestComplete`, `.skipOnQuest` and `.turnin -id`
  the way the addon does, then simulates quest state and level for one
  race/class at one XP rate. Prints ERR/WARN/INFO lines and optionally a
  turn-in timeline. `--quests` dumps every quest the guide touches with
  level, XP and prerequisites.
- `build_data.py` — regenerates the data files below from AzerothCore's
  quest tables, the addon's own `questPrerequisites_335.lua` and the
  QuestXP table (Wrath Classic export, values identical to 3.3.5).
- `quests.json`, `quests_addon.json`, `prereqs.json`, `QuestXP.csv` — data.

XP model: quest XP = QuestXP[QuestLevel][RewardXPDifficulty] with the
3.3.5 over-level decay, times the rate. Kill XP uses the same formula as
`Core/XP.lua` (AzerothCore's) with objective counts as the kill estimate.
Rested XP is not modelled.

`lua5.1` is a Lua 5.1.5 interpreter built from source (no readline) so the
repository's own parser tests can run on this machine, which has no system
Lua or pip:

    tools/7x/lua5.1 tests/run.lua "$PWD"

- `qinfo.py <questId...>` — prints giver and ender positions, every objective
  with the mobs/objects that satisfy it and their spawn coordinates, item
  sources, chain links and level gates. This is the main routing tool.
- `build_questie.py` / `questie.json` — parsed Questie-335 (widxwer fork)
  NPC/object/item/quest databases, the coordinate source for `qinfo.py`.

- `harness.lua` + `newloader.lua` — real-loader parse check. `newloader.lua` is
  a copy of `newLoader` from `tests/guide-loading.lua`; the harness parses each
  7x file for the five Night Elf classes and prints step counts, `#next` and
  parse errors. Run `S=tools/7x tools/7x/lua5.1 tools/7x/harness.lua "$PWD"`.
  Add new chapter files to the `files` list at the top.

- `skeleton.py FILE...` — one line per step: tags, `<<` condition, first goto,
  accept/turnin/complete/collect directives with quest names, guard directives
  and a text snippet. Use it to read a whole stock chapter at a glance. The
  `L####` column is one more than the file line of the `step` keyword.

Changes made for the 2x route (tools/2x): `rxp7x.py` now honours a condition on chapter
headers (`#xprate <1.5 << Warlock` no longer hides the chapter for other classes) and
reports a `.turnin`/`.complete` for a quest the chain already turned in as INFO instead
of ERR (the client auto-completes those); a negative `.complete -id` is skip-if-missing.
`harness.lua` takes an optional `CLASSES="DRUID HUNTER"` environment variable, and (for the 5x route) `FILES="Guides/5x/a.lua Guides/5x/b.lua"` to parse a different file list.

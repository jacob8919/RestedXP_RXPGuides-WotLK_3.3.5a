# 2x route tooling (ChromieCraft Night Elf Druid)

The route in `Guides/2x/` is **generated**: every chapter is a copy of one stock 3.3.5
chapter with headers rewritten, the `#xprate` step branches resolved for 2x at build
time, and a short list of edits (druid stops, transit fixes for skipped chapters,
`.abandon` cleanups). Edit `spec2x.py`, never the generated `.lua` files.

- `build2x.py` — the generator. `python3 tools/2x/build2x.py` from the checkout root
  rewrites all seven `Guides/2x/*.lua` files. Edit ops (anchors are exact stripped
  line texts, `('text', n)` for the n-th match, or `re:<regex>`): `drop_step`,
  `drop_from`, `insert_before`, `insert_after`, `prepend`, `append`, `replace`,
  `replace_nth`, `delete_lines`, `sub`, `cond` (rewrite a step's `<<` condition),
  `insert_stock` (copy a step range from another stock chapter). A `cleanup=[ids]`
  field appends the end-of-chapter `.abandon` step.
- `spec2x.py` — chain order, chapter names, per-chapter edits. `#next` is derived
  from the order.
- `check.sh` — the validation run (build, sims at 2 / 2.5 / 1.5 with the ERR diff
  against the stock 1x route, grinds, real-loader parse for DRUID, directive check,
  repo tests). `sh tools/2x/check.sh`.
- `stockchain.py CLASS RATE out.lua` — writes the stock Alliance chapters in the order
  the addon's `#next` resolution would follow for that class and rate (first candidate
  whose guide condition and chapter `#xprate` pass). Used for the baseline and for
  "what does the stock route do at 2x" experiments.
- `summ.py SIM GUIDE RATE [--errs]` — per-chapter table from an `rxp7x.py --timeline`
  output: start/end level, turn-ins, decayed turn-ins and lost XP share, ERR count.
- `lvlat.py SIM GUIDE REGEX` — prints the steps matching REGEX with the simulated
  level at that point (used to place the druid stops).

Everything else (the simulator `rxp7x.py`, `qinfo.py`, `skeleton.py`, the Lua 5.1
binary, the loader harness) lives in `tools/7x/`. Two simulator changes were made for
this route: chapter headers such as `#xprate <1.5 << Warlock` now honour their
condition, and a `.turnin`/`.complete` for a quest that the chain already turned in is
reported as INFO instead of ERR (the client auto-completes those).

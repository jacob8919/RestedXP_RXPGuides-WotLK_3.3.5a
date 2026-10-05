# 5x route tooling

- `build5x.py` — generates `Guides/5x/*.lua` from `Guides/7x/*.lua` and the stock
  `Guides/WotLK/Alliance-Leveling.lua`. Renames chapters/group/`#next`, swaps the
  intro wording (`GENERIC` + per-file `EDITS`, each anchor must match exactly once),
  splices the Silithus loop (`SILITHUS`) into Un'Goro and the Zangarmarsh loop
  (`ZANGAR`) into the Hellfire exit, and builds the Grizzly Hills chapter from the
  stock 74-76 block between `GH_START_ANCHOR` and `GH_CUT` plus `GH_TAIL`/`GH_FOOTER`.
  Run from the checkout root: `python3 tools/5x/build5x.py`.
- `check.sh` — full validation: `rxp7x.py` for five classes at 5x and Druid at
  3/4/6/7x, `tools/7x/harness.lua` with `FILES=` (added for this project; the
  harness otherwise parses the 7x list), and `tests/run.lua`.

Shared tooling (`rxp7x.py`, `qinfo.py`, `skeleton.py`, `lua5.1`, data files) lives in
`tools/7x/`, see `tools/7x/README.md`.

Deploy: the Whitemane client reads its own copy of the addon at
`/mnt/c/Whitemane/Games/FrostmourneRebuffed/Interface/AddOns/RXPGuides` (not a
symlink). Copy `Guides/5x/`, `GuideList_335.xml` and anything else changed, then
`diff -rq` the two trees. The Warmane client copy under
`/mnt/c/World of Warcraft 3.3.5a/` is separate.

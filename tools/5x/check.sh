#!/bin/sh
# Validate the generated 5x chain. Run from the checkout root: sh tools/5x/check.sh
F="Guides/5x/Alliance-NightElf-5x.lua Guides/5x/Alliance-Darkshore-5x.lua Guides/5x/Alliance-Ashenvale-5x.lua Guides/5x/Alliance-Dustwallow-5x.lua Guides/5x/Alliance-Tanaris-5x.lua Guides/5x/Alliance-Ungoro-5x.lua Guides/5x/Alliance-Hellfire-5x.lua Guides/5x/Alliance-Borean-5x.lua Guides/5x/Alliance-Dragonblight-5x.lua Guides/5x/Alliance-GrizzlyHills-5x.lua"
for c in Hunter Warrior Rogue Priest Druid; do echo "== $c @5x"; python3 tools/7x/rxp7x.py $F --class $c --rate 5 | grep -v ^INFO; done
for r in 3 4 6 7; do echo "== Druid @${r}x"; python3 tools/7x/rxp7x.py $F --class Druid --rate $r | grep -v ^INFO; done
echo "== real loader parse"
FILES="$F" S=tools/7x tools/7x/lua5.1 tools/7x/harness.lua "$PWD" | grep -v "steps="; FILES="$F" S=tools/7x tools/7x/lua5.1 tools/7x/harness.lua "$PWD" | grep -c "steps="
echo "== repo tests"
tools/7x/lua5.1 tests/run.lua "$PWD" | tail -3

#!/bin/sh
# Validation for the 2x druid route. Run from the checkout root:  sh tools/2x/check.sh
# 1. rebuild from the spec, 2. simulate at 2x / 2.5x / 1.5x and report ERR lines that the stock 1x
#    route does not already have (16 inherited ones are expected, see Guides/2x/README.md),
# 3. grinds at 2x, 4. real-loader parse for DRUID, 5. repo tests.
set -e
SP=${TMPDIR:-/tmp}/rxp2x.$$; mkdir -p "$SP"; trap 'rm -rf "$SP"' EXIT
python3 tools/2x/build2x.py
F="Guides/2x/Alliance-Teldrassil-2x.lua Guides/2x/Alliance-Darkshore-2x.lua Guides/2x/Alliance-EasternKingdoms-2x.lua Guides/2x/Alliance-STV-Dustwallow-2x.lua Guides/2x/Alliance-Tanaris-Ungoro-2x.lua Guides/2x/Alliance-Outland-2x.lua Guides/2x/Alliance-Northrend-2x.lua"
cat $F > "$SP/built.lua"
python3 tools/2x/stockchain.py Druid 1 "$SP/stock1x.lua" >/dev/null
python3 tools/7x/rxp7x.py "$SP/stock1x.lua" --class Druid --rate 1 | grep "^ERR" | sed 's/^ERR *L[0-9]*: //' | sort -u > "$SP/base.txt"
for r in 2 2.5 1.5; do
  python3 tools/7x/rxp7x.py "$SP/built.lua" --class Druid --rate $r --timeline > "$SP/sim$r.txt"
  echo "== rate $r: $(head -1 "$SP/sim$r.txt")"
  grep "^ERR" "$SP/sim$r.txt" | sed 's/^ERR *L[0-9]*: //' | sort -u > "$SP/err.txt"
  echo "   ERR lines total: $(grep -c '^ERR' "$SP/sim$r.txt"), not in the stock 1x route: $(comm -23 "$SP/err.txt" "$SP/base.txt" | wc -l)"
  comm -23 "$SP/err.txt" "$SP/base.txt" | sed 's/^/   NEW: /'
  echo "   grinds: $(grep -c 'GRIND' "$SP/sim$r.txt")"; grep 'GRIND' "$SP/sim$r.txt" | sed 's/^/   /'
done
echo "== per-chapter summary at 2x"
python3 tools/2x/summ.py "$SP/sim2.txt" "$SP/built.lua" 2
echo "== real-loader parse (DRUID)"
for f in $F; do CLASSES=DRUID S=tools/7x tools/7x/lua5.1 tools/7x/harness.lua "$PWD" "$f" | grep -v "^parse errors: 0" | grep -v "^[0-9]" || true; done
echo "== directives without a handler"
grep -ho "^\s*\.[a-zA-Z]\+" $F | tr -d ' \t' | sort -u | sed 's/^\.//' | while read d; do grep -q "^function addon.functions.$d\b\|addon.functions\[\"$d\"\]\|^addon.functions.$d *=" Guide/Directives/*.lua Guide/*.lua Core/*.lua || echo "   MISSING .$d"; done
echo "== repo tests"
tools/7x/lua5.1 tests/run.lua "$PWD" | tail -3

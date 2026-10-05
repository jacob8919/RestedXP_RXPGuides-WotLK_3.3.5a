# 5x experience routes (Whitemane Frostmourne)

Guides in this folder are for realms with 5x kill and quest experience, written
for Whitemane's Frostmourne realm (WotLK 3.3.5a "Frostmourne Rebuffed" client,
5x XP, 2x honour/professions/reputation, launched 2026-09-19). They live in the
normal Alliance speedrun menu under the subgroup **RXP Speedrun Guide 5x**
(group header `RestedXP Alliance 5x`). No `#defaultfor`, pick them by hand.

**Every `.lua` file here is generated.** `tools/5x/build5x.py` derives them from
the hand-written 7x route in `Guides/7x/` plus two stock blocks. Edit the 7x file
or the build script, never these files, then run

    python3 tools/5x/build5x.py && sh tools/5x/check.sh

from the checkout root and copy `Guides/5x/` and `GuideList_335.xml` to the game.

## Why the 7x route works at 5x

The simulator (`tools/7x/rxp7x.py`, no rested XP, objective-count kills) shows
the 7x zone order landing every zone at a sensible level at 5x: a character is
on-level or slightly under rather than over, so nothing decays and the 7x
`.maxlevel` gates simply let more of each zone through. Three things are added:

| Where | What | Why |
|---|---|---|
| End of Un'Goro | Cenarion Hold loop in Silithus (Securing the Supply Lines, Deadly Desert Venom, Stepping Up Security), objectives `.maxlevel 57`, turn-ins `.isQuestComplete` | At 5x the crater alone ends at 56.9 and Outland needs 58. The Hold is one ramp west of Krakle and its mobs line the road in. Exit flies Gadgetzan from the Hold, or hearths if the loop was skipped |
| Hellfire exit | Cenarion Refuge loop in Zangarmarsh (Blessings of the Ancients, The Dying Balance, Disturbance at Umbrafen Lake, As the Crow Flies), objectives `.maxlevel 67` | Hellfire alone ends at 67.8 and Northrend needs 68. The loop sits on the ride to Shattrath |
| After Dragonblight | New chapter `77-80 Grizzly Hills (5x)`: stock "74-76 Northrend" Grizzly Hills steps from the Wintergarde Keep breadcrumb to the Thor Modan chain, then the Vordrassil hand-in | Dragonblight ends at 77.6. Grizzly Hills quests are level 74-75 and pay 100% to 80 |

## Chapters

| Chapter | File | Levels at 5x (sim, Druid) | Source |
|---|---|---|---|
| 1-10 Shadowglen (5x) | Alliance-NightElf-5x.lua | 1 to 10.0 | 7x chapter, text only |
| 10-17 Teldrassil (5x) | Alliance-NightElf-5x.lua | 10.1 to 16.8 | 7x chapter, text only |
| 17-26 Darkshore (5x) | Alliance-Darkshore-5x.lua | 16.9 to 26.5 | 7x chapter, text only |
| 26-36 Ashenvale (5x) | Alliance-Ashenvale-5x.lua | 26.6 to 36.5 | 7x chapter, text only |
| 36-46 Dustwallow (5x) | Alliance-Dustwallow-5x.lua | 36.6 to 45.9 | 7x chapter, text only |
| 46-52 Tanaris (5x) | Alliance-Tanaris-5x.lua | 45.9 to 52.3 | 7x chapter, text only |
| 52-58 Un'Goro (5x) | Alliance-Ungoro-5x.lua | 52.3 to 58.6 | 7x chapter + Silithus loop |
| 58-68 Hellfire (5x) | Alliance-Hellfire-5x.lua | 58.7 to 68.1 | 7x chapter + Zangarmarsh loop |
| 68-75 Borean Tundra (5x) | Alliance-Borean-5x.lua | 68.1 to 75.4 | 7x chapter, text only |
| 75-77 Dragonblight (5x) | Alliance-Dragonblight-5x.lua | 75.4 to 77.6 | 7x chapter + Wintergarde hand-off |
| 77-80 Grizzly Hills (5x) | Alliance-GrizzlyHills-5x.lua | 77.6 to 80 | stock WotLK 74-76 block, cut at Drakil'jin |

Simulated margin: a Druid still reaches 80 at 4.7x; at 4.5x the Un'Goro and
Hellfire safety `.xp` steps become real grinds and the chain ends at 79.9. Rested
XP and incidental kills (not modelled) more than cover that in practice.

Validation: `sh tools/5x/check.sh` runs the simulator for Warrior/Hunter/Rogue/
Priest/Druid at 5x and Druid at 3/4/6/7x, the real-loader parse harness, and the
repo's own tests. Zero `ERR` at 5x and above is the bar; the 3x/4x runs are
expected to show min-level errors (the chain is too short for those rates).

Everything else (guide-language rules, validation tooling, decisions, client
differences found on Warmane) is in `Guides/7x/HANDOFF.md`; the 5x-specific
handoff is `Guides/5x/HANDOFF.md`.

# 7x experience routes (Warmane Icecrown)

Guides in this folder are re-planned for realms with 7x kill and quest
experience. They live in the normal Alliance speedrun menu under the
subgroup **RXP Speedrun Guide 7x** (group header `RestedXP Alliance 7x`).
They do not set `#defaultfor`, so pick them by hand from the guide menu.

## Why a separate route

At 7x the 1x route breaks in three ways:

- Every `.xp` grind and XP breakpoint is wasted time. A 7x character is
  always over-levelled for the next quest.
- Quest XP starts decaying once you are 6 levels above the quest level
  (80%, 60%, 40%, 20%, then 10%), and mobs go grey. A player following the
  1x Night Elf route reaches Darnassus around level 18 and the west half of
  Teldrassil pays 20-60%.
- Deathskips are free below level 10 but give resurrection sickness from
  level 10, which a 7x character reaches in Shadowglen.

So a 7x chapter keeps only the quest clusters that still pay full value at
the level the player actually reaches them, moves to the next zone earlier,
and never waits for a breakpoint.

## Conventions used in these files

- No `#xprate` tags: the addon cannot detect server rates, so the route is
  a separate group instead of a rate branch.
- Optional bundles are guarded with the runtime directives that the
  validated 3.3.5 route already uses: `.maxlevel N` (skip once over-levelled,
  needs "Skip overleveled steps" enabled, which is the default),
  `.isOnQuest id`, `.isQuestTurnedIn id` and `.turnin -id` (skip if the
  quest is not in the log). Every accept whose prerequisite chain includes
  an optional quest is guarded, so a faster or slower character never gets
  stuck.
- Deathskips carry `.maxlevel 9` and `#completewith next` so they only show
  while dying is free.
- Class quests with dynamic level (`QuestLevel -1`: pet taming, Moonglade,
  Elanaria, Destiny Calls) are kept because they scale with the player and
  pay 5-8k XP each at 7x.

## Validating a chapter offline

`tools/7x/rxp7x.py` parses a guide file, simulates accept/complete/turn-in
state for a race/class at a given rate against AzerothCore prerequisite,
race, class, min/max level data, and estimates the level curve:

    python3 tools/7x/rxp7x.py "Guides/7x/Alliance-NightElf-7x.lua" --class Hunter --rate 7 --timeline
    python3 tools/7x/rxp7x.py "Guides/7x/Alliance-NightElf-7x.lua" --class Druid --rate 14

`ERR` lines are prerequisite, race, class or level failures. Run the five
Night Elf classes and a few rates (3, 5, 7, 10, 14) so the `.maxlevel`
gates are exercised both ways. The level estimate ignores rested XP and
incidental kills, so real characters end a little higher.

## Chapters

| Chapter | File | Levels at 7x (sim) | Notes |
|---|---|---|---|
| 1-10 Shadowglen (7x) | Alliance-NightElf-7x.lua | 1 to 11 | Whole starting area, no grinds, deathskips only below 10 |
| 10-17 Teldrassil (7x) | Alliance-NightElf-7x.lua | 11 to 18 | Dolanaar, Lake Al'Ameth, east Gnarlpine, Darnassus, Oracle Glade. Skips the west half (decayed by the time you reach it) |
| 17-24 Darkshore (7x) | Alliance-Darkshore-7x.lua | 18 to 27 | Both stock Darkshore visits merged into four loops from Auberdine. Darnassus mount and training trip at 20 (skips itself if you cannot afford 4.6g, retried at the end). Bloodmyst skipped |
| 25-37 Ashenvale (7x) | Alliance-Ashenvale-7x.lua | 27 to 38 | West half (Maestra's Post, Zoram, Astranaar chains, Feero escort), then the whole east half (Forest Song, Xavian, lumber camp, Felfire Hill, Fallen Sky Lake) and the Raene's Cleansing finale. Optional Darnassus training trip for Hunter/Rogue/Priest. Ends with the boats to Theramore |
| 38-47 Dustwallow (7x) | Alliance-Dustwallow-7x.lua | 38 to 48 | Three loops from Theramore: the island chains (deserters, lighthouse, Nat Pagle, Tethyr), the north sweep (Sentry Point, Witch Hill, Renn McGill), then Tabetha's farm, the zeppelin crash and Mudsprocket (Bloodfen, Den of Flame, Stonemaul Hold, Smolderwing). Shady Rest / Vimes deserter chain, Blackhoof and Stinky skipped (decayed by the time they pay). Druid Dire Bear via Moonglade at the end, optional Darnassus trip for training and Journeyman Riding. Keeps Proof of Treachery for the Jaina teleport at 58 |
| 48-54 Tanaris (7x) | Alliance-Tanaris-7x.lua | 48 to 55 | Gadgetzan hub. Waterspring Field and Lost Rigger Cove pirates first, then Noxious Lair, Dunemaul, Thistleshrub Valley and the Gahz'ridian ruins, then the Gaping Chasm hive. Zul'Farrak, Booty Bay chains, Tooga, Screechers and Darnassus turn-ins skipped. Leaves with Bungle in the Jungle and Super Sticky in the log |
| 55-59 Un'Goro (7x) | Alliance-Ungoro-7x.lua | 55 to 60 | Torwa's Lar'korwi chain at the entrance, the raft, tar pits, Marshal's Refuge, then a west/south loop (pterrordax, Terror Run, Slithering Scar, Ringo's escort). Loop-two objectives carry `.maxlevel 57` so a character that hits 58 skips straight to the Gadgetzan turn-ins. Ends flying to Theramore for the Jaina teleport to Stormwind |
| 58-68 Hellfire (7x) | Alliance-Hellfire-7x.lua | 58 to 69 | Theramore, Jaina's Stormwind teleport, Stormwind trainers, the Blasted Lands portal and the Dark Portal. Then the whole stock Hellfire route minus dungeons and group quests: Honor Hold east (Path of Anguish, Expedition Point, Zeth'Gor), Shatter Point bombing runs, Honor Point, Honor Hold south (mine, zeppelin crash, Expedition Armory, exorcism), Path of Glory, Razelcraz's goblins, Temple of Telhamat, Longbeards, Ruins of Sha'naar, Cenarion Post. Later objectives carry `.maxlevel 67`. Ends riding to Shattrath for the Stormwind portal, training, and the Borean Tundra boat |
| 68-77 Borean Tundra (7x) | Alliance-Borean-7x.lua | 68 to 78 | The stock 3.3.5 `70-72 Northrend` Borean route reused nearly verbatim (Valiance Keep, Farshire, Riplash, D.E.H.T.A., Honored Ancestors, Amber Ledge, Coldarra, Fizzcrank Airstrip, Unu'pe, En'kilah) without the Auction House step and the level-71 wait, cut after the Fizzcrank hand-ins where the sim reaches 77. Winterfin, snobold, Bixie and sinkhole tails skipped. Keeps Travel to Moa'ki Harbor for the hand-off |
| 77-80 Dragonblight (7x) | Alliance-Dragonblight-7x.lua | 77 to 80 | Stock steps for the level 73-75 hubs only: Moa'ki Harbor (Loguhn, crab traps), Wyrmrest Temple (Seeds, Cycle of Life, Mystery of the Infinite), the whole Nozzlerust Post camp, the Obsidian Dragonshrine chain. The sim dings 80 at the end of Nozzlerust, the Obsidian chain is the buffer |

Zone order rationale: Bloodmyst (69k base XP, mostly level 14-19, two boats
away) loses to Ashenvale (95k base XP, level 19-32, reachable by road) for a
character leaving Darkshore in the mid 20s.

Feralas, Felwood, Winterspring and the Plaguelands are skipped: at 7x one
zone covers six to ten levels, so Dustwallow, Tanaris and Un'Goro carry a
character from 38 to 58 on their own, Hellfire Peninsula alone covers 58 to
68 (its level 61-63 quests pay full value until 66-68), and Borean Tundra
plus the level 73-75 half of Dragonblight cover 68 to 80. The rest of Outland
and Northrend is skipped. The chain is complete from 1 to 80; nothing has
been tested in the live client yet.

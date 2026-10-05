# 2x route: Night Elf Druid 1-80 for ChromieCraft

A RestedXP route for one character: a **Night Elf Druid** levelling 1 to 80 on
**ChromieCraft** (AzerothCore-based WotLK 3.3.5a progressive realm, 2x quest and
kill experience, level cap 80). It appears in the Alliance speedrun menu under the
subgroup **RXP Speedrun Guide 2x Druid** (group header `RestedXP Alliance 2x Druid`,
guide condition `<< NightElf Druid`, so other characters do not see it). No
`#defaultfor`: pick the first chapter by hand.

Nothing here has been run in the live client yet; see "What needs an in-game test".

## ChromieCraft facts this route relies on (checked 2026-09-25)

- Experience is **2x up to 80**, quests and kills alike (chromiecraft.com, "Rates &
  Changes"). Players can lower it with the in-game `.weekendxp rate 1` command; the
  route assumes you leave it at 2.
- The realm is at the **level 80 stage** ("about midway through Northrend", Ulduar
  next, no Cataclysm), so the full 1-80 route applies.
- ChromieCraft runs periodic **"Joyous Journeys" +50% XP events** (the last one ran
  until 2026-05-20). During one you are effectively at 3x and will run ahead of the
  chapter names; nothing breaks, the `.maxlevel`/`.isQuestComplete` guards and the
  end-of-chapter cleanups just skip more.
- **Recruit-a-Friend** gives unlimited rested XP for 30 days on new accounts. Rested XP
  is not in the simulation, so expect to be 1-3 levels ahead of the chapter names.
- Gold is blizzlike (no rate change published). The riding steps are therefore
  guarded: Apprentice Riding at 30ish (`.money <5`), Expert Riding at 60
  (`.money <250`), Cold Weather Flying at 77+ (`.money <1000`). They self-skip when
  you cannot afford them and are retried later.
- Talent resets are free on ChromieCraft; dual spec costs 1000g.

## How the route was built

The stock 3.3.5 route already carries a 2x branch (`#xprate` step and chapter tags,
honoured by the addon's "Experience rates" slider, max 2). Simulating that stock chain
at 2x (`tools/2x/stockchain.py Druid 2`) showed it reaches 80 with two and a half
Northrend chapters unused while losing 25-35% of the quest XP to over-level decay in
the 35-65 stretch. So this route is the stock chain with the decayed chapters
removed, every remaining chapter copied mechanically from the stock file, and a short
edit list applied per chapter (`tools/2x/spec2x.py`, generator `tools/2x/build2x.py`).
The `#xprate` step branches are resolved for 2x at build time, so the addon's
"Experience rates" slider does not matter. When a removed step carried a `#label`, the
label moves to the next surviving step so `#completewith`/`#requires` references keep an
anchor.

Druid stops, all at the level the simulation reaches them:

| Level | What | Where in the route |
|---|---|---|
| 10-14 | Moonglade quest chain, Teleport: Moonglade, Bear Form (Lunaclaw) | stock Teldrassil / Darkshore steps |
| 14, 17 | Trainer at Shalannius (Azuremyst) and Moonglade | stock Bloodmyst steps |
| 21.8 | **Cat Form** at Mathrengyl Bearwalker during the Lessons Anew trip | inserted, Bloodmyst chapter |
| 21-27 | **Aquatic Form** chain (A Lesson to Learn, Trial of the Lake, both pendant halves, Trial of the Sea Lion) | stock steps that were TBC-only, enabled; the Westfall half is on the Duskwood route anyway |
| 32.8 | **Travel Form** at Loganaar, then fly Rut'theran for the Darnassus mount (replaces the Stormwind boat trip) | inserted, Duskwood chapter |
| 37, 43.6, 45, 47, 52, 56 | Moonglade trainer hops (**Dire Bear Form** at the 43.6 one) | stock hops plus one inserted in Dustwallow |
| 61 / 62.4 | **Expert Riding** at Hargen Bronzewing, Honor Hold 54.3,62.7 (`.money <250`, retried) | inserted, Hellfire chapter |
| 61.4 / 66 / 71.7 | **Flight Form** at the stock trainer visits (Moonglade or Darnassus, then Sheldras Moontree in Stormwind), guarded by `.skill riding,<225,1` | inserted |
| 71.7 | Expert Riding retry at Maigra Keenfeather, Valiance Keep, then a Moonglade hop for Flight Form | inserted, Borean chapter |
| 79.9 | **Cold Weather Flying** (and Expert Riding retry) at Hira Snowdawn, Dalaran, on the stock Dalaran visit | inserted, Dragonblight/Grizzly chapter |

Swift Flight Form (Artisan Riding, 5000g) is not routed.

## Chapters

Simulated levels are for a Druid at 2x with no rested XP (`tools/7x/rxp7x.py`).

| File | Chapter | Sim levels | Built from (stock) | Edits |
|---|---|---|---|---|
| Alliance-Teldrassil-2x.lua | 1-7 Shadowglen (2x) | 1 to 7.4 | 1-6 Shadowglen | none |
| Alliance-Teldrassil-2x.lua | 7-12 Teldrassil (2x) | 7.4 to 12.7 | 6-11 Teldrassil | Heeding the Call at Kal (from level 10) and its turn-in; The Temple of the Moon breadcrumb from Sister Aquinne before Tears of the Moon |
| Alliance-Darkshore-2x.lua | 12-14 Darkshore (2x) | 12.7 to 14.5 | 11-14 Darkshore | The Fragments Within turn-in made optional (its accept is 1x-only); Lunaclaw and the Body and Heart turn-in moved to the start (Bear Form before the Auberdine loop) |
| Alliance-Darkshore-2x.lua | 14-23 Bloodmyst (2x) | 14.5 to 23.4 | 14-20 Bloodmyst | Aquatic chain enabled, Cat Form trainer stop, Alien Predators dropped (its Azure Watch/Exodar breadcrumbs are off the route) |
| Alliance-Darkshore-2x.lua | 23-23 Darkshore (2x) | 23.4 to 23.7 | 20-21 Darkshore | Darkshore pendant half enabled (mostly transit at 2x); Researching the Corruption dropped (needs a Stormwind breadcrumb) |
| Alliance-Darkshore-2x.lua | 23-25 Ashenvale (2x) | 23.7 to 25.4 | 21-23 Ashenvale | Researching the Corruption objective and turn-in dropped |
| Alliance-EasternKingdoms-2x.lua | 25-29 Redridge/Duskwood (2x) | 25.4 to 29.9 | 24-27 Redridge/Duskwood | Westfall pendant half and Aquatic Form turn-in enabled |
| Alliance-EasternKingdoms-2x.lua | 29-32 Duskwood (2x) | 29.9 to 32.9 | 28-30 Duskwood | duplicate Seeking Wisdom turn-in made optional, Travel Form hop + Darnassus mount trip, Morgan Stern breadcrumb from Angus Stern before the tram (needs level 33, self-skips below) |
| Alliance-EasternKingdoms-2x.lua | 32-35 Hillsbrad (2x) | 32.9 to 35.4 | 30-32 Hillsbrad | none |
| Alliance-STV-Dustwallow-2x.lua | 35-37 Shimmering Flats (2x) | 35.4 to 36.9 | 32-33 Shimmering Flats | Defias in Dustwallow? accept dropped (its prerequisite comes later), fly Theramore at the end (the stock hand-off goes to Hillsbrad) |
| Alliance-STV-Dustwallow-2x.lua | 37-41 STV (2x) | 36.9 to 41.2 | 35-37 STV | Morgan Stern turn-in before Mudrock Soup, Garn Mathers step guarded, Kurzen's Mystery dropped (needs the elite Colonel Kurzen kill), cleanup |
| Alliance-STV-Dustwallow-2x.lua | 41-44 Dustwallow (2x) | 41.2 to 44.5 | 37-39 Dustwallow | Dire Bear hop, A Disturbing Development (Lt. Aden) and Defias in Dustwallow? (Captain Wymor) accepted so the Renn McGill chain works, Corrosion Prevention dropped (its breadcrumb is at Tabetha's farm, visited after the crash), cleanup |
| Alliance-STV-Dustwallow-2x.lua | 44-45 Arathi Highlands (2x) | 44.5 to 45.4 | 39-42 Arathi Highlands | cleanup |
| Alliance-STV-Dustwallow-2x.lua | 45-47 STV part 2 (2x) | 45.4 to 47.4 | 43-46 STV part 2 | The Captain's Chest 8551 (Horde id) replaced by 614 |
| Alliance-Tanaris-Ungoro-2x.lua | 47-53 Tanaris (2x) | 47.4 to 53.5 | 47-49 Tanaris, prefixed with the Gadgetzan/Steamwheedle accepts and Wastewander quests of 45-45 Tanaris | cleanup |
| Alliance-Tanaris-Ungoro-2x.lua | 53-55 Searing Gorge (2x) | 53.5 to 55.3 | 50-51 Searing Gorge | starts with the Menethil flight instead of the Hinterlands one |
| Alliance-Tanaris-Ungoro-2x.lua | 55-57 Burning Steppes (2x) | 55.3 to 56.8 | 51-52 Burning Steppes | A Little Slime dropped, ends with Ironforge → Menethil → Theramore → Gadgetzan transit |
| Alliance-Tanaris-Ungoro-2x.lua | 57-59 Un'Goro Crater (2x) | 56.8 to 59.4 | 53-54 Un'Goro Crater | March of the Silithid turn-in optional, Darnassus tail (Calm Before the Storm, Felbound Ancients, cloth) dropped, ends with Jaina's Stormwind teleport (Proof of Treachery) |
| Alliance-Outland-2x.lua | 59-65 Hellfire Peninsula (2x) | 59.4 to 65 | 59-61 Hellfire Peninsula | `.xp 58` safety step, Expert Riding ×2, Flight Form |
| Alliance-Outland-2x.lua | 65-68 Zangarmarsh (2x) | 65 to 68.1 | 61-63 Zangarmarsh | Flight Form retry, cleanup |
| Alliance-Outland-2x.lua | 68-70 Terokkar Forest (2x) | 68.1 to 70.4 | 63-64 Terokkar Forest | cleanup |
| Alliance-Outland-2x.lua | 70-72 Nagrand (2x) | 70.4 to 71.7 | 64-65 Nagrand | Flight Form retry, the two "hearth to Shattrath" steps dropped (chapter ends in Stormwind, next one takes the boat) |
| Alliance-Northrend-2x.lua | 72-75 Borean Tundra/Howling Fjord (2x) | 71.7 to 75.1 | 70-72 Northrend | Expert Riding retry + Flight Form hop at Valiance Keep |
| Alliance-Northrend-2x.lua | 75-78 Howling Fjord/Dragonblight (2x) | 75.1 to 78.3 | 72-74 Northrend | Valiance Keep → Unu'pe → south coast → Moa'ki Harbor for Your Presence is Required at Stars' Rest, which gates Rifle the Bodies and the whole Stars' Rest hub |
| Alliance-Northrend-2x.lua | 78-80 Dragonblight/Grizzly Hills (2x) | 78.3 to **80** | 74-76 Northrend | Cold Weather Flying + Expert Riding at the Dalaran visit |
| Alliance-Northrend-2x.lua | 80 Zul'Drak/Sholazar (2x) | buffer | 76-78 Northrend | cleanup; only needed if you are behind the simulation |

## What was cut and why

Whole stock chapters left out of the chain (with the level the 2x simulation would
have entered them and the XP they would have lost to decay):

- The 1x-only branch chapters (`#xprate <1.5`): 23-24 Wetlands, 27-30 Wetlands/Hillsbrad,
  30-32 Duskwood/STV, 39-41 Arathi/Alterac, 41-42 Badlands, 42-44 STV, 44-45 Dustwallow
  Marsh, 45-45 Tanaris, 45-46 Badlands/Searing Gorge. The stock 2x branch skips them too;
  the Gadgetzan accepts of 45-45 Tanaris were copied into the Tanaris chapter because the
  47-49 chapter depends on them.
- 33-35 Hillsbrad/Arathi/Alterac: you leave Hillsbrad at 35, its quests are 29-36.
- 46-47 STV/Swamp of Sorrows: at 2x it repeats the Bloodsail chain that STV part 2
  already did, and its Swamp/Blasted Lands part depends on 1x-only chapters (32 errors
  in the stock 2x chain). STV part 2 already ends with the flight to Tanaris.
- 49-50 The Hinterlands (entered at 53, 35% lost), 52-53 Felwood (57, 23%), 54-56
  Felwood/Winterspring (59, 8% but pushes Outland to 61), 56-59 Plaguelands (61, 29%),
  59-60 Silithus (optional). Un'Goro's Darnassus tail belonged to the Felwood flow.
- 65-67 Blade's Edge Mountains and its turn-in chapter (the stock `.maxlevel 67` skips
  the whole chapter at 72), 67-69 Netherstorm, 69-70 Shadowmoon Valley: Nagrand ends at
  71.7, Northrend quests need 68.
- 78-80 Northrend (Storm Peaks/Sholazar): 80 is reached in the Dragonblight/Grizzly
  chapter; Zul'Drak/Sholazar is kept as the buffer.

Chain choice in numbers (Druid, 2x, no rested XP): Outland is entered at 59.4,
Northrend at 71.7, 80 is reached with 141 turn-ins of buffer left. Dustwallow (23%
decayed) and Searing Gorge (20%) are the two remaining weak chapters; both are kept
because their neighbours depend on them (Dustwallow feeds the Kravel/Rumormonger chain
into STV part 2, Searing Gorge is on the way to Burning Steppes).

## Validation

`sh tools/2x/check.sh` from the checkout root rebuilds the files from the spec and runs
the simulator at 2x, 2.5x and 1.5x, the grind check, the real-loader parse for DRUID, a
directive-handler check and the repo tests. Current state:

- 2x and 2.5x: no ERR line that the stock 1x route does not also have, no grinds, every
  quest turned in or abandoned by the end (`still on []`).
- 9 ERR lines are inherited from the stock route (present in the stock 1x chain at
  1x too) and are expected: 10553/10554 (the Aldor/Scryer allegiance is a manual choice
  step), 9738 Lost in Action (a dungeon-only quest), 1204 Mudrock Soup (its Morgan
  Stern breadcrumb carries an `.xp <33,1` guard the simulator does not model), the
  repeatable More Irradiated Crystal Shards (9642) turn-ins and the item-started Fei
  Fei's Treat (10919). The other seven stock prerequisite bugs were real on ChromieCraft
  (Tears of the Moon was the first one hit in the client) and are fixed or cut as noted
  in the chapter table.
- 1.5x: only "min level" errors and three stock safety grinds (to 10, 25, 48), because
  a 1.5x character is 1-2 levels behind the route. The route is for 2x.

## What needs an in-game test on ChromieCraft

- Guide picker: the subgroup "RXP Speedrun Guide 2x Druid" shows up for a Night Elf
  Druid only, and `#next` walks all 26 chapters (names such as "1-7 Shadowglen (2x)"
  are normalised the same way as the stock ones).
- The enabled Aquatic Form chain: A Lesson to Learn (26), Trial of the Lake (29) and
  Trial of the Sea Lion (272) must exist on ChromieCraft (they were removed in 4.0 on
  retail; AzerothCore has them).
- The Alliance Captain's Chest id 614 (the stock guide used 8551, which AzerothCore
  marks Horde-only).
- Jaina's teleport at the end of Un'Goro: Proof of Treachery (11222) needs Survey
  Alcaz Island (11142) turned in, which the Dustwallow chapter does. The fallback step
  (boat to Menethil, fly Stormwind) covers a missing prerequisite.
- Riding trainers: Hargen Bronzewing (Honor Hold 54.3,62.7) and Maigra Keenfeather
  (Valiance Keep 58.9,68.2) teach Expert Riding on ChromieCraft; Hira Snowdawn
  (Dalaran 69.8,45.4) teaches Cold Weather Flying. Flight Form (33943) must be
  trainer-taught at 60 (it is in 3.3.5).
- `.skill riding,<225,1` as the "skip unless Expert Riding" guard, `.money <250`
  and `.istrained 34090/33943/54197` as skip conditions.
- The transit steps written for this route: Menethil boat to Theramore (Wetlands
  5.1,63.4), Gadgetzan flight from Theramore, Menethil gryphon to Ironforge at the
  start of Searing Gorge, Rut'theran flight from Moonglade for the level-30 mount, the
  south-coast ride from Unu'pe into Dragonblight to Moa'ki Harbor before Stars' Rest.
- The breadcrumbs added for stock prerequisite bugs: Sister Aquinne (Darnassus
  28.9,45.8), Angus Stern (Stormwind 51.8,93.6, level 33), Lieutenant Aden and Captain
  Wymor in Dustwallow, Emissary Skyhaven at Moa'ki.
- Everything the 7x notes list as untested for the stock-copied blocks (`Guides/7x/HANDOFF.md`
  section 5) applies here too.

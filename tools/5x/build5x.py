#!/usr/bin/env python3
"""Build the "RestedXP Alliance 5x" chapters (Guides/5x/*.lua) for Whitemane Frostmourne (5x XP).

The 5x route is derived from the hand-written 7x route (Guides/7x/) because the simulator shows
the 7x zone order lands every zone at a sensible level at 5x too (Shadowglen 1-10, Teldrassil
10-17, Darkshore 17-26, Ashenvale 26-36, Dustwallow 36-46, Tanaris 46-52, Un'Goro 52-58,
Hellfire 58-68, Borean 68-75, Dragonblight 75-77). What 5x needs on top of 7x:

  * a level-gated Cenarion Refuge loop in Zangarmarsh on the Hellfire exit, because Hellfire
    alone ends a quarter level short of 68 at 5x (`.maxlevel 67` objectives, guarded turn-ins);
  * a Grizzly Hills chapter (stock "74-76 Northrend" Grizzly Hills blocks, reached by road from
    Wyrmrest Temple through Wintergarde Keep) because Dragonblight ends around 77-78 at 5x;
  * renamed chapters/group/next links and 5x wording in the intro steps.

Every 5x file is GENERATED: fix the 7x file (or this script) and re-run
    python3 tools/5x/build5x.py
from the checkout root. Each edit below must match exactly once or the build fails, so a 7x
change that invalidates an anchor is caught instead of silently dropped.
"""
import os, re, sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
SRC = ROOT + '/Guides/7x/'
DST = ROOT + '/Guides/5x/'
STOCK_WOTLK = ROOT + '/Guides/WotLK/Alliance-Leveling.lua'

GROUP_OLD = '#group RestedXP Alliance 7x'
GROUP_NEW = '#group RestedXP Alliance 5x'

# 7x chapter name -> 5x chapter name (ranges follow the 5x Druid simulation)
NAMES = {
    '1-10 Shadowglen (7x)':        '1-10 Shadowglen (5x)',
    '10-17 Teldrassil (7x)':       '10-17 Teldrassil (5x)',
    '17-24 Darkshore (7x)':        '17-26 Darkshore (5x)',
    '25-37 Ashenvale (7x)':        '26-36 Ashenvale (5x)',
    '38-47 Dustwallow (7x)':       '36-46 Dustwallow (5x)',
    '48-54 Tanaris (7x)':          '46-52 Tanaris (5x)',
    '55-59 Un\'Goro (7x)':         '52-58 Un\'Goro (5x)',
    '58-68 Hellfire (7x)':         '58-68 Hellfire (5x)',
    '68-77 Borean Tundra (7x)':    '68-75 Borean Tundra (5x)',
    '77-80 Dragonblight (7x)':     '75-77 Dragonblight (5x)',
}
GRIZZLY = '77-80 Grizzly Hills (5x)'

FILES = [
    ('Alliance-NightElf-7x.lua',     'Alliance-NightElf-5x.lua'),
    ('Alliance-Darkshore-7x.lua',    'Alliance-Darkshore-5x.lua'),
    ('Alliance-Ashenvale-7x.lua',    'Alliance-Ashenvale-5x.lua'),
    ('Alliance-Dustwallow-7x.lua',   'Alliance-Dustwallow-5x.lua'),
    ('Alliance-Tanaris-7x.lua',      'Alliance-Tanaris-5x.lua'),
    ('Alliance-Ungoro-7x.lua',       'Alliance-Ungoro-5x.lua'),
    ('Alliance-Hellfire-7x.lua',     'Alliance-Hellfire-5x.lua'),
    ('Alliance-Borean-7x.lua',       'Alliance-Borean-5x.lua'),
    ('Alliance-Dragonblight-7x.lua', 'Alliance-Dragonblight-5x.lua'),
]

# ---------------------------------------------------------------------------------------------
# Exact-match edits per 7x file: (old, new). Applied after the generic renames below.
# ---------------------------------------------------------------------------------------------
EDITS = {
 'Alliance-NightElf-7x.lua': [
  ("+You have selected the 5x Night Elf guide. It starts in Shadowglen, pick the 5x guide for your own starting zone instead",
   "+You have selected the 5x Night Elf guide. It starts in Shadowglen; there is no 5x guide for the other starting zones yet, follow the stock Alliance guide to Darkshore and pick up 17-26 Darkshore (5x) there"),
  ("+5x route (Whitemane Frostmourne). Never grind and never wait for an XP breakpoint. Quests keep full XP until you are 5 levels above them, so keep moving and turn in as soon as you can. Check that your XP rate is 5x (right click your XP bar on Whitemane)",
   "+5x route (Whitemane Frostmourne, 5x kill and quest XP). Never grind and never wait for an XP breakpoint. Quests keep full XP until you are 5 levels above them, so keep moving and turn in as soon as you can"),
  ("+You should reach Dolanaar around level 10-11 and leave Teldrassil around 17.",
   "+You should reach Dolanaar at level 10 and leave Teldrassil around 17."),
 ],
 'Alliance-Darkshore-7x.lua': [
  ("+Darkshore at 5x: you arrive around 17-18 and leave around 24, and every quest here still pays full XP in that range.",
   "+Darkshore at 5x: you arrive around 17 and leave around 26, and every quest here still pays full XP in that range."),
 ],
 'Alliance-Ashenvale-7x.lua': [
  ("+Ashenvale at 5x: you arrive around 25-27 and leave around 37.",
   "+Ashenvale at 5x: you arrive around 26-27 and leave around 36-37."),
 ],
 'Alliance-Dustwallow-7x.lua': [
  ("+Dustwallow at 5x: you arrive around 38 and leave around 47.",
   "+Dustwallow at 5x: you arrive around 36-37 and leave around 46."),
  ("three breadcrumbs to the same goblin and Whitemane only lets you hold one, so the route takes only this one.",
   "three breadcrumbs to the same goblin and Warmane only lets you hold one (Whitemane most likely does the same), so the route takes only this one."),
 ],
 'Alliance-Tanaris-7x.lua': [
  ("+Tanaris at 5x: you arrive around 48 and leave around 54.",
   "+Tanaris at 5x: you arrive around 46 and leave around 52."),
 ],
 'Alliance-Ungoro-7x.lua': [
  ("+Un'Goro at 5x: you arrive around 55 and leave for Outland the moment you are 58.",
   "+Un'Goro at 5x: you arrive around 52-53 and leave for Outland the moment you are 58. At 5x the crater alone ends around 57, so a short Cenarion Hold loop in Silithus (west ramp, past Krakle) closes the gap; it skips itself if you are already 58."),
  # Replace the Slithering Scar safety grind and the hearth with the Silithus loop (SILITHUS below).
  ("""step
    .goto Un'Goro Crater,49.93,81.70,60,0
    .goto Un'Goro Crater,45.0,83.6
    .xp 58 >> Outland needs level 58. If you are still short, kill Gorishi around the Slithering Scar until you ding. Skips itself once you are 58
step
    #completewith next
    .hs >> Hearth to Gadgetzan
""", "__SILITHUS__\n"),
 ],
 'Alliance-Hellfire-7x.lua': [
  ("-- the Dark Portal. At 5x Hellfire alone covers 58 to 68: its level 58-63 quests stay at full",
   "-- the Dark Portal. At 5x Hellfire covers 58 to about 68: its level 58-63 quests stay at full"),
  ("+Outland at 5x: Hellfire Peninsula alone carries you from 58 to 68, so Zangarmarsh, Terokkar, Nagrand and the rest are skipped.",
   "+Outland at 5x: Hellfire Peninsula carries you from 58 to about 68, then a short Cenarion Refuge loop in Zangarmarsh on the way out covers any shortfall. Terokkar, Nagrand and the rest of Outland are skipped."),
  # Move the level-68 safety grind from the Cenarion Post to the Cenarion Refuge, after the new
  # Zangarmarsh loop (see ZANGAR below). The .turnin -9912 step and its abandon stay where they are.
  ("""step
    .goto Hellfire Peninsula,12.15,46.50,50,0
    .goto Hellfire Peninsula,9.13,49.47
    .xp 68 >> Northrend needs level 68. If you are still short, kill Thornfang mobs west of the Cenarion Post until you ding. Skips itself once you are 68
step
    #sticky
    #completewith next
    +Hellfire is done around 68 and Northrend needs 68. Ride west out of the Cenarion Post into Zangarmarsh,""",
   """step
    #sticky
    #completewith next
    +Hellfire is done around 67-68 and Northrend needs 68. Ride west out of the Cenarion Post into Zangarmarsh,"""),
  ("""step
    .abandon 9912 >> Abandon The Cenarion Expedition
step
    .goto Zangarmarsh,80.0,63.0,80,0
    .goto Terokkar Forest,49.0,20.0,80,0""",
   """step
    .abandon 9912 >> Abandon The Cenarion Expedition
__ZANGAR__
step
    .goto Zangarmarsh,80.0,63.0,80,0
    .goto Terokkar Forest,49.0,20.0,80,0"""),
 ],
 'Alliance-Borean-7x.lua': [
  ("+Borean Tundra at 5x: you arrive at 68 and leave for Dragonblight around 77.",
   "+Borean Tundra at 5x: you arrive at 68 and leave for Dragonblight around 75."),
  ("-- because every quest here is level 71-72 and pays full value until 76-77. Cut after the",
   "-- because every quest here is level 71-72 and pays full value until 76-77. At 5x the chapter\n-- ends around 75, before anything decays. Cut after the"),
 ],
 'Alliance-Dragonblight-7x.lua': [
  ("#group RestedXP Alliance 5x\nstep",
   "#group RestedXP Alliance 5x\n#next " + GRIZZLY + "\nstep"),
  ("+Dragonblight at 5x: you arrive around 77 and hit 80 here. Only the level 73-75 hubs are routed (Moa'ki Harbor, Wyrmrest Temple, Nozzlerust Post, the Obsidian Dragonshrine), everything else in the zone would pay 60-80% by now.",
   "+Dragonblight at 5x: you arrive around 75 and leave for Grizzly Hills around 77-78. Only the level 73-75 hubs are routed (Moa'ki Harbor, Wyrmrest Temple, Nozzlerust Post, the Obsidian Dragonshrine); the level 71-72 hubs (Stars' Rest, Wintergarde) would pay less than Grizzly Hills by the time you reach them."),
  ("-- Dragonshrine chain. The Stars' Rest, Indu'le, Ruby Dragonshrine, Wintergarde, Fordragon\n-- and Wrathgate chains are skipped: 80 arrives long before they would be needed.",
   "-- Dragonshrine chain. The Stars' Rest, Indu'le, Ruby Dragonshrine, Wintergarde, Fordragon\n-- and Wrathgate chains are skipped: at 5x the chapter ends around 77-78 and the Grizzly\n-- Hills chapter (level 74-75 quests, full value to 80) takes over."),
  ("""step
    #sticky
    +Level 80. That is the end of the 5x route. Dalaran (the Wyrmrest Temple flight master connects to it) has every class trainer and the Kirin Tor portals home
]])""",
   """step
    #sticky
    #completewith next
    +Dragonblight is done around 77-78. Next: Grizzly Hills. Ride east from Wyrmrest Temple along the road past the Wrathgate turn-off to Wintergarde Keep (about five minutes); the Grizzly Hills chapter starts there
step
    .goto Dragonblight,70.0,50.0,80,0
    .goto Dragonblight,77,49.8
.target Gryphon Commander Urik
    .fp Wintergarde Keep, Dragonblight >> Ride east along the road to Wintergarde Keep and get its flight path
]])"""),
 ],
}

# Generic intro-text swaps applied to every file before EDITS (comments and step text).
GENERIC = [
    ('Warmane Icecrown', 'Whitemane Frostmourne'),
    ('Warmane 7x', 'Whitemane 5x'),
    ('RestedXP 7x route', 'RestedXP 5x route'),
    ('7x', '5x'),
    ('Warmane', 'Whitemane'),
]

# ---------------------------------------------------------------------------------------------
# Zangarmarsh filler on the Hellfire exit. Objective steps are `.maxlevel 67` so a character that
# is already 68 skips them; turn-ins are guarded by `.isQuestComplete` so anything finished is
# still handed in. Coordinates from the stock TBC "61-63 Zangarmarsh" chapter and Questie.
# ---------------------------------------------------------------------------------------------
ZANGAR = """step
    #sticky
    #completewith zangarDone
    +Cenarion Refuge loop (only if you are not 68 yet): Blessings of the Ancients at the Refuge, the Umbrafen Lake steam pump, Boglash south-east of the Refuge, then the Stormcrow flight. About fifteen minutes, all within sight of the Refuge. Every step here skips itself once you are 68
step
    .maxlevel 67
    .goto Zangarmarsh,78.398,62.016
.target Ysiel Windsinger
>>Talk to |cRXP_FRIENDLY_Ysiel Windsinger|r
    .accept 9716 >> Accept Disturbance at Umbrafen Lake
step
    .maxlevel 67
    .goto Zangarmarsh,78.533,63.147
.target Lethyn Moonfire
>>Talk to |cRXP_FRIENDLY_Lethyn Moonfire|r
    .accept 9895 >> Accept The Dying Balance
step
    .maxlevel 67
    .goto Zangarmarsh,80.383,64.718
.target Windcaller Blackhoof
>>Talk to |cRXP_FRIENDLY_Windcaller Blackhoof|r
    .accept 9785 >> Accept Blessings of the Ancients
step
    .maxlevel 67
    .goto Zangarmarsh,81.11,63.87
.target Ashyen
    >>Talk to Ashyen, the ancient standing just east of the Refuge
    .complete 9785,1 --Ashyen's Blessing
step
    .maxlevel 67
    .goto Zangarmarsh,78.97,67.44
.target Keleth
    .unitscan Keleth
    >>Talk to Keleth, the ancient south of the Refuge (he wanders a little)
    .complete 9785,2 --Keleth's Blessing
step
    .isQuestComplete 9785
    .goto Zangarmarsh,80.37,64.73
.target Windcaller Blackhoof
>>Talk to |cRXP_FRIENDLY_Windcaller Blackhoof|r
    .turnin 9785 >> Turn in Blessings of the Ancients
step
    .maxlevel 67
    .goto Zangarmarsh,76.0,72.0,60,0
    .goto Zangarmarsh,70.57,80.28
    >>Ride south-west along the lake shore to the Umbrafen Lake steam pump
    .complete 9716,1 --Investigate the pump
step
    .maxlevel 67
    .goto Zangarmarsh,83.89,78.58
    .unitscan Boglash
    >>Boglash is a level 61 elite bog lord wandering the marsh south-east of the Refuge, east of the Umbrafen village. Easy solo at 67
    .complete 9895,1 --Kill Boglash
step
    .isQuestComplete 9895
    .goto Zangarmarsh,78.533,63.147
.target Lethyn Moonfire
>>Talk to |cRXP_FRIENDLY_Lethyn Moonfire|r
    .turnin 9895 >> Turn in The Dying Balance
step
    .isQuestComplete 9716
    .goto Zangarmarsh,78.398,62.016
.target Ysiel Windsinger
>>Talk to |cRXP_FRIENDLY_Ysiel Windsinger|r
    .turnin 9716 >> Turn in Disturbance at Umbrafen Lake
    .accept 9718 >> Accept As the Crow Flies
step
    .isOnQuest 9718
    .goto Zangarmarsh,78.398,62.016
    .use 25465 >> Use the Stormcrow Amulet next to Ysiel and wait out the flight over the marsh
    .complete 9718,1 --Stormcrow flight
step
    .isQuestComplete 9718
    .goto Zangarmarsh,78.398,62.016
.target Ysiel Windsinger
>>Talk to |cRXP_FRIENDLY_Ysiel Windsinger|r
    .turnin 9718 >> Turn in As the Crow Flies
step
    #label zangarDone
    >>Clean up. These only show if the quest is still in your log
    .abandon 9716 >> Abandon Disturbance at Umbrafen Lake
    .abandon 9718 >> Abandon As the Crow Flies
    .abandon 9895 >> Abandon The Dying Balance
    .abandon 9785 >> Abandon Blessings of the Ancients
step
    .goto Zangarmarsh,82.5,45.5,60,0
    .goto Zangarmarsh,83.5,44.5
    .xp 68 >> Northrend needs level 68. If you are still short, kill the Withered Giants and Withered Bog Lords in the Dead Mire north-east of the Refuge until you ding. Skips itself once you are 68"""

# ---------------------------------------------------------------------------------------------
# Silithus filler at the end of Un'Goro. At 5x the crater ends around 56.9 and Outland needs 58.
# Cenarion Hold's level 55-57 quests sit on the road in from the Un'Goro ramp. Objective and
# accept steps are `.maxlevel 57`, turn-ins are guarded by `.isQuestComplete`, and the exit
# forks on zone: fly Gadgetzan from Cenarion Hold, or hearth if Silithus was skipped.
# Coordinates: stock TBC "59-60 Silithus (Optional)" chapter and Questie (Cloud Skydancer).
# ---------------------------------------------------------------------------------------------
SILITHUS = """step
    #sticky
    #completewith silithusDone
    +Silithus loop (only if you are not 58 yet): ride west past Krakle up the ramp into Silithus, follow the road to Cenarion Hold, kill the silithids and scorpids along that road, then the Dredge Crushers south-west of the Hold. About twenty minutes. Every step here skips itself once you are 58
step
    .maxlevel 57
    .goto Un'Goro Crater,30.93,50.44,60,0
    .goto Silithus,88.4,23.8,60,0
    .goto Silithus,81.9,19.0
    .zone Silithus >> Ride west past Krakle and up the ramp into Silithus. Valor's Rest is at the top, follow the road west from there
step
    .maxlevel 57
    .goto Silithus,51.61,38.63
.target Beetix Ficklespragg
>>Talk to |cRXP_FRIENDLY_Beetix Ficklespragg|r
    .accept 8277 >> Accept Deadly Desert Venom
step
    .maxlevel 57
    .goto Silithus,51.15,38.29
.target Windcaller Proudhorn
>>Talk to |cRXP_FRIENDLY_Windcaller Proudhorn|r
    .accept 8280 >> Accept Securing the Supply Lines
step
    .maxlevel 57
    .goto Silithus,50.58,34.45
.target Cloud Skydancer
    .fp Cenarion Hold >> Get the Cenarion Hold flight path
step
    .maxlevel 57
    .goto Silithus,54.6,33.6,60,0
    .goto Silithus,65.5,29.5,60,0
    .goto Silithus,72.5,37.0,60,0
    .goto Silithus,61.5,40.0
    >>Work the sand east and north-east of Cenarion Hold along the road you came in on
    .complete 8280,1 --Kill Dredge Strikers (x15)
    .complete 8277,1 --Stonelash Scorpid Stingers (x8)
    .complete 8277,2 --Sand Skitterer Fangs (x8)
step
    .isQuestComplete 8280
    .goto Silithus,51.15,38.29
.target Windcaller Proudhorn
>>Talk to |cRXP_FRIENDLY_Windcaller Proudhorn|r
    .turnin 8280 >> Turn in Securing the Supply Lines
step
    .maxlevel 57
    .isQuestTurnedIn 8280
    .goto Silithus,51.15,38.29
.target Windcaller Proudhorn
    .accept 8281 >> Accept Stepping Up Security
step
    .isQuestComplete 8277
    .goto Silithus,51.61,38.63
.target Beetix Ficklespragg
>>Talk to |cRXP_FRIENDLY_Beetix Ficklespragg|r
    .turnin 8277 >> Turn in Deadly Desert Venom
step
    .maxlevel 57
    .goto Silithus,39.3,53.3,60,0
    .goto Silithus,36.4,60.4
    >>The Dredge Crushers are the big sandworms in the open desert south-west of the Hold
    .complete 8281,1 --Kill Dredge Crushers (x20)
step
    .isQuestComplete 8281
    .goto Silithus,51.15,38.29
.target Windcaller Proudhorn
>>Talk to |cRXP_FRIENDLY_Windcaller Proudhorn|r
    .turnin 8281 >> Turn in Stepping Up Security
step
    #label silithusDone
    >>Clean up. These only show if the quest is still in your log
    .abandon 8277 >> Abandon Deadly Desert Venom
    .abandon 8280 >> Abandon Securing the Supply Lines
    .abandon 8281 >> Abandon Stepping Up Security
step
    .goto Silithus,39.3,53.3,60,0
    .goto Silithus,36.4,60.4
    .xp 58 >> Outland needs level 58. If you are still short, kill Dredge Crushers and scorpids around Cenarion Hold until you ding. Skips itself once you are 58
step
    .zoneskip Silithus,1
    .goto Silithus,50.58,34.45
    .fly Gadgetzan >> Fly to Gadgetzan
step
    .zoneskip Silithus
    .zoneskip Tanaris
    #completewith next
    .hs >> Hearth to Gadgetzan"""

# ---------------------------------------------------------------------------------------------
# Grizzly Hills chapter: stock "74-76 Northrend" from the Wintergarde Keep breadcrumb to the
# Vordrassil turn-ins at Amberpine (the step before "Fly to Westfall Brigade Encampment").
# ---------------------------------------------------------------------------------------------
GH_START_ANCHOR = 'step\n.goto Dragonblight,77.1,50.1\n.target Gryphon Commander Urik\n.accept 12511 >> Accept The Hills Have Us\n'
GH_END_ANCHOR = 'step\n.fly Westfall Brigade, Grizzly Hills >> Fly to Westfall Brigade Encampment\n>>Fly to Westfall Brigade Encampment\nstep\n.zone Zul\'Drak\n'
# chapter boundary inside the copied range
GH_BOUNDARY = re.compile(r'step\n\.xp 76\n\]\]\);\nRXPGuides\.RegisterGuide\(\[\[\n(?:#.*\n|<<.*\n)*?#next 78-80 Northrend\n')

# Optional cut: everything from this anchor on is dropped (set to None to keep the whole block).
# Chosen from the 5x Druid simulation (no rested XP): 80 arrives in the Silverbrook/Ruuna loop,
# about half way through the stock block. The chapter keeps the Blue Sky Logging Grounds and the
# Thor Modan iron-dwarf chain as margin and stops before Drakil'jin Ruins and Dun Argol.
GH_CUT = "step\n.goto Grizzly Hills,73.8,34\n.target Harkor\n.turnin 12190 >> Turn in Say Hello to My Little Friend\n"
# The stock route hands in Vordrassil's Sapling/Seeds at Amberpine at the very end of the zone;
# with the cut that ending is appended here (same steps as stock lines 6172-6183).
GH_TAIL = """step
.goto Grizzly Hills,59.5,26.3,0.5
.hs >> Hearth to Westfall Brigade Encampment
>>Hearth to Westfall Brigade Encampment
step
.fly Amberpine Lodge, Grizzly Hills >> Fly to Amberpine Lodge
>>Fly to Amberpine Lodge
step
.goto Grizzly Hills,31.2,59.5
.target Hierophant Thayreen
.turnin 12248 >> Turn in Vordrassil's Sapling
.turnin 12250 >> Turn in Vordrassil's Seeds
"""

GH_HEADER = """-- RestedXP 5x route: Grizzly Hills (WotLK 3.3.5a, Whitemane Frostmourne 5x). Arrive from
-- Dragonblight around 77-78 by road from Wyrmrest Temple through Wintergarde Keep. Stock 3.3.5
-- "74-76 Northrend" Grizzly Hills steps reused nearly verbatim (Amberpine Lodge, Zeb'Halak/Drakuru,
-- Silverbrook, Vordrassil, Westfall Brigade, Drakil'jin, Dun Argol): every quest here is level
-- 74-75 and pays full value to 80. The stock `.xp 76` wait and the Dalaran detour are dropped.
-- GENERATED by tools/5x/build5x.py, edit the script instead.
local faction = UnitFactionGroup("player")
if faction == "Horde" then return end

RXPGuides.RegisterGuide([[
#wotlk
<< Alliance
#name """ + GRIZZLY + """
#version 1
#group RestedXP Alliance 5x
step
    #sticky
    #completewith next
    +Grizzly Hills at 5x: you arrive at Wintergarde Keep around 77-78 and hit 80 in Grizzly Hills. The route is the stock one: Amberpine Lodge, the Drakuru troll chain in the north-west, Silverbrook, Vordrassil, then the Westfall Brigade camp and the Thor Modan iron dwarves in the east. No class trainers in the zone. Dalaran has them all plus Cold Weather Flying (77, 1000g): from Wyrmrest Temple ride north into Crystalsong Forest to the Violet Stand (15.7,42.5) and take the teleport crystal up, then fly back once you have the Dalaran flight path
"""

GH_FOOTER = """step
    >>Clean up. These only show if the quest is still in your log
    .abandon 12511 >> Abandon The Hills Have Us
    .abandon 12292 >> Abandon Local Support
    .abandon 12210 >> Abandon Troll Season!
    .abandon 12190 >> Abandon Say Hello to My Little Friend
    .abandon 12109 >> Abandon Report to Gryan Stoutmantle
    .abandon 12161 >> Abandon Ruuna the Blind
    .abandon 12414 >> Abandon Mounting Up
    .abandon 12279 >> Abandon A Bear of an Appetite
    .abandon 12128 >> Abandon Check Up on Raegar
    .abandon 12068 >> Abandon Voices From the Dust
    .abandon 12081 >> Abandon Gavrock
    .abandon 12248 >> Abandon Vordrassil's Sapling
    .abandon 12250 >> Abandon Vordrassil's Seeds
step
    #sticky
    +Level 80. That is the end of the 5x route. Dalaran has every class trainer, Cold Weather Flying and the Kirin Tor portals home: fly to Wyrmrest Temple, ride north into Crystalsong Forest and take the Violet Stand teleport crystal (15.7,42.5) up
]])
"""


def apply_edits(text, edits, fname):
    for old, new in edits:
        n = text.count(old)
        if n != 1:
            sys.exit(f"{fname}: edit anchor matched {n} times, expected 1:\n{old[:120]!r}")
        text = text.replace(old, new)
    return text


def build_from_7x(src_name, dst_name):
    text = open(SRC + src_name, encoding='utf-8').read()
    for old, new in NAMES.items():
        text = text.replace('#name ' + old, '#name ' + new)
        text = text.replace('#next ' + old, '#next ' + new)
    if '(7x)' in text:
        sys.exit(f"{src_name}: unmapped chapter name: " + repr(re.findall(r'^#(?:name|next) .*$', text, re.M)))
    text = text.replace(GROUP_OLD, GROUP_NEW)
    for old, new in GENERIC:
        text = text.replace(old, new)
    text = apply_edits(text, EDITS.get(src_name, []), src_name)
    text = text.replace('__ZANGAR__', ZANGAR)
    text = text.replace('__SILITHUS__', SILITHUS)
    assert '__' not in text.replace('__pycache__', ''), src_name
    text = ("-- GENERATED by tools/5x/build5x.py from Guides/7x/%s; edit the 7x file or the script.\n" % src_name) + text
    open(DST + dst_name, 'w', encoding='utf-8').write(text)
    return text


def build_grizzly():
    stock = open(STOCK_WOTLK, encoding='utf-8').read()
    a = stock.find(GH_START_ANCHOR)
    b = stock.find(GH_END_ANCHOR)
    if a < 0 or b < 0 or b < a:
        sys.exit('Grizzly Hills anchors not found in the stock WotLK file')
    block = stock[a:b]
    block, n = GH_BOUNDARY.subn('', block)
    if n != 1:
        sys.exit('Grizzly Hills: chapter boundary (.xp 76) not found exactly once (%d)' % n)
    if GH_CUT:
        c = block.find(GH_CUT)
        if c < 0:
            sys.exit('Grizzly Hills: GH_CUT anchor not found')
        block = block[:c]
    text = GH_HEADER + block + (GH_TAIL if GH_CUT else '') + GH_FOOTER
    open(DST + 'Alliance-GrizzlyHills-5x.lua', 'w', encoding='utf-8').write(text)
    return text


def main():
    os.makedirs(DST, exist_ok=True)
    for s, d in FILES:
        build_from_7x(s, d)
    build_grizzly()
    print('built', len(FILES) + 1, 'files in Guides/5x/')


if __name__ == '__main__':
    main()

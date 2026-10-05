-- RestedXP 7x route: Un'Goro Crater (WotLK 3.3.5a, Warmane 7x). Arrive from Tanaris around
-- 55 with Bungle in the Jungle and Super Sticky in the log and the hearthstone on Gadgetzan.
-- Torwa's Lar'korwi chain at the south-east entrance, the raft, then north along the east
-- side through the tar pits to Marshal's Refuge, then a west and south loop (pterrordax,
-- Terror Run, the Slithering Scar hive, Fire Plume Ridge, Ringo's escort) back to the
-- Refuge. Objective steps in the second loop carry .maxlevel 57: once you are 58 they skip
-- and the chapter heads to Gadgetzan and on to Outland. Apes, A-Me 01, the pylons, Krakle
-- and every chain that ends in Winterspring, Feralas or Darnassus are skipped.
local faction = UnitFactionGroup("player")
if faction == "Horde" then return end

RXPGuides.RegisterGuide([[
#wotlk
<< Alliance
#name 55-59 Un'Goro (7x)
#version 1
#group RestedXP Alliance 7x
#next 58-68 Hellfire (7x)
step
    #sticky
    #completewith next
    +Un'Goro at 7x: you arrive around 55 and leave for Outland the moment you are 58. No class trainers here (Druids train in Moonglade, everyone trains in Stormwind on the way to the Dark Portal). Keep the hearthstone on Gadgetzan
step
    #sticky
    #completewith ungoroDone
    >>Loot Un'Goro Dirt Piles for five Un'Goro Soil as you go, there is one right at the entrance
    .collect 11018,5,4496,1 --Un'Goro Soil (5)
step
    #sticky
    #completewith ungoroDone
    >>Loot the glowing Power Crystals on the ground whenever you pass one. Seven of each colour is a quest at Marshal's Refuge, it only pays if you happen to finish it
    .collect 11186,7,4284,1 --Red Power Crystal (7)
    .collect 11188,7,4284,1 --Yellow Power Crystal (7)
    .collect 11185,7,4284,1 --Green Power Crystal (7)
    .collect 11184,7,4284,1 --Blue Power Crystal (7)
step
    .goto Un'Goro Crater,71.639,75.960
.target Torwa Pathfinder
>>Talk to |cRXP_FRIENDLY_Torwa Pathfinder|r at the bottom of the ramp
    .accept 4290 >> Accept The Fare of Lar'korwi
step
    .goto Un'Goro Crater,68.73,56.70
    >>Ride north along the east shore of the lake and loot a piece of the Fresh Threshadon Carcass
    .complete 4290,1 --Collect Piece of Threshadon Carcass (x1)
step
    .goto Un'Goro Crater,71.639,75.960
.target Torwa Pathfinder
>>Talk to |cRXP_FRIENDLY_Torwa Pathfinder|r
    .turnin 4290 >> Turn in The Fare of Lar'korwi
    .accept 4291 >> Accept The Scent of Lar'korwi
step
    .goto Un'Goro Crater,63.02,68.60
    >>Click the Wrecked Raft on the lake shore north-west of Torwa
    .accept 3844 >> Accept It's a Secret to Everybody
step
    .goto Un'Goro Crater,63.107,69.057
    >>Click the Small Pack under the water next to the raft
    .turnin 3844 >> Turn in It's a Secret to Everybody
    .accept 3845 >> Accept It's a Secret to Everybody
step
    .goto Un'Goro Crater,67.324,73.041,8,0
    .goto Un'Goro Crater,66.601,66.727,8,0
    .goto Un'Goro Crater,60.926,72.234,8,0
    .goto Un'Goro Crater,62.285,65.985,8,0
    .goto Un'Goro Crater,63.240,77.350
    >>Walk over the Raptor Nests on the ground between the lake and Torwa. Each one spawns a Lar'korwi Mate, kill them for two pheromone glands
    .complete 4291,1 --Collect Ravasaur Pheromone Gland (x2)
step
    .goto Un'Goro Crater,71.639,75.960
.target Torwa Pathfinder
>>Talk to |cRXP_FRIENDLY_Torwa Pathfinder|r
    .turnin 4291 >> Turn in The Scent of Lar'korwi
    .accept 4292 >> Accept The Bait for Lar'korwi
step
    #completewith next
    .use 11568 >> Open Torwa's Pouch in your bags for the Preserved Threshadon Meat and the Preserved Pheromone Mixture
    .collect 11569,1,4292,1 --Preserved Threshadon Meat (1)
    .collect 11570,1,4292,1 --Preserved Pheromone Mixture (1)
step
    .goto Un'Goro Crater,79.929,49.896
    .use 11569 >> Ride north up the east side to the stone slab in the far east of the crater. Use the Preserved Threshadon Meat on the slab, then the Preserved Pheromone Mixture, and kill Lar'korwi when he comes. He is level 56 and hits hard, fight him with full health
    .complete 4292,1 --Collect Lar'korwi's Head (x1)
step
    .goto Un'Goro Crater,71.639,75.960
    >>Ride back south to Torwa
.target Torwa Pathfinder
>>Talk to |cRXP_FRIENDLY_Torwa Pathfinder|r
    .turnin 4292 >> Turn in The Bait for Lar'korwi
step
    .goto Un'Goro Crater,63.4,23.6,60,0
    .goto Un'Goro Crater,59.6,32.4,60,0
    .goto Un'Goro Crater,59.4,24.6,60,0
    .goto Un'Goro Crater,51.6,24.8,60,0
    .goto Un'Goro Crater,50.6,26.6,60,0
    .goto Un'Goro Crater,48.4,32.8,60,0
    .goto Un'Goro Crater,46.2,19.6
    >>Ride all the way north along the east side of the crater to the Lakkari Tar Pits. Kill Tar Beasts, Creepers, Lurkers and Lords for twelve Super Sticky Tar
    .complete 4504,1 --Collect Super Sticky Tar (x12)
step
    .goto Un'Goro Crater,45.234,5.831
    >>Marshal's Refuge is in the cliff wall to the north
    .fp Un'Goro >> Get the Un'Goro Crater flight path
step
    .goto Un'Goro Crater,44.658,8.098
    .use 11107 >> Open the Small Pack in your bags for the compass, map and key
    .complete 3845,1 --Collect Large Compass (x1)
    .complete 3845,2 --Collect Curled Map Parchment (x1)
    .complete 3845,3 --Collect Lion-headed Key (x1)
step
    .goto Un'Goro Crater,44.658,8.098
.target Linken
>>Talk to |cRXP_FRIENDLY_Linken|r
    .turnin 3845 >> Turn in It's a Secret to Everybody
step
    .goto Un'Goro Crater,43.947,7.137
    .use 11116 >> If A Mangled Journal dropped for you from any Un'Goro mob, right-click it to start the quest and hand it to Williden. Skips itself if you do not have it
    .collect 11116,1,3884,1 --A Mangled Journal (1)
    .accept 3884 >> Accept Williden's Journal
    .turnin 3884 >> Turn in Williden's Journal
    .itemcount 11116,1
step
    .goto Un'Goro Crater,43.947,7.137
.target Williden Marshal
>>Talk to |cRXP_FRIENDLY_Williden Marshal|r
    .accept 3881 >> Accept Expedition Salvation
step
    .goto Un'Goro Crater,43.889,7.240
.target Hol'anyee Marshal
>>Talk to |cRXP_FRIENDLY_Hol'anyee Marshal|r
    .accept 3883 >> Accept Alien Ecology
step
    .goto Un'Goro Crater,43.5,7.42
.target Spark Nilminer
>>Talk to |cRXP_FRIENDLY_Spark Nilminer|r
    .accept 3882 >> Accept Roll the Bones
step
    .goto Un'Goro Crater,43.533,8.436
    >>Click the Wanted Poster
    .accept 4501 >> Accept Beware of Pterrordax
step
    .goto Un'Goro Crater,43.615,8.499
.target Spraggle Frock
>>Talk to |cRXP_FRIENDLY_Spraggle Frock|r
    .accept 4492 >> Accept Lost!
step
    .goto Un'Goro Crater,42.942,9.635
.target Muigin
>>Talk to |cRXP_FRIENDLY_Muigin|r
    .accept 4141 >> Accept Muigin and Larion
step
    .goto Un'Goro Crater,44.232,11.583
.target Shizzle
>>Talk to |cRXP_FRIENDLY_Shizzle|r
    .accept 4503 >> Accept Shizzle's Flyer
step
    #sticky
    #completewith ringoEscort
    >>Kill Bloodpetal plants wherever you meet them for fifteen Bloodpetals
    .complete 4141,1 --Collect Bloodpetal (x15)
step
    #sticky
    #completewith ringoEscort
    >>Loot Dinosaur Bones from Diemetradons and Stegodons as you go, and from the bone piles on the ground in Terror Run
    .complete 3882,1 --Collect Dinosaur Bone (x8)
step
    #sticky
    #completewith next
    +Loop two: west into the pterrordax and diemetradon fields, south through Terror Run, east into the Slithering Scar hive, then up Fire Plume Ridge to Ringo and escort him back to the Refuge. Once you are level 58 the remaining objectives skip themselves
step
    .maxlevel 57
    .goto Un'Goro Crater,34.8,29.4,70,0
    .goto Un'Goro Crater,27.0,44.8,70,0
    .goto Un'Goro Crater,22.4,50.0,70,0
    .goto Un'Goro Crater,28.4,60.8,70,0
    .goto Un'Goro Crater,39.6,42.2
    >>Ride south-west out of the Refuge. Kill Frenzied Pterrordax and Elder Diemetradons in the western fields for the poster and both kinds of scales
    .complete 4501,1 --Kill Frenzied Pterrordax (x10)
    .complete 4503,2 --Collect Webbed Pterrordax Scale (x8)
    .complete 4503,1 --Collect Webbed Diemetradon Scale (x8)
step
    .maxlevel 57
    .goto Un'Goro Crater,38.457,66.066
    >>Ride south into Terror Run and loot the Research Equipment from the ground by the fallen tent
    .complete 3881,2 --Collect Research Equipment (x1)
step
    .maxlevel 57
    .goto Un'Goro Crater,38.64,77.53,50,0
    .goto Un'Goro Crater,34.48,71.96,50,0
    .goto Un'Goro Crater,37.21,72.73,50,0
    .goto Un'Goro Crater,31.13,77.97
    >>Loot the Dinosaur Bone piles on the ground around Terror Run until you have eight. Watch the elite stegodons and devilsaurs here
    .complete 3882,1 --Collect Dinosaur Bone (x8)
step
    .maxlevel 57
    .goto Un'Goro Crater,44.8,75.6,60,0
    .goto Un'Goro Crater,45.0,83.6,60,0
    .goto Un'Goro Crater,54.4,76.4,60,0
    .goto Un'Goro Crater,55.0,83.6,60,0
    .goto Un'Goro Crater,49.93,81.70
    >>Ride east to the Slithering Scar. Kill Gorishi silithid outside and inside the hive until a Gorishi Scent Gland drops
    .complete 4496,1 --Collect Gorishi Scent Gland (x1)
step
    .maxlevel 57
    .goto Un'Goro Crater,48.671,85.322
    .use 11132 >> Go down into the hive and use the Unused Scraping Vial in the centre of the round chamber
    .complete 3883,1 --Collect Hive Wall Sample (x1)
step
    .maxlevel 57
    .goto Un'Goro Crater,48.81,45.94,10,0
    .goto Un'Goro Crater,51.909,49.870
    >>Ride north to Fire Plume Ridge and go up the lava path on its west side to the top. Ringo is up there
.target Ringo
>>Talk to |cRXP_FRIENDLY_Ringo|r
    .turnin 4492 >> Turn in Lost!
    .accept 4491,1 >> Accept A Little Help From My Friends
step
    #label ringoEscort
    .isOnQuest 4491
    .goto Un'Goro Crater,43.617,8.497
    .use 11804 >> Escort Ringo back north to Marshal's Refuge. When he faints and stops following, use Spraggle's Canteen on him
    .complete 4491,1 --Escort Ringo to Marshal's Refuge
step
    .isOnQuest 4491
    .goto Un'Goro Crater,43.617,8.497
.target Spraggle Frock
>>Talk to |cRXP_FRIENDLY_Spraggle Frock|r
    .turnin 4491 >> Turn in A Little Help From My Friends
step
    .isQuestComplete 4501
    .goto Un'Goro Crater,43.617,8.497
.target Spraggle Frock
>>Talk to |cRXP_FRIENDLY_Spraggle Frock|r
    .turnin 4501 >> Turn in Beware of Pterrordax
step
    .isQuestComplete 3882
    .goto Un'Goro Crater,43.497,7.420
.target Spark Nilminer
>>Talk to |cRXP_FRIENDLY_Spark Nilminer|r
    .turnin 3882 >> Turn in Roll the Bones
step
    .isQuestComplete 3883
    .goto Un'Goro Crater,43.889,7.240
.target Hol'anyee Marshal
>>Talk to |cRXP_FRIENDLY_Hol'anyee Marshal|r
    .turnin 3883 >> Turn in Alien Ecology
step
    .isQuestComplete 3881
    .goto Un'Goro Crater,43.947,7.137
.target Williden Marshal
>>Talk to |cRXP_FRIENDLY_Williden Marshal|r
    .turnin 3881 >> Turn in Expedition Salvation
step
    .isQuestComplete 4141
    .goto Un'Goro Crater,42.942,9.635
.target Muigin
>>Talk to |cRXP_FRIENDLY_Muigin|r
    .turnin 4141 >> Turn in Muigin and Larion
step
    .isQuestComplete 4503
    .goto Un'Goro Crater,44.232,11.586
.target Shizzle
>>Talk to |cRXP_FRIENDLY_Shizzle|r
    .turnin 4503 >> Turn in Shizzle's Flyer
step
    .goto Un'Goro Crater,41.918,2.703
    >>Only if you collected seven of every Power Crystal. Skips itself otherwise
.target J.D. Collie
>>Talk to |cRXP_FRIENDLY_J.D. Collie|r
    .accept 4284 >> Accept Crystals of Power
    .turnin 4284 >> Turn in Crystals of Power
    .itemcount 11186,7
    .itemcount 11185,7
    .itemcount 11184,7
    .itemcount 11188,7
step
    #label ungoroDone
    >>Clean up before leaving Un'Goro. These only show if the quest is still in your log
    .abandon 4501 >> Abandon Beware of Pterrordax
    .abandon 4503 >> Abandon Shizzle's Flyer
    .abandon 3881 >> Abandon Expedition Salvation
    .abandon 3882 >> Abandon Roll the Bones
    .abandon 3883 >> Abandon Alien Ecology
    .abandon 4141 >> Abandon Muigin and Larion
    .abandon 4492 >> Abandon Lost!
    .abandon 4491 >> Abandon A Little Help From My Friends
    .abandon 3884 >> Abandon Williden's Journal
step
    .goto Un'Goro Crater,49.93,81.70,60,0
    .goto Un'Goro Crater,45.0,83.6
    .xp 58 >> Outland needs level 58. If you are still short, kill Gorishi around the Slithering Scar until you ding. Skips itself once you are 58
step
    #completewith next
    .hs >> Hearth to Gadgetzan
step
    .isQuestComplete 4496
    .goto Tanaris,50.887,26.963
.target Alchemist Pestlezugg
>>Talk to |cRXP_FRIENDLY_Alchemist Pestlezugg|r
    .turnin 4496 >> Turn in Bungle in the Jungle
step
    .isQuestComplete 4504
    .goto Tanaris,51.566,26.759
.target Tran'rek
>>Talk to |cRXP_FRIENDLY_Tran'rek|r
    .turnin 4504 >> Turn in Super Sticky
step
    .abandon 4496 >> Abandon Bungle in the Jungle if the gland never dropped
    .abandon 4504 >> Abandon Super Sticky
step
    #sticky
    #completewith next
    +Un'Goro is done at 58. Next: Outland. Fly to Theramore, let Jaina teleport you to Stormwind (Proof of Treachery is still in your log), train, then ride to the Dark Portal in the Blasted Lands. The Hellfire chapter starts here in Gadgetzan
step
    .goto Tanaris,51.006,29.345
    .fly Theramore >> Fly to Theramore
]])

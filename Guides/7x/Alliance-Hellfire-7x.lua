-- RestedXP 7x route: Hellfire Peninsula (WotLK 3.3.5a, Warmane 7x). Arrive at 58 from
-- Un'Goro via Theramore, Jaina's Stormwind teleport, the Stormwind Blasted Lands portal and
-- the Dark Portal. At 7x Hellfire alone covers 58 to 68: its level 58-63 quests stay at full
-- value until 66-68, so the rest of Outland is skipped and the chapter ends by riding to
-- Shattrath for the Stormwind portal and the Borean Tundra boat. Order follows the stock
-- 59-61 chapter (Honor Hold east, Shatter Point, Honor Hold south, Temple of Telhamat,
-- Cenarion Post) minus Ramparts/Blood Furnace, the group quests (Overlord, Drillmaster,
-- Rock Flayer Matriarch, Colossal Menace, Natural Remedies), the Shattrath training detour
-- and the Nethergarde Bitter chain. Later objective steps carry .maxlevel 67.
local faction = UnitFactionGroup("player")
if faction == "Horde" then return end

RXPGuides.RegisterGuide([[
#wotlk
<< Alliance
#name 58-68 Hellfire (7x)
#version 1
#group RestedXP Alliance 7x
#next 68-77 Borean Tundra (7x)
step
    #sticky
    #completewith next
    +Outland at 7x: Hellfire Peninsula alone carries you from 58 to 68, so Zangarmarsh, Terokkar, Nagrand and the rest are skipped. First a training stop in Stormwind on the way to the Dark Portal. Honor Hold has no class trainers, Druids use Teleport: Moonglade
step
    #completewith next
    .goto Dustwallow Marsh,66.272,49.031
    .gossip 4968,0 >> Talk to Lady Jaina Proudmoore at the top of the tower and ask her to send you to Stormwind (needs Proof of Treachery in your log). If you lost the quest, take the boat to Menethil Harbor, fly to Ironforge and ride the Deeprun Tram instead
    .skipgossip
.target Lady Jaina Proudmoore
step << Warrior
    .goto StormwindClassic,76.08,50.14,15,0
    .goto StormwindClassic,78.68,45.79
    >>Command Center in Old Town
    .trainer >> Train your class spells
step << Rogue
    .goto StormwindClassic,74.65,52.83
    >>SI:7 in Old Town
    .trainer >> Train your class spells
step << Hunter
    .goto StormwindClassic,61.609,15.269
    >>Dwarven District
    .trainer >> Train your class spells
step << Priest
    .goto StormwindClassic,38.54,26.86
    >>Cathedral of Light
    .trainer >> Train your class spells
step << Druid
    .goto StormwindClassic,20.898,55.491
    >>The Park
    .trainer >> Train your class spells
step
    .goto StormwindClassic,48.99,87.36
    .zone Blasted Lands >> Take the portal to the Blasted Lands inside the Wizard's Sanctum in the Mage Quarter
step
    .goto Blasted Lands,58.33,55.90
.target Watch Commander Relthorn Netherwane
>>Talk to |cRXP_FRIENDLY_Watch Commander Relthorn Netherwane|r at the foot of the Dark Portal
    .accept 10119 >> Accept Through the Dark Portal
step
    .goto Blasted Lands,58.764,60.162
    .zone Hellfire Peninsula >> Go through the Dark Portal
step
    .goto Hellfire Peninsula,87.32,50.75
.target Commander Duron
>>Talk to |cRXP_FRIENDLY_Commander Duron|r
    .turnin 10119 >> Turn in Through the Dark Portal
    .accept 10288 >> Accept Arrival in Outland
step
    .goto Hellfire Peninsula,87.36,52.42
.target Amish Wildhammer
>>Talk to |cRXP_FRIENDLY_Amish Wildhammer|r
    .turnin 10288 >> Turn in Arrival in Outland
    .accept 10140 >> Accept Journey to Honor Hold
step
    .goto Hellfire Peninsula,87.36,52.42
    .fly Honor Hold >> Fly to Honor Hold (Amish Wildhammer offers the flight)
step
    .goto Hellfire Peninsula,54.81,62.79
.target Marshal Isildor
>>Talk to |cRXP_FRIENDLY_Marshal Isildor|r
    .turnin 10140 >> Turn in Journey to Honor Hold
    .accept 10254 >> Accept Force Commander Danath
step
    .goto Hellfire Peninsula,54.22,63.60
    .home >> Set your Hearthstone to Honor Hold
    .bindlocation 3538
step
    .goto Hellfire Peninsula,54.669,63.566
    .fp Honor Hold >> Get the Honor Hold flight path
step
    .goto Hellfire Peninsula,56.64,66.70
    >>Inside the keep
.target Force Commander Danath Trollbane
>>Talk to |cRXP_FRIENDLY_Force Commander Danath Trollbane|r
    .turnin 10254 >> Turn in Force Commander Danath
    .accept 10160 >> Accept Know your Enemy
    .accept 10141 >> Accept The Legion Reborn
step
    .goto Hellfire Peninsula,50.91,60.19
    >>Outside the west gate
.target Lieutenant Amadi
>>Talk to |cRXP_FRIENDLY_Lieutenant Amadi|r
    .turnin 10160 >> Turn in Know your Enemy
    .accept 10482 >> Accept Fel Orc Scavengers
step
    .goto Hellfire Peninsula,51.12,60.30
    >>Dumphry wanders around the west gate
.target Dumphry
>>Talk to |cRXP_FRIENDLY_Dumphry|r
    .accept 10055 >> Accept Waste Not, Want Not
step
    .goto Hellfire Peninsula,54.53,54.12,70,0
    .goto Hellfire Peninsula,52.5,56.0,70,0
    .goto Hellfire Peninsula,56.5,56.5
    >>Ride north to the ruined siege line. Kill Bonechewer Orcs and loot the Salvaged Metal and Salvaged Wood lying around the wreckage
    .complete 10482,1 --Kill Bonechewer Orc (x20)
    .complete 10055,1 --Collect Salvaged Metal (x8)
    .complete 10055,2 --Collect Salvaged Wood (x8)
step
    .goto Hellfire Peninsula,51.12,60.30
.target Dumphry
>>Talk to |cRXP_FRIENDLY_Dumphry|r
    .turnin 10055 >> Turn in Waste Not, Want Not
    .accept 10078 >> Accept Laying Waste to the Unwanted
step
    .goto Hellfire Peninsula,50.91,60.19
.target Lieutenant Amadi
>>Talk to |cRXP_FRIENDLY_Lieutenant Amadi|r
    .turnin 10482 >> Turn in Fel Orc Scavengers
    .accept 10483 >> Accept Ill Omens
step
    .goto Hellfire Peninsula,61.72,60.95
    >>Ride east along the road
.target Sergeant Altumus
>>Talk to |cRXP_FRIENDLY_Sergeant Altumus|r
    .turnin 10141 >> Turn in The Legion Reborn
    .accept 10142 >> Accept The Path of Anguish
step
    .goto Hellfire Peninsula,65.83,59.06,60,0
    .goto Hellfire Peninsula,68.0,58.5,60,0
    .goto Hellfire Peninsula,66.5,60.5
    >>Kill the demons along the Path of Anguish east of Altumus. The Dreadcaller stands in the middle of them
    .complete 10142,2 --Kill Flamewaker Imp (x4)
    .complete 10142,3 --Kill Infernal Warbringer (x6)
    .complete 10142,1 --Kill Dreadcaller (x1)
step
    .goto Hellfire Peninsula,61.72,60.95
.target Sergeant Altumus
>>Talk to |cRXP_FRIENDLY_Sergeant Altumus|r
    .turnin 10142 >> Turn in The Path of Anguish
    .accept 10143 >> Accept Expedition Point
step
    .goto Hellfire Peninsula,67.88,66.92,60,0
    .goto Hellfire Peninsula,68.5,69.5
    >>Ride south-east to the edge of Zeth'Gor and kill Bleeding Hollow orcs until a Cursed Talisman drops
    .complete 10483,1 --Collect Cursed Talisman (x1)
step
    .goto Hellfire Peninsula,70.96,63.37
    >>Expedition Point is on the hill to the north-east
.target Corporal Ironridge
>>Talk to |cRXP_FRIENDLY_Corporal Ironridge|r
    .turnin 10483 >> Turn in Ill Omens
    .accept 10484 >> Accept Cursed Talismans
step
    .goto Hellfire Peninsula,71.34,62.77
.target Forward Commander Kingston
>>Talk to |cRXP_FRIENDLY_Forward Commander Kingston|r
    .turnin 10143 >> Turn in Expedition Point
    .accept 10144 >> Accept Disrupt Their Reinforcements
step
    .goto Hellfire Peninsula,71.40,62.48
.target Wing Commander Dabir'ee
>>Talk to |cRXP_FRIENDLY_Wing Commander Dabir'ee|r
    .accept 10895 >> Accept Zeth'Gor Must Burn!
step
    .goto Hellfire Peninsula,72.73,58.95
    >>Ride north to Portal Kaalez. Kill the demons around it, then click the portal to prime it
    .complete 10144,2 --Prime Portal Kaalez
step
    .goto Hellfire Peninsula,71.46,55.16
    >>Same at Portal Grimh further north
    .complete 10144,1 --Prime Portal Grimh
step
    .goto Hellfire Peninsula,71.34,62.77
.target Forward Commander Kingston
>>Talk to |cRXP_FRIENDLY_Forward Commander Kingston|r
    .turnin 10144 >> Turn in Disrupt Their Reinforcements
    .accept 10146 >> Accept Mission: The Murketh and Shaadraz Gateways
step
    #timer Mission: Gateways Flight
    #completewith next
    .goto Hellfire Peninsula,71.41,62.48
    .gossipoption 118831 >> Talk to Wing Commander Dabir'ee to start the bombing run over the gateways
    .skipgossip
    .timer 102,Mission: Gateways Flight
.target Wing Commander Dabir'ee
step
    .goto Hellfire Peninsula,77.73,51.80,-1
    .goto Hellfire Peninsula,78.00,47.24,-1
    .use 28038 >> During the flight, use the Seaforium PU-36 Explosive Nether Modulator on Gateway Shaadraz and then Gateway Murketh as the gryphon passes over them
    .complete 10146,2 --Destroy Gateway Shaadraz
    .complete 10146,1 --Destroy Gateway Murketh
step
    .goto Hellfire Peninsula,71.34,62.77
.target Forward Commander Kingston
>>Talk to |cRXP_FRIENDLY_Forward Commander Kingston|r
    .turnin 10146 >> Turn in Mission: The Murketh and Shaadraz Gateways
    .accept 10340 >> Accept Shatter Point
step
    #sticky
    #label talismans
    >>Kill Bleeding Hollow orcs in Zeth'Gor as you go for twelve Cursed Talismans
    .complete 10484,1 --Collect Cursed Talisman (x12)
step
    .goto Hellfire Peninsula,67.98,66.73,-1
    .goto Hellfire Peninsula,70.13,69.06,-1
    .goto Hellfire Peninsula,70.92,71.45,-1
    .goto Hellfire Peninsula,66.46,76.47,-1
    .use 31739 >> Ride south into Zeth'Gor and use the torches from the bundle at the foot of each of the four towers: north, forge, foothill and south
    .complete 10895,1 --Burn the North Tower
    .complete 10895,3 --Burn the Forge Tower
    .complete 10895,4 --Burn the Foothill Tower
    .complete 10895,2 --Burn the South Tower
step
    #requires talismans
    .goto Hellfire Peninsula,70.96,63.37
    >>Back up to Expedition Point
.target Corporal Ironridge
>>Talk to |cRXP_FRIENDLY_Corporal Ironridge|r
    .turnin 10484 >> Turn in Cursed Talismans
    .accept 10485 >> Accept Warlord of the Bleeding Hollow
step
    .goto Hellfire Peninsula,71.40,62.48
.target Wing Commander Dabir'ee
>>Talk to |cRXP_FRIENDLY_Wing Commander Dabir'ee|r
    .turnin 10895 >> Turn in Zeth'Gor Must Burn!
step
    .goto Hellfire Peninsula,69.667,76.493,40,0
    .goto Hellfire Peninsula,70.47,76.15
    >>Ride back into the south end of Zeth'Gor. Warlord Morkh is in the big hut at the back, loot his shattered armor
    .complete 10485,1 --Collect Morkh's Shattered Armor (x1)
step
    .goto Hellfire Peninsula,70.96,63.37
.target Corporal Ironridge
>>Talk to |cRXP_FRIENDLY_Corporal Ironridge|r
    .turnin 10485 >> Turn in Warlord of the Bleeding Hollow
    .accept 10903 >> Accept Return to Honor Hold
step
    #timer Shatter Point Flight
    #completewith next
    .goto Hellfire Peninsula,71.41,62.48
    .gossip 19409,0 >> Talk to Wing Commander Dabir'ee again and take the free gryphon to Shatter Point
    .skipgossip 19409,1
    .timer 56,Shatter Point Flight
.target Wing Commander Dabir'ee
step
    .goto Hellfire Peninsula,78.42,34.90
.target Runetog Wildhammer
>>Talk to |cRXP_FRIENDLY_Runetog Wildhammer|r
    .turnin 10340 >> Turn in Shatter Point
    .accept 10344 >> Accept Wing Commander Gryphongar
step
    .goto Hellfire Peninsula,79.34,33.86
.target Wing Commander Gryphongar
>>Talk to |cRXP_FRIENDLY_Wing Commander Gryphongar|r
    .turnin 10344 >> Turn in Wing Commander Gryphongar
    .accept 10163 >> Accept Mission: The Abyssal Shelf
step
    #timer Mission: The Abyssal Shelf Flight
    #completewith next
    .goto Hellfire Peninsula,78.25,34.45
    .gossip 20235,0 >> Talk to Gryphoneer Windbellow and ask to be sent to the Abyssal Shelf. If you do not finish the kills on one pass, talk to her again
    .timer 154,Mission: The Abyssal Shelf Flight
    .skipgossip 20235,1
.target Gryphoneer Windbellow
step
    .goto Hellfire Peninsula,72.21,23.78,-1
    .goto Hellfire Peninsula,72.60,19.99,-1
    .goto Hellfire Peninsula,73.04,15.18,-1
    .goto Hellfire Peninsula,72.69,11.19,-1
    .use 28132 >> During the flight, throw the Area 52 Special at the Gan'arg Peons, Mo'arg Overseers and Fel Cannons below. Spam it, the bombs splash
    .complete 10163,1 --Kill Gan'arg Peon (x20)
    .complete 10163,2 --Kill Mo'arg Overseer (x5)
    .complete 10163,3 --Kill Fel Cannon (x5)
step
    .goto Hellfire Peninsula,79.34,33.86
.target Wing Commander Gryphongar
>>Talk to |cRXP_FRIENDLY_Wing Commander Gryphongar|r
    .turnin 10163 >> Turn in Mission: The Abyssal Shelf
    .accept 10382 >> Accept Go to the Front
step
    #timer Honor Point Flight
    #completewith next
    .goto Hellfire Peninsula,78.25,34.45
    .gossip 20235,0 >> Talk to Gryphoneer Windbellow and ask for the flight to Honor Point
    .skipgossip 20235,1
    .timer 40,Honor Point Flight
.target Gryphoneer Windbellow
step
    .goto Hellfire Peninsula,68.29,28.55
.target Field Marshal Brock
>>Talk to |cRXP_FRIENDLY_Field Marshal Brock|r
    .turnin 10382 >> Turn in Go to the Front
    .accept 10394 >> Accept Disruption - Forge Camp: Mageddon
step
    .goto Hellfire Peninsula,65.55,32.56,50,0
    .goto Hellfire Peninsula,63.50,31.00,50,0
    .goto Hellfire Peninsula,64.82,31.91
    >>Ride west into Forge Camp: Mageddon. Kill ten Gan'arg Servants and Razorsaw, who patrols the camp
    .unitscan Razorsaw
    .complete 10394,1 --Kill Gan'arg Servant (x10)
    .complete 10394,2 --Kill Razorsaw (x1)
step
    .goto Hellfire Peninsula,68.29,28.55
.target Field Marshal Brock
>>Talk to |cRXP_FRIENDLY_Field Marshal Brock|r
    .turnin 10394 >> Turn in Disruption - Forge Camp: Mageddon
    .accept 10396 >> Accept Enemy of my Enemy...
step
    .goto Hellfire Peninsula,66.57,32.01,50,0
    .goto Hellfire Peninsula,64.5,33.2
    >>Back into the forge camp. Kill three Fel Cannon MKI, they stand near the Gan'arg engineers
    .complete 10396,1 --Kill Fel Cannon MKI (x3)
step
    .goto Hellfire Peninsula,68.29,28.55
.target Field Marshal Brock
>>Talk to |cRXP_FRIENDLY_Field Marshal Brock|r
    .turnin 10396 >> Turn in Enemy of my Enemy...
    .accept 10397 >> Accept Invasion Point: Annihilator
step
    .goto Hellfire Peninsula,53.09,26.46
    .use 29588 >> Ride west along the north road to Invasion Point: Annihilator. Kill Warbringer Arix'Amal in front of the gate and loot the gate key and the Burning Legion Missive, then right-click the missive to start a quest
    .complete 10397,1 --Kill Warbringer Arix'Amal (x1)
    .complete 10397,3 --Collect Burning Legion Gate Key (x1)
    .collect 29588,1,10395,1 --Burning Legion Missive (1)
    .accept 10395 >> Accept The Dark Missive
step
    .goto Hellfire Peninsula,53.04,27.71
    >>Click the Rune of Spite inside the gate
    .complete 10397,2 --Destroy the Rune of Spite
step
    .goto Hellfire Peninsula,68.29,28.55
    >>Ride back east to Honor Point
.target Field Marshal Brock
>>Talk to |cRXP_FRIENDLY_Field Marshal Brock|r
    .turnin 10397 >> Turn in Invasion Point: Annihilator
step
    #completewith next
    .hs >> Hearth to Honor Hold
step
    .goto Hellfire Peninsula,54.29,63.58
    >>Inside the chapel
.target Father Malgor Devidicus
>>Talk to |cRXP_FRIENDLY_Father Malgor Devidicus|r
    .accept 10058 >> Accept An Old Gift
step
    .goto Hellfire Peninsula,54.32,63.65
.target Assistant Klatu
>>Talk to |cRXP_FRIENDLY_Assistant Klatu|r
    .turnin 10903 >> Turn in Return to Honor Hold
    .accept 10909 >> Accept Fel Spirits
    .accept 10916 >> Accept Digging for Prayer Beads
step
    .goto Hellfire Peninsula,56.69,66.52
    >>Inside the keep
.target Warp-Scryer Kryv
>>Talk to |cRXP_FRIENDLY_Warp-Scryer Kryv|r
    .turnin 10395 >> Turn in The Dark Missive
    .accept 10399 >> Accept The Heart of Darkness
    .accept 10047 >> Accept The Path of Glory
step
    .goto Hellfire Peninsula,54.16,63.32
    >>Loot the Dirt Mound outside the inn for the Draenei Prayer Beads. If there is no mound, buy a Fei Fei Doggy Treat from the vendor at 56.3,62.8, give it to Fei Fei the dog next to the inn and follow her until she digs the beads up
    .complete 10916,1 --Collect Draenei Prayer Beads (x1)
step
    .goto Hellfire Peninsula,50.88,60.35
.target Honor Guard Wesilow
>>Talk to |cRXP_FRIENDLY_Honor Guard Wesilow|r
    .accept 10050 >> Accept Unyielding Souls
step
    .goto Hellfire Peninsula,52.02,62.57
.target Foreman Biggums
>>Talk to |cRXP_FRIENDLY_Foreman Biggums|r
    .accept 9355 >> Accept A Job for an Intelligent Man
    .accept 10079 >> Accept When This Mine's a-Rockin'
step
    .goto Hellfire Peninsula,52.38,62.35,20,0
    .goto Hellfire Peninsula,53.5,62.0
    >>Go into the Honor Hold Mine behind Biggums and kill twelve Gan'arg Sappers
    .complete 10079,1 --Kill Gan'arg Sapper (x12)
step
    .goto Hellfire Peninsula,52.02,62.57
.target Foreman Biggums
>>Talk to |cRXP_FRIENDLY_Foreman Biggums|r
    .turnin 10079 >> Turn in When This Mine's a-Rockin'
    .accept 10099 >> Accept The Mastermind
step
    .goto Hellfire Peninsula,52.38,62.35,20,0
    .goto Hellfire Peninsula,56.21,61.52
    >>Back into the mine. Z'kral is at the very end of the tunnels
    .complete 10099,1 --Kill Z'kral (x1)
step
    .goto Hellfire Peninsula,52.02,62.57
.target Foreman Biggums
>>Talk to |cRXP_FRIENDLY_Foreman Biggums|r
    .turnin 10099 >> Turn in The Mastermind
step
    #sticky
    #completewith bursters
    .use 23338 >> Marauding Crust Bursters drop an Eroded Leather Case, right-click it to start a quest
    .collect 23338,1,9373,1 --Eroded Leather Case (1)
    .accept 9373 >> Accept Missing Missive
step
    #label bursters
    .goto Hellfire Peninsula,51.42,63.90,60,0
    .goto Hellfire Peninsula,49.5,66.0,60,0
    .goto Hellfire Peninsula,48.0,63.0
    >>Kill fifteen Marauding Crust Bursters in the sand south-west of Honor Hold. They burrow, wait for them to surface
    .complete 9355,1 --Kill Marauding Crust Burster (x15)
step
    .goto Hellfire Peninsula,52.02,62.57
.target Foreman Biggums
>>Talk to |cRXP_FRIENDLY_Foreman Biggums|r
    .turnin 9355 >> Turn in A Job for an Intelligent Man
step
    .goto Hellfire Peninsula,49.24,74.84
    >>Ride south to the zeppelin crash
.target Legassi
>>Talk to |cRXP_FRIENDLY_Legassi|r
    .accept 9349 >> Accept Ravager Egg Roundup
step
    .goto Hellfire Peninsula,49.15,74.86
.target "Screaming" Screed Luckheed
>>Talk to |cRXP_FRIENDLY_"Screaming" Screed Luckheed|r
    .accept 10161 >> Accept In Case of Emergency...
step
    #sticky
    #completewith next
    >>Loot the Zeppelin Debris scattered around the crash and the road south of it, thirty pieces
    .complete 10161,1 --Collect Zeppelin Debris (x30)
step
    .goto Hellfire Peninsula,54.96,86.82
    >>Ride south-east to the Expedition Armory. The book Mysteries of the Light lies on a table in the ruined chapel at the south end
    .complete 10058,1 --Collect Mysteries of the Light (x1)
step
    .goto Hellfire Peninsula,58.50,79.42,60,0
    .goto Hellfire Peninsula,56.5,76.0,60,0
    .goto Hellfire Peninsula,56.0,80.0
    >>Kill the Unyielding ghosts all over the Expedition Armory
    .complete 10050,1 --Kill Unyielding Footman (x12)
    .complete 10050,2 --Kill Unyielding Sorcerer (x10)
    .complete 10050,3 --Kill Unyielding Knight (x5)
step
    .goto Hellfire Peninsula,44.82,75.34
    .use 31772 >> Ride west to the Shattered Hand camp. Place the Anchorite Relic, kill the Shattered Hand Berserkers it marks and then the Fel Spirits that rise from them. The relic lasts five minutes, place it again if it expires
    .complete 10909,1 --Kill Fel Spirit (x10)
step
    .goto Hellfire Peninsula,41.83,85.16,60,0
    .goto Hellfire Peninsula,44.0,88.0
    >>Ride south-west to the ravager nests. Kill Razorfang Ravagers and loot twelve Ravager Eggs from the nests and the ravagers
    .complete 9349,1 --Collect Ravager Egg (x12)
step
    .goto Hellfire Peninsula,49.24,74.84
    >>Back to the zeppelin crash
.target Legassi
>>Talk to |cRXP_FRIENDLY_Legassi|r
    .turnin 9349 >> Turn in Ravager Egg Roundup
    .accept 9361 >> Accept Helboar, the Other White Meat
step
    .goto Hellfire Peninsula,46.10,71.85,55,0
    .goto Hellfire Peninsula,45.39,70.17,55,0
    .goto Hellfire Peninsula,46.89,68.32,55,0
    .goto Hellfire Peninsula,50.01,64.14,55,0
    .goto Hellfire Peninsula,52.83,70.37
    .use 23268 >> Kill Deranged Helboars around the crash and loot their Tainted Meat, then use the Purification Mixture on it. Eight purified pieces
    .collect 23270,8,9361,1,-1 --Tainted Meat (8)
    .complete 9361,1 --Collect Purified Helboar Meat (x8)
step
    .goto Hellfire Peninsula,49.24,74.84
.target Legassi
>>Talk to |cRXP_FRIENDLY_Legassi|r
    .turnin 9361 >> Turn in Helboar, the Other White Meat
    .accept 9356 >> Accept Smooth as Butter
step
    .goto Hellfire Peninsula,57.50,72.75,60,0
    .goto Hellfire Peninsula,60.0,70.0,60,0
    .goto Hellfire Peninsula,58.0,75.0
    >>Ride east. Kill Bonestripper Buzzards between the crash and the Expedition Armory for twelve Plump Buzzard Wings, and finish the Zeppelin Debris around here
    .complete 9356,1 --Collect Plump Buzzard Wing (x12)
    .complete 10161,1 --Collect Zeppelin Debris (x30)
step
    .goto Hellfire Peninsula,49.15,74.86
.target "Screaming" Screed Luckheed
>>Talk to |cRXP_FRIENDLY_"Screaming" Screed Luckheed|r
    .turnin 10161 >> Turn in In Case of Emergency...
    .accept 9351 >> Accept Voidwalkers Gone Wild
step
    .goto Hellfire Peninsula,49.24,74.84
.target Legassi
>>Talk to |cRXP_FRIENDLY_Legassi|r
    .turnin 9356 >> Turn in Smooth as Butter
step
    .goto Hellfire Peninsula,46.32,81.97,60,0
    .goto Hellfire Peninsula,45.65,84.23,60,0
    .goto Hellfire Peninsula,50.07,83.29
    >>Kill Uncontrolled Voidwalkers south of the crash for ten essences
    .complete 9351,1 --Collect Condensed Voidwalker Essence (x10)
step
    .goto Hellfire Peninsula,49.15,74.86
.target "Screaming" Screed Luckheed
>>Talk to |cRXP_FRIENDLY_"Screaming" Screed Luckheed|r
    .turnin 9351 >> Turn in Voidwalkers Gone Wild
step
    .goto Hellfire Peninsula,50.88,60.35
    >>Ride back to Honor Hold
.target Honor Guard Wesilow
>>Talk to |cRXP_FRIENDLY_Honor Guard Wesilow|r
    .turnin 10050 >> Turn in Unyielding Souls
    .accept 10057 >> Accept Looking to the Leadership
step
    .goto Hellfire Peninsula,54.29,63.58
.target Father Malgor Devidicus
>>Talk to |cRXP_FRIENDLY_Father Malgor Devidicus|r
    .turnin 10058 >> Turn in An Old Gift
step
    .goto Hellfire Peninsula,54.32,63.65
.target Assistant Klatu
>>Talk to |cRXP_FRIENDLY_Assistant Klatu|r
    .turnin 10909 >> Turn in Fel Spirits
    .turnin 10916 >> Turn in Digging for Prayer Beads
    .accept 10935 >> Accept The Exorcism of Colonel Jules
step
    #timer Colonel Jules roleplay
    #completewith next
    .goto Hellfire Peninsula,53.934,63.549
    .gossip 22431,0 >> Talk to Anchorite Barada in the bedroom upstairs in the inn to start the exorcism. It takes about three and a half minutes
    .skipgossip 22431,1
    .timer 215,Colonel Jules roleplay
.target Anchorite Barada
step
    .goto Hellfire Peninsula,53.929,63.636
    .use 31828 >> Stay in the room and use the Ritual Prayer Beads on the Darkened Spirits and Foul Purges as they appear, they die instantly. Do not let Barada get interrupted
    .complete 10935,1 --Exorcise Colonel Jules
step
    .goto Hellfire Peninsula,54.32,63.65
.target Assistant Klatu
>>Talk to |cRXP_FRIENDLY_Assistant Klatu|r
    .turnin 10935 >> Turn in The Exorcism of Colonel Jules
    .accept 10936 >> Accept Trollbane is Looking for You
step
    .goto Hellfire Peninsula,54.22,63.60
.target Sid Limbardi
>>Talk to |cRXP_FRIENDLY_Sid Limbardi|r the innkeeper
    .accept 9558 >> Accept The Longbeards
step
    .goto Hellfire Peninsula,56.64,66.70
.target Force Commander Danath Trollbane
>>Talk to |cRXP_FRIENDLY_Force Commander Danath Trollbane|r
    .turnin 10936 >> Turn in Trollbane is Looking for You
step
    .goto Hellfire Peninsula,53.67,81.10,40,0
    .goto Hellfire Peninsula,54.83,83.74
    >>Ride south to the Expedition Armory once more. Arch Mage Xintor is in the tower, Lieutenant Commander Thalvos in the courtyard to the south
    .complete 10057,1 --Kill Arch Mage Xintor (x1)
    .complete 10057,2 --Kill Lieutenant Commander Thalvos (x1)
step
    .goto Hellfire Peninsula,50.88,60.35
    >>Back to Honor Hold
.target Honor Guard Wesilow
>>Talk to |cRXP_FRIENDLY_Honor Guard Wesilow|r
    .turnin 10057 >> Turn in Looking to the Leadership
step
    .goto Hellfire Peninsula,49.63,52.08,50,0
    .goto Hellfire Peninsula,52.70,50.73,50,0
    .goto Hellfire Peninsula,58.99,49.83,50,0
    .goto Hellfire Peninsula,63.42,49.34
    .use 25889 >> Ride north to the Path of Glory (the main road east of the Dark Portal crossing). Use the Draenei Holy Water on eight Trampled Skeletons along the road
    .complete 10047,1 --Bless Trampled Skeleton (x8)
step
    .goto Hellfire Peninsula,58.50,47.64,-1
    .goto Hellfire Peninsula,55.70,47.48,-1
    .goto Hellfire Peninsula,53.55,48.24,-1
    .goto Hellfire Peninsula,52.64,48.01,-1
    .use 26002 >> Use the Flaming Torch on the four Horde catapults along the north side of the road
    .complete 10078,1 --Burn the east catapult
    .complete 10078,2 --Burn the second east catapult
    .complete 10078,3 --Burn the west catapult
    .complete 10078,4 --Burn the second west catapult
step
    .goto Hellfire Peninsula,51.37,30.52
    >>Ride north across the road to the crashed zeppelin below Thrallmar. The goblins are neutral
.target Foreman Razelcraz
>>Talk to |cRXP_FRIENDLY_Foreman Razelcraz|r
    .accept 10236 >> Accept Outland Sucks!
step
    .goto Hellfire Peninsula,47.98,37.39,50,0
    .goto Hellfire Peninsula,46.0,42.0
    >>Loot six Shredder Spare Parts from the wreckage scattered south-west of the crash
    .complete 10236,1 --Collect Shredder Spare Parts (x6)
step
    .goto Hellfire Peninsula,51.37,30.52
.target Foreman Razelcraz
>>Talk to |cRXP_FRIENDLY_Foreman Razelcraz|r
    .turnin 10236 >> Turn in Outland Sucks!
    .accept 10238 >> Accept How to Serve Goblins
step
    .goto Hellfire Peninsula,45.12,41.11,-1
    .goto Hellfire Peninsula,46.42,45.18,-1
    .goto Hellfire Peninsula,47.50,46.63,-1
    >>Free Manni, Moh and Jakk from the three cages in the Bleeding Hollow camp south-west of the crash
    .complete 10238,1 --Free Manni
    .complete 10238,2 --Free Moh
    .complete 10238,3 --Free Jakk
step
    .goto Hellfire Peninsula,51.37,30.52
.target Foreman Razelcraz
>>Talk to |cRXP_FRIENDLY_Foreman Razelcraz|r
    .turnin 10238 >> Turn in How to Serve Goblins
    .accept 10629 >> Accept Shizz Work
step
    #completewith next
    .goto Hellfire Peninsula,51.37,30.52
    .use 30803 >> Use the Felhound Whistle next to Razelcraz to summon the felhound
step
    .goto Hellfire Peninsula,50.7,28.9
    .use 30803 >> Kill Deranged Helboars near the crash with the felhound following you. After its roleplay, loot the Droppings for the Shredder Keys
    .complete 10629,1 --Collect Shredder Keys (x1)
step
    .goto Hellfire Peninsula,51.37,30.52
.target Foreman Razelcraz
>>Talk to |cRXP_FRIENDLY_Foreman Razelcraz|r
    .turnin 10629 >> Turn in Shizz Work
    .accept 10630 >> Accept Beneath Thrallmar
step
    .goto Hellfire Peninsula,51.72,31.68,20,0
    .goto Hellfire Peninsula,52.57,30.59,20,0
    .goto Hellfire Peninsula,54.39,31.57
    >>Go into the Thrallmar Mine east of the crash. Urga'zz is at the back
    .complete 10630,1 --Kill Urga'zz (x1)
step
    .goto Hellfire Peninsula,51.37,30.52
.target Foreman Razelcraz
>>Talk to |cRXP_FRIENDLY_Foreman Razelcraz|r
    .turnin 10630 >> Turn in Beneath Thrallmar
step
    #sticky
    #completewith next
    +Loop three: the Temple of Telhamat in the west. Ride west along the road past the Pools of Aggonar, the temple is on the hill on the far side
step
    .goto Hellfire Peninsula,23.36,41.29,50,0
    .goto Hellfire Peninsula,23.36,37.45
    >>Scout Vanura patrols up and down the central ramp of the temple
.target Scout Vanura
>>Talk to |cRXP_FRIENDLY_Scout Vanura|r
    .accept 9398 >> Accept Deadly Predators
step
    .goto Hellfire Peninsula,23.00,40.37
.target Anchorite Obadei
>>Talk to |cRXP_FRIENDLY_Anchorite Obadei|r
    .accept 9390 >> Accept In Search of Sedai
step
    .goto Hellfire Peninsula,23.09,40.22
.target Ikan
>>Talk to |cRXP_FRIENDLY_Ikan|r
    .accept 9399 >> Accept Cruel Taskmasters
step
    .goto Hellfire Peninsula,23.35,36.36
    .home >> Set your Hearthstone to the Temple of Telhamat
    .bindlocation 3552
step
    .goto Hellfire Peninsula,25.193,37.230
    .fp Temple of Telhamat >> Get the Temple of Telhamat flight path
step
    .goto Hellfire Peninsula,23.21,36.66
.target Elsaana
>>Talk to |cRXP_FRIENDLY_Elsaana|r
    .accept 9383 >> Accept An Ambitious Plan
step
    .goto Hellfire Peninsula,23.42,36.54
.target Amaan the Wise
>>Talk to |cRXP_FRIENDLY_Amaan the Wise|r
    .accept 9426 >> Accept The Pools of Aggonar
step
    .goto Hellfire Peninsula,26.90,37.43
    >>Sedai's Corpse lies just east of the temple, below the ramp
.target Sedai's Corpse
>>Click |cRXP_FRIENDLY_Sedai's Corpse|r
    .turnin 9390 >> Turn in In Search of Sedai
    .accept 9423 >> Accept Return to Obadei
step
    .goto Hellfire Peninsula,23.00,40.37
.target Anchorite Obadei
>>Talk to |cRXP_FRIENDLY_Anchorite Obadei|r
    .turnin 9423 >> Turn in Return to Obadei
step
    .goto Hellfire Peninsula,23.14,40.16
.target Makuru
>>Talk to |cRXP_FRIENDLY_Makuru|r
    .accept 9424 >> Accept Makuru's Vengeance
step
    .goto Hellfire Peninsula,34.10,32.54,60,0
    .goto Hellfire Peninsula,35.5,30.0
    >>Ride east to the Mag'har grounds north of the road. Kill Debilitated Mag'har for ten Ancestral Beads
    .complete 9424,1 --Collect Mag'har Ancestral Beads (x10)
step
    .goto Hellfire Peninsula,44.25,29.53,60,0
    .goto Hellfire Peninsula,39.8,28.0,60,0
    .goto Hellfire Peninsula,40.0,40.0
    >>Continue east into the Pools of Aggonar. Kill Terrorfiends and Blistering Rots around the pools
    .complete 10399,1 --Kill Terrorfiend (x10)
    .complete 9426,1 --Kill Terrorfiend (x6)
    .complete 9426,2 --Kill Blistering Rot (x6)
step
    #completewith next
    .hs >> Hearth to the Temple of Telhamat
step
    .goto Hellfire Peninsula,23.14,40.16
.target Makuru
>>Talk to |cRXP_FRIENDLY_Makuru|r
    .turnin 9424 >> Turn in Makuru's Vengeance
step
    .goto Hellfire Peninsula,23.00,40.37
.target Anchorite Obadei
>>Talk to |cRXP_FRIENDLY_Anchorite Obadei|r
    .accept 9543 >> Accept Atonement
step
    .goto Hellfire Peninsula,23.42,36.54
.target Amaan the Wise
>>Talk to |cRXP_FRIENDLY_Amaan the Wise|r
    .turnin 9543 >> Turn in Atonement
    .accept 9430 >> Accept Sha'naar Relics
    .turnin 9426 >> Turn in The Pools of Aggonar
    .accept 9427 >> Accept Cleansing the Waters
step
    .goto Hellfire Peninsula,40.14,30.78
    .use 23361 >> Ride back east to the Pools of Aggonar. Use the Cleansing Vial next to the Bones of Aggonar in the biggest pool to summon Aggonis, and kill him
    .complete 9427,1 --Kill Aggonis (x1)
step
    .goto Hellfire Peninsula,34.74,60.88,60,0
    .goto Hellfire Peninsula,40.8,64.7,60,0
    .goto Hellfire Peninsula,37.2,63.0
    >>Ride south to the Great Fissure. Kill Stonescythe Alphas and Whelps around the rock flayer nests
    .complete 9398,1 --Kill Stonescythe Alpha (x4)
    .complete 9398,2 --Kill Stonescythe Whelp (x8)
step
    .goto Hellfire Peninsula,23.89,72.17
    >>Ride south-west to the Longbeards' camp on the plateau
.target Gremni Longbeard
>>Talk to |cRXP_FRIENDLY_Gremni Longbeard|r
    .turnin 9558 >> Turn in The Longbeards
    .accept 9417 >> Accept The Arakkoa Threat
    .accept 9385 >> Accept Rampaging Ravagers
step
    .goto Hellfire Peninsula,21.71,70.55,60,0
    .goto Hellfire Peninsula,22.4,66.7
    >>Kill ten Quillfang Ravagers around the camp
    .complete 9385,1 --Kill Quillfang Ravager (x10)
step
    #sticky
    #completewith aeranas
    .use 23580 >> Avruu, an arakkoa in the Haal'eshi camp, drops Avruu's Orb. Right-click it to start a quest
    .collect 23580,1,9418,1 --Avruu's Orb (1)
    .accept 9418 >> Accept Avruu's Orb
step
    .goto Hellfire Peninsula,25.97,78.32,50,0
    .goto Hellfire Peninsula,28.8,79.5,50,0
    .goto Hellfire Peninsula,25.72,76.44
    >>Ride south into the Haal'eshi arakkoa camps. Kill Windwalkers and Talonguards, and Avruu who stands in the western camp
    .complete 9417,1 --Kill Haal'eshi Windwalker (x4)
    .complete 9417,2 --Kill Haal'eshi Talonguard (x6)
step
    #label aeranas
    .isOnQuest 9418
    .goto Hellfire Peninsula,28.93,81.46
    >>Click the Haal'eshi Altar at the south end of the camps. Defeat Aeranas, then talk to him when he yields
    .turnin 9418 >> Turn in Avruu's Orb
    .skipgossip
step
    .goto Hellfire Peninsula,23.89,72.17
.target Gremni Longbeard
>>Talk to |cRXP_FRIENDLY_Gremni Longbeard|r
    .turnin 9417 >> Turn in The Arakkoa Threat
    .turnin 9385 >> Turn in Rampaging Ravagers
step
    .maxlevel 67
    .goto Hellfire Peninsula,15.59,58.74
    >>Ride north-west to the Ruins of Sha'naar. Everything from here on skips itself once you are 68, Northrend pays far better
.target Akoru the Firecaller
>>Talk to |cRXP_FRIENDLY_Akoru the Firecaller|r
    .accept 10403 >> Accept Naladu
step
    .isOnQuest 10403
    .goto Hellfire Peninsula,16.27,65.09
.target Naladu
>>Talk to |cRXP_FRIENDLY_Naladu|r
    .turnin 10403 >> Turn in Naladu
    .accept 10367 >> Accept A Traitor Among Us
step
    .isOnQuest 10367
    .goto Hellfire Peninsula,14.34,63.50
    >>Open the Metal Coffer in the hut for the Sha'naar Key
    .complete 10367,1 --Collect Sha'naar Key (x1)
step
    .isOnQuest 10367
    .goto Hellfire Peninsula,16.27,65.09
.target Naladu
>>Talk to |cRXP_FRIENDLY_Naladu|r
    .turnin 10367 >> Turn in A Traitor Among Us
    .accept 10368 >> Accept The Dreghood Elders
step
    .isOnQuest 10368
    .goto Hellfire Peninsula,13.13,61.04,-1
    .goto Hellfire Peninsula,15.59,58.75,-1
    .goto Hellfire Peninsula,13.01,58.42,-1
    >>Use the key on the three chained Dreghood elders around the ruins, they turn on you when freed
    .complete 10368,1 --Free Morod the Windstirrer
    .complete 10368,3 --Free Aylaan the Waterwaker
    .complete 10368,2 --Free Akoru the Firecaller
step
    .isOnQuest 10368
    .goto Hellfire Peninsula,16.27,65.09
.target Naladu
>>Talk to |cRXP_FRIENDLY_Naladu|r
    .turnin 10368 >> Turn in The Dreghood Elders
    .accept 10369 >> Accept Arzeth's Demise
step
    .isOnQuest 10369
    .goto Hellfire Peninsula,14.29,62.38,50,0
    .goto Hellfire Peninsula,14.35,56.99
    .use 29513 >> Arzeth the Merciless stands at the north end of the ruins. Use the Staff of the Dreghood Elders on him to turn him into Arzeth the Powerless, then kill him
    .complete 10369,1 --Kill Arzeth the Powerless (x1)
step
    .isOnQuest 10369
    .goto Hellfire Peninsula,16.27,65.09
.target Naladu
>>Talk to |cRXP_FRIENDLY_Naladu|r
    .turnin 10369 >> Turn in Arzeth's Demise
step
    .maxlevel 67
    .goto Hellfire Peninsula,14.90,64.00,50,0
    .goto Hellfire Peninsula,16.0,58.0,50,0
    .goto Hellfire Peninsula,14.5,59.5
    >>Kill Illidari Taskmasters in the ruins, and loot ten Sha'naar Relics from the Dreghood mobs and the piles on the ground
    .complete 9399,1 --Kill Illidari Taskmaster (x4)
    .complete 9430,1 --Collect Sha'naar Relic (x10)
step
    .goto Hellfire Peninsula,16.04,52.15
    >>Ride north to the Cenarion Post
.target Amythiel Mistwalker
>>Talk to |cRXP_FRIENDLY_Amythiel Mistwalker|r
    .accept 9912 >> Accept The Cenarion Expedition
step
    .goto Hellfire Peninsula,15.94,52.17
.target Mahuram Stouthoof
>>Talk to |cRXP_FRIENDLY_Mahuram Stouthoof|r
    .accept 10159 >> Accept Keep Thornfang Hill Clear!
step
    .goto Hellfire Peninsula,15.70,52.09
.target Thiah Redmane
>>Talk to |cRXP_FRIENDLY_Thiah Redmane|r
    .turnin -9373 >> Turn in Missing Missive
    .accept 9372 >> Accept Demonic Contamination
step
    .maxlevel 67
    .goto Hellfire Peninsula,12.15,46.50,50,0
    .goto Hellfire Peninsula,9.13,49.47,50,0
    .goto Hellfire Peninsula,11.60,55.18,50,0
    .goto Hellfire Peninsula,7.41,49.74
    >>Thornfang Hill is just west of the post. Kill eight Ravagers and eight Venomspitters
    .complete 10159,1 --Kill Thornfang Ravager (x8)
    .complete 10159,2 --Kill Thornfang Venomspitter (x8)
step
    .isQuestComplete 10159
    .goto Hellfire Peninsula,15.94,52.17
.target Mahuram Stouthoof
>>Talk to |cRXP_FRIENDLY_Mahuram Stouthoof|r
    .turnin 10159 >> Turn in Keep Thornfang Hill Clear!
step
    .maxlevel 67
    .goto Hellfire Peninsula,24.99,51.58,60,0
    .goto Hellfire Peninsula,22.0,54.0
    >>Ride east towards the temple. Kill Hulking Helboars in the valley south of the temple for six blood samples
    .complete 9372,1 --Collect Helboar Blood Sample (x6)
step
    #completewith next
    .hs >> Hearth to the Temple of Telhamat
step
    .goto Hellfire Peninsula,23.42,36.54
.target Amaan the Wise
>>Talk to |cRXP_FRIENDLY_Amaan the Wise|r
    .turnin 9427 >> Turn in Cleansing the Waters
step
    .isQuestComplete 9430
    .goto Hellfire Peninsula,23.42,36.54
.target Amaan the Wise
>>Talk to |cRXP_FRIENDLY_Amaan the Wise|r
    .turnin 9430 >> Turn in Sha'naar Relics
    .accept 9545 >> Accept The Seer's Relic
step
    .goto Hellfire Peninsula,23.36,41.29,50,0
    .goto Hellfire Peninsula,23.36,37.45
.target Scout Vanura
>>Talk to |cRXP_FRIENDLY_Scout Vanura|r on the central ramp
    .turnin 9398 >> Turn in Deadly Predators
step
    .isQuestComplete 9399
    .goto Hellfire Peninsula,23.09,40.22
.target Ikan
>>Talk to |cRXP_FRIENDLY_Ikan|r
    .turnin 9399 >> Turn in Cruel Taskmasters
step
    #timer The Seer's Relic roleplay
    .isOnQuest 9545
    .goto Hellfire Peninsula,26.90,37.43
    .use 23645 >> Use the Seer's Relic on Sedai's Corpse east of the temple. You do not need to wait for the vision to finish
    .timer 21,The Seer's Relic roleplay
    .complete 9545,1 --Witness Sedai's vision
step
    .isOnQuest 9545
    .goto Hellfire Peninsula,23.42,36.54
.target Amaan the Wise
>>Talk to |cRXP_FRIENDLY_Amaan the Wise|r
    .turnin 9545 >> Turn in The Seer's Relic
step
    .goto Hellfire Peninsula,25.193,37.230
    .fly Honor Hold >> Fly to Honor Hold
step
    .goto Hellfire Peninsula,56.69,66.52
.target Warp-Scryer Kryv
>>Talk to |cRXP_FRIENDLY_Warp-Scryer Kryv|r
    .turnin 10047 >> Turn in The Path of Glory
    .turnin 10399 >> Turn in The Heart of Darkness
    .accept 10093 >> Accept The Temple of Telhamat
step
    .goto Hellfire Peninsula,51.12,60.30
.target Dumphry
>>Talk to |cRXP_FRIENDLY_Dumphry|r
    .turnin 10078 >> Turn in Laying Waste to the Unwanted
step
    .maxlevel 67
    .goto Hellfire Peninsula,50.07,83.29,50,0
    .goto Hellfire Peninsula,46.25,83.22
    .use 23417 >> Ride south past the zeppelin crash to the voidwalkers. Fight an Uncontrolled Voidwalker down to 20% health and use the Sanctified Crystal on it
    .complete 9383,1 --Collect Glowing Sanctified Crystal (x1)
step
    #completewith next
    .hs >> Hearth to the Temple of Telhamat
step
    .goto Hellfire Peninsula,23.42,36.54
.target Amaan the Wise
>>Talk to |cRXP_FRIENDLY_Amaan the Wise|r
    .turnin 10093 >> Turn in The Temple of Telhamat
step
    .isQuestComplete 9383
    .goto Hellfire Peninsula,23.21,36.66
.target Elsaana
>>Talk to |cRXP_FRIENDLY_Elsaana|r
    .turnin 9383 >> Turn in An Ambitious Plan
step
    .isQuestComplete 9372
    .goto Hellfire Peninsula,15.70,52.09
    >>Ride west to the Cenarion Post
.target Thiah Redmane
>>Talk to |cRXP_FRIENDLY_Thiah Redmane|r
    .turnin 9372 >> Turn in Demonic Contamination
    .accept 10255 >> Accept Testing the Antidote
step
    .maxlevel 67
    .isOnQuest 10255
    .goto Hellfire Peninsula,18.40,52.73,60,0
    .goto Hellfire Peninsula,22.17,56.14
    .use 23337 >> Use the Cenarion Antidote on a Hulking Helboar south-east of the post. It turns into Dreadtusk, kill it
    .complete 10255,1 --Kill Dreadtusk (x1)
step
    .isQuestComplete 10255
    .goto Hellfire Peninsula,15.70,52.09
.target Thiah Redmane
>>Talk to |cRXP_FRIENDLY_Thiah Redmane|r
    .turnin 10255 >> Turn in Testing the Antidote
step
    >>Clean up before leaving Hellfire. These only show if the quest is still in your log
    .abandon 9373 >> Abandon Missing Missive
    .abandon 9418 >> Abandon Avruu's Orb
    .abandon 10159 >> Abandon Keep Thornfang Hill Clear!
    .abandon 9372 >> Abandon Demonic Contamination
    .abandon 10255 >> Abandon Testing the Antidote
    .abandon 9383 >> Abandon An Ambitious Plan
    .abandon 10057 >> Abandon Looking to the Leadership
    .abandon 10403 >> Abandon Naladu
    .abandon 10367 >> Abandon A Traitor Among Us
    .abandon 10368 >> Abandon The Dreghood Elders
    .abandon 10369 >> Abandon Arzeth's Demise
    .abandon 9399 >> Abandon Cruel Taskmasters
    .abandon 9430 >> Abandon Sha'naar Relics
    .abandon 9545 >> Abandon The Seer's Relic
step
    .goto Hellfire Peninsula,12.15,46.50,50,0
    .goto Hellfire Peninsula,9.13,49.47
    .xp 68 >> Northrend needs level 68. If you are still short, kill Thornfang mobs west of the Cenarion Post until you ding. Skips itself once you are 68
step
    #sticky
    #completewith next
    +Hellfire is done around 68 and Northrend needs 68. Ride west out of the Cenarion Post into Zangarmarsh, south through Terokkar Forest to Shattrath City (about ten minutes), take the Stormwind portal there, train, and board the Borean Tundra boat in Stormwind Harbor. Druids can Teleport: Moonglade to train and then fly Nighthaven to Auberdine for the Stormwind Harbor boat instead (on 3.3.5 it leaves from Auberdine's southern pier, not Rut'theran)
step
    .goto Hellfire Peninsula,10.0,60.0,80,0
    .goto Zangarmarsh,78.4,62.02
    >>Ride west along the road into Zangarmarsh to Cenarion Refuge
.target Ysiel Windsinger
>>Talk to |cRXP_FRIENDLY_Ysiel Windsinger|r
    .turnin -9912 >> Turn in The Cenarion Expedition
step
    .abandon 9912 >> Abandon The Cenarion Expedition
step
    .goto Zangarmarsh,80.0,63.0,80,0
    .goto Terokkar Forest,49.0,20.0,80,0
    .goto Shattrath City,64.061,41.112
    .zone Shattrath City >> Follow the road south from Cenarion Refuge into Terokkar Forest and on to Shattrath City
step
    .goto Shattrath City,64.061,41.112
    .fp Shattrath >> Get the Shattrath City flight path
step
    .goto Shattrath City,56.318,36.971
    .zone Stormwind City >> Take the Stormwind portal on the Terrace of Light
step << Warrior
    .goto StormwindClassic,76.08,50.14,15,0
    .goto StormwindClassic,78.68,45.79
    .trainer >> Train your class spells
step << Rogue
    .goto StormwindClassic,74.65,52.83
    .trainer >> Train your class spells
step << Hunter
    .goto StormwindClassic,61.609,15.269
    .trainer >> Train your class spells
step << Priest
    .goto StormwindClassic,38.54,26.86
    .trainer >> Train your class spells
step << Druid
    .goto StormwindClassic,20.898,55.491
    .trainer >> Train your class spells
step
    .goto Stormwind City,18.2,25.5
    .zone Borean Tundra >> Take the boat from the north pier of Stormwind Harbor to Valiance Keep in Borean Tundra
]])

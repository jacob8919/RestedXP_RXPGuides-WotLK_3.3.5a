-- RestedXP 7x route: Dustwallow Marsh (WotLK 3.3.5a, Warmane 7x). Arrive at Theramore
-- around 38 with a mount and the Theramore flight path and hearthstone from the Ashenvale
-- chapter. Three loops: the Theramore island chains, a north sweep (Sentry Point, Witch
-- Hill, Renn McGill) ending with a hearth, then Tabetha's farm, the
-- zeppelin crash and Mudsprocket (Bloodfen, Den of Flame, Stonemaul Hold, Smolderwing).
-- The Shady Rest / Captain Vimes deserter chain, the Blackhoof Village raptor quests and
-- Stinky's escort are dropped: their payoff arrives after the level curve has decayed them.
local faction = UnitFactionGroup("player")
if faction == "Horde" then return end

RXPGuides.RegisterGuide([[
#wotlk
<< Alliance
#name 38-47 Dustwallow (7x)
#version 1
#group RestedXP Alliance 7x
#next 48-54 Tanaris (7x)
step
    #sticky
    #completewith next
    +Dustwallow at 7x: you arrive around 38 and leave around 47. Three loops from Theramore: the island, the north sweep to Blackhoof Village, then Tabetha's farm and Mudsprocket. Theramore only trains Warriors (Mages and Paladins too, not Night Elf classes); Druids get Dire Bear Form at 40 through Teleport: Moonglade at the end of the chapter, and there is an optional Darnassus trip at the end for the other classes and the 100% mount
step
    .goto Dustwallow Marsh,66.587,45.223
    >>Skips itself if you are already bound here
    .home >> Set your Hearthstone to Theramore
    .bindlocation 513
step
    .goto Dustwallow Marsh,68.32,51.01
.target Calia Hastings
>>Talk to |cRXP_FRIENDLY_Calia Hastings|r
    .accept 11126 >> Accept Traitors Among Us
step
    #sticky
    #label agitators
    >>Talk to the Deserter Agitators standing around Theramore as you go. There is a short delay before you get credit, and they turn hostile, so kill them
    .complete 11126,1 --Kill Deserter Agitator (x5)
    .skipgossip
step
    .goto Dustwallow Marsh,68.257,51.818
.target Sergeant Amelyn
>>Talk to |cRXP_FRIENDLY_Sergeant Amelyn|r
    .accept 11191 >> Accept This Old Lighthouse
step
    .goto Dustwallow Marsh,66.156,46.067
.target Guard Byron
>>Talk to |cRXP_FRIENDLY_Guard Byron|r at the west gate
    .accept 1282 >> Accept They Call Him Smiling Jim
step
    .goto Dustwallow Marsh,68.212,48.620
    >>Upstairs in Foothold Citadel
.target Captain Garran Vimes
>>Talk to |cRXP_FRIENDLY_Captain Garran Vimes|r
    .turnin 1282 >> Turn in They Call Him Smiling Jim
step
    .goto Dustwallow Marsh,72.109,47.053
    >>Babs is on the eastern tip of the island
.target Babs Fizzletorque
>>Talk to |cRXP_FRIENDLY_Babs Fizzletorque|r
    .turnin 11191 >> Turn in This Old Lighthouse
    .accept 11192 >> Accept Thresher Oil
step
    .goto Dustwallow Marsh,73.8,54.6,70,0
    .goto Dustwallow Marsh,70.6,53.6,70,0
    .goto Dustwallow Marsh,69.8,57.8,70,0
    .goto Dustwallow Marsh,72.8,57.2
    >>Kill Young Murk Threshers in the shallows south of Theramore for four Thresher Oil. There are Deserter Agitators on the beach too
    .complete 11192,1 --Collect Thresher Oil (x4)
step
    #requires agitators
    .goto Dustwallow Marsh,68.32,51.01
.target Calia Hastings
>>Talk to |cRXP_FRIENDLY_Calia Hastings|r
    .turnin 11126 >> Turn in Traitors Among Us
    .accept 11128 >> Accept Propaganda War
step
    .goto Dustwallow Marsh,67.951,58.740
    >>Loot the Deserter Propaganda on the middle floor of the ship south of the docks
    .complete 11128,1 --Collect Deserter Propaganda (x1)
step
    #timer Propaganda War roleplay
    .goto Dustwallow Marsh,68.32,51.01
    >>Wait out the short roleplay before she offers the next quest
.target Calia Hastings
>>Talk to |cRXP_FRIENDLY_Calia Hastings|r
    .turnin 11128 >> Turn in Propaganda War
    .timer 12,Propaganda War roleplay
    .accept 11133 >> Accept Discrediting the Deserters
step
    .goto Dustwallow Marsh,67.38,50.50,60,0
    .goto Dustwallow Marsh,66.73,46.18,60,0
    .goto Dustwallow Marsh,64.51,49.35,60,0
    .goto Dustwallow Marsh,67.38,50.50
    >>Talk to six Theramore Guards around the town and hand each one the altered leaflets
    .complete 11133,1 --Theramore Guard (x6)
    .skipgossip
step
    .goto Dustwallow Marsh,68.32,51.01
.target Calia Hastings
>>Talk to |cRXP_FRIENDLY_Calia Hastings|r
    .turnin 11133 >> Turn in Discrediting the Deserters
    .accept 11134 >> Accept The End of the Deserters
step
    .goto Dustwallow Marsh,76.27,56.99
    >>Ride east across the shallows to the small island with the lighthouse and kill Gavis Greyshield
    .complete 11134,1 --Kill Gavis Greyshield (x1)
step
    .goto Dustwallow Marsh,72.109,47.053
.target Babs Fizzletorque
>>Talk to |cRXP_FRIENDLY_Babs Fizzletorque|r
    .turnin 11192 >> Turn in Thresher Oil
    .accept 11193 >> Accept Dastardly Denizens of the Deep
step
    .goto Dustwallow Marsh,69.242,51.885
.target "Dirty" Michael Crowe
>>Talk to |cRXP_FRIENDLY_"Dirty" Michael Crowe|r on the docks
    .turnin 11193 >> Turn in Dastardly Denizens of the Deep
    .accept 11194 >> Accept Is it Real?
step
    .goto Dustwallow Marsh,68.32,51.01
.target Calia Hastings
>>Talk to |cRXP_FRIENDLY_Calia Hastings|r
    .turnin 11134 >> Turn in The End of the Deserters
step
    .goto Dustwallow Marsh,68.257,51.818
.target Sergeant Amelyn
>>Talk to |cRXP_FRIENDLY_Sergeant Amelyn|r
    .accept 11177 >> Accept The Hermit of Swamplight Manor
step
    .goto Dustwallow Marsh,58.762,60.171
    >>Ride out of the west gate and south along the shore, then swim to Nat Pagle's island
.target Nat Pagle
>>Talk to |cRXP_FRIENDLY_Nat Pagle|r
    .turnin 11194 >> Turn in Is it Real?
    .accept 11209 >> Accept Nat's Bargain
step
    .goto Dustwallow Marsh,56.349,61.819
    .use 33166 >> Swim out a little west of the island and use Pagle's Fish Paste, then kill the Lurking Shark it attracts
    .complete 11209,1 --Kill Lurking Shark (x1)
step
    .goto Dustwallow Marsh,58.764,60.171
.target Nat Pagle
>>Talk to |cRXP_FRIENDLY_Nat Pagle|r
    .turnin 11209 >> Turn in Nat's Bargain
    .accept 11210 >> Accept Oh, It's Real
step
    .goto Dustwallow Marsh,69.613,51.771
    >>Ride back to the Theramore docks
.target Major Mills
>>Talk to |cRXP_FRIENDLY_Major Mills|r
    .turnin 11210 >> Turn in Oh, It's Real
    .accept 11198 >> Accept Take Down Tethyr!
step
    .goto Dustwallow Marsh,69.681,51.734,5,0
    .goto Dustwallow Marsh,69.834,53.661,5,0
    .goto Dustwallow Marsh,70.831,51.852,5,0
    .goto Dustwallow Marsh,69.681,51.734
    >>Click a Cove Cannon on the docks and shoot Tethyr whenever he surfaces. Swap cannons if he moves out of range
    .complete 11198,1 --Kill Tethyr
step
    .goto Dustwallow Marsh,69.613,51.765
.target Major Mills
>>Talk to |cRXP_FRIENDLY_Major Mills|r
    .turnin 11198 >> Turn in Take Down Tethyr!
step
    #sticky
    #completewith next
    +Loop two: north sweep. Sentry Point, Witch Hill, then Renn McGill on the north-east coast, and hearth back from there. Blackhoof Village, Stinky's escort and the Shady Rest deserter chain are skipped on purpose: by the time you would reach them they pay 20-80%
step
    .goto Dustwallow Marsh,65.070,47.118
.target Lieutenant Aden
>>Talk to |cRXP_FRIENDLY_Lieutenant Aden|r inside the west gate
    .accept 11136 >> Accept A Disturbing Development
step
    .goto Dustwallow Marsh,59.658,41.106
    >>Ride west along the road to the Sentry Point tower
.target Captain Wymor
>>Talk to |cRXP_FRIENDLY_Captain Wymor|r
    .turnin 11136 >> Turn in A Disturbing Development
    .accept 11137 >> Accept Defias in Dustwallow?
step
    .goto Dustwallow Marsh,64.06,28.67,50,0
    .goto Dustwallow Marsh,64.69,26.98
    >>Ride north to the small island off the coast. Garn Mathers patrols it with Defias Rummagers, loot his Defias Orders
    .unitscan Garn Mathers
    .complete 11137,1 --Collect Defias Orders (x1)
step
    .goto Dustwallow Marsh,59.658,41.106
.target Captain Wymor
>>Talk to |cRXP_FRIENDLY_Captain Wymor|r
    .turnin 11137 >> Turn in Defias in Dustwallow?
    .accept 11138 >> Accept Renn McGill
step
    .goto Dustwallow Marsh,55.435,26.271
    >>Ride north-west to Swamplight Manor on Witch Hill
.target "Swamp Eye" Jarl
>>Talk to |cRXP_FRIENDLY_"Swamp Eye" Jarl|r
    .turnin 11177 >> Turn in The Hermit of Swamplight Manor
    .accept 1218 >> Accept Marsh Frog Legs
step
    .goto Dustwallow Marsh,55.583,26.146
.target Mordant Grimsby
>>Talk to |cRXP_FRIENDLY_Mordant Grimsby|r
    .accept 11180 >> Accept What's Haunting Witch Hill?
step
    .goto Dustwallow Marsh,56.8,29.4,65,0
    .goto Dustwallow Marsh,57.8,24.8,65,0
    .goto Dustwallow Marsh,56.2,22.8,65,0
    .goto Dustwallow Marsh,53.8,22.4,65,0
    .goto Dustwallow Marsh,52.6,29.4
    >>Kill Risen Husks and Risen Spirits around the hill, the Restless Apparitions they release count. Kill Giant Marsh Frogs for ten legs as you go
    .complete 11180,1 --Kill Restless Apparition (x10)
    .complete 1218,1 --Collect Marsh Frog Leg (x10)
step
    .goto Dustwallow Marsh,55.435,26.271
.target "Swamp Eye" Jarl
>>Talk to |cRXP_FRIENDLY_"Swamp Eye" Jarl|r
    .turnin 1218 >> Turn in Marsh Frog Legs
step
    .goto Dustwallow Marsh,55.583,26.146
.target Mordant Grimsby
>>Talk to |cRXP_FRIENDLY_Mordant Grimsby|r
    .turnin 11180 >> Turn in What's Haunting Witch Hill?
    .accept 11181 >> Accept The Witch's Bane
step
    .goto Dustwallow Marsh,55.2,27.7,50,0
    .goto Dustwallow Marsh,55.0,25.7,50,0
    .goto Dustwallow Marsh,54.3,23.5,50,0
    .goto Dustwallow Marsh,53.7,21.5,50,0
    .goto Dustwallow Marsh,50.5,22.5,50,0
    .goto Dustwallow Marsh,50.0,21.0,50,0
    .goto Dustwallow Marsh,51.7,16.5
    >>Loot nine Witchbane plants from the ground around the hill. The Risen also drop them
    .complete 11181,1 --Collect Witchbane (x9)
step
    .goto Dustwallow Marsh,55.583,26.146
.target Mordant Grimsby
>>Talk to |cRXP_FRIENDLY_Mordant Grimsby|r
    .turnin 11181 >> Turn in The Witch's Bane
    .accept 11183 >> Accept Cleansing Witch Hill
step
    #timer Cleansing Witch Hill roleplay
    .goto Dustwallow Marsh,55.178,26.689
    .use 33113 >> Use the Witchbane Torch at the end of the dock below the manor. Zelfrax arrives after about 30 seconds, kill him
    .timer 32,Cleansing Witch Hill roleplay
    .complete 11183,1 --Kill Zelfrax (x1)
step
    .goto Dustwallow Marsh,55.583,26.146
.target Mordant Grimsby
>>Talk to |cRXP_FRIENDLY_Mordant Grimsby|r
    .turnin 11183 >> Turn in Cleansing Witch Hill
step
    .goto Dustwallow Marsh,63.743,17.042
    >>Ride north-east to Tidefury Cove
.target Renn McGill
>>Talk to |cRXP_FRIENDLY_Renn McGill|r
    .turnin 11138 >> Turn in Renn McGill
    .accept 11139 >> Accept Secondhand Diving Gear
step
    .goto Dustwallow Marsh,62.326,18.872,10,0
    .goto Dustwallow Marsh,61.63,18.15
    >>Loot the Tool Kit and the Damaged Diving Gear from the ground around the Defias camp. Both have several spawn points between the tents and the wrecked boat to the west, the Rummagers also drop the Tool Kit
    .complete 11139,2 --Collect Tool Kit (x1)
    .complete 11139,1 --Collect Damaged Diving Gear (x1)
step
    .goto Dustwallow Marsh,63.743,17.042
.target Renn McGill
>>Talk to |cRXP_FRIENDLY_Renn McGill|r
    .turnin 11139 >> Turn in Secondhand Diving Gear
    .accept 11140 >> Accept Recover the Cargo!
step
    #completewith next
    .use 33045 >> Open Renn's Supplies in your bags for the Salvage Kit and the Repaired Diving Gear
    .collect 33044,1,11140,1 --Salvage Kit (1)
    .collect 33040,1,11140,1 --Repaired Diving Gear (1)
step
    .goto Dustwallow Marsh,63.44,15.14,30,0
    .goto Dustwallow Marsh,64.02,13.42,30,0
    .goto Dustwallow Marsh,64.93,12.95,30,0
    .goto Dustwallow Marsh,66.74,13.73
    .use 33044 >> Swim out to the Shipwreck Debris north of the camp and use the Salvage Kit at each one for six strongboxes
    .complete 11140,1 --Collect Salvaged Strongbox (x6)
step
    .goto Dustwallow Marsh,63.743,17.042
.target Renn McGill
>>Talk to |cRXP_FRIENDLY_Renn McGill|r
    .turnin 11140 >> Turn in Recover the Cargo!
    .accept 11141 >> Accept Jaina Must Know
step
    #completewith next
    .hs >> Hearth to Theramore
step
    .goto Dustwallow Marsh,66.274,49.025
    >>Jaina is at the top of the mage tower
.target Lady Jaina Proudmoore
>>Talk to |cRXP_FRIENDLY_Lady Jaina Proudmoore|r
    .turnin 11141 >> Turn in Jaina Must Know
    .accept 11142 >> Accept Survey Alcaz Island
step
    #timer Survey Alcaz Island roleplay
    .goto Dustwallow Marsh,67.328,51.147
    .gossip 23704,0 >> Talk to Cassa Crimsonwing by the flight master and take the gryphon ride over Alcaz Island. It lasts a little over two minutes
    .timer 133,Survey Alcaz Island roleplay
    .skipgossip 1
.target Cassa Crimsonwing
step
    >>Wait out the flight, the quest completes when the gryphon lands
    .complete 11142,1 --Survey Alcaz Island
step
    .goto Dustwallow Marsh,66.274,49.025
.target Lady Jaina Proudmoore
>>Talk to |cRXP_FRIENDLY_Lady Jaina Proudmoore|r
    .turnin 11142 >> Turn in Survey Alcaz Island
    >>After the turn-in Jaina starts a scripted speech ("Perhaps I should explain...") and stops offering quests until it ends. Wait about a minute, then talk to her again
    .accept 11222 >> Accept Proof of Treachery
step
    #sticky
    #completewith next
    +Keep Proof of Treachery in your quest log and do not turn it in: while it is there, talking to Jaina teleports you to Stormwind for free. The route uses that at 58 for the trip to Outland
step
    .goto Dustwallow Marsh,65.070,47.118
.target Lieutenant Aden
>>Talk to |cRXP_FRIENDLY_Lieutenant Aden|r
    .accept 11214 >> Accept Mission to Mudsprocket
step
    #sticky
    #completewith next
    +Mission to Mudsprocket, Help for Mudsprocket (Tabetha) and Delivery for Drazzit (Moxie) are three breadcrumbs to the same goblin and Warmane only lets you hold one, so the route takes only this one. Loop three: west to the zeppelin crash and Tabetha's farm, then Mudsprocket and the Wyrmbog. This loop ends at Mudsprocket, then everyone hearths back (Druids through Moonglade for Dire Bear Form)
step
    .goto Dustwallow Marsh,66.156,46.067
.target Guard Byron
>>Talk to |cRXP_FRIENDLY_Guard Byron|r at the west gate
    .accept 11212 >> Accept Tabetha's Farm
step
    .goto Dustwallow Marsh,53.573,56.913
    >>Ride west along the road, then south to the zeppelin crash site
.target Moxie Steelgrille
>>Talk to |cRXP_FRIENDLY_Moxie Steelgrille|r
    .accept 11207 >> Accept Secure the Cargo!
step
    #sticky
    #label cargo
    >>Loot the Zeppelin Cargo crates lying around the crash site as you go
    .complete 11207,1 --Collect Zeppelin Cargo (x8)
step
    .goto Dustwallow Marsh,46.056,57.093
    >>Ride west to Tabetha's farm
.target Tabetha
>>Talk to |cRXP_FRIENDLY_Tabetha|r
    .turnin 11212 >> Turn in Tabetha's Farm
step
    .goto Dustwallow Marsh,46.051,57.236
.target Apprentice Garion
>>Talk to |cRXP_FRIENDLY_Apprentice Garion|r
    .accept 11169 >> Accept The Grimtotem Weapon
    .accept 11173 >> Accept The Reagent Thief
step
    .goto Dustwallow Marsh,46.099,57.436
.target Apprentice Morlann
>>Talk to |cRXP_FRIENDLY_Apprentice Morlann|r
    .accept 11172 >> Accept The Zeppelin Crash
    .accept 11156 >> Accept Direhorn Raiders
step
    .goto Dustwallow Marsh,53.573,56.913
    >>Back east to the crash site
.target Moxie Steelgrille
>>Talk to |cRXP_FRIENDLY_Moxie Steelgrille|r
    .turnin 11172 >> Turn in The Zeppelin Crash
    .accept 11174 >> Accept Corrosion Prevention
step
    .goto Dustwallow Marsh,54.0,57.6,70,0
    .goto Dustwallow Marsh,51.6,59.0,70,0
    .goto Dustwallow Marsh,49.6,55.2,70,0
    .goto Dustwallow Marsh,51.4,52.6,70,0
    .goto Dustwallow Marsh,54.4,54.4
    .use 33108 >> Stand next to a glowing Power Core Fragment so you get the Energized buff, then channel the Ooze Buster on Acidic and Bubbling Swamp Oozes nearby. Ten oozes
    .complete 11174,1 --Dissolve Swamp Ooze (x10)
step
    #requires cargo
    .goto Dustwallow Marsh,53.573,56.916
.target Moxie Steelgrille
>>Talk to |cRXP_FRIENDLY_Moxie Steelgrille|r
    .turnin 11174 >> Turn in Corrosion Prevention
    .turnin 11207 >> Turn in Secure the Cargo!
step
    #sticky
    #completewith direhornDone
    .goto Dustwallow Marsh,47.220,46.588
    >>Apothecary Cylla stands by the north tent of Direhorn Post. Kill her, loot the Sealed Letter and right-click it to start a quest
    .collect 33114,1,11185,1 --Sealed Letter (1)
    .accept 11185 >> Accept The Apothecary's Letter
step
    .goto Dustwallow Marsh,46.23,46.36,60,0
    .goto Dustwallow Marsh,47.36,47.08,60,0
    .goto Dustwallow Marsh,46.35,49.88
    >>Ride north to Direhorn Post and kill twelve Grimtotem Destroyers
    .complete 11156,1 --Kill Grimtotem Destroyer (x12)
step
    #label direhornDone
    .goto Dustwallow Marsh,46.099,57.436
    >>Back south to the farm
.target Apprentice Morlann
>>Talk to |cRXP_FRIENDLY_Apprentice Morlann|r
    .turnin 11156 >> Turn in Direhorn Raiders
step
    .goto Dustwallow Marsh,45.468,57.771
.target Andello Porter
>>Talk to |cRXP_FRIENDLY_Andello Porter|r
    .turnin -11185 >> Turn in The Apothecary's Letter
step
    .goto Dustwallow Marsh,43.78,57.27,70,0
    .goto Dustwallow Marsh,42.59,53.21,70,0
    .goto Dustwallow Marsh,41.80,56.12,70,0
    .goto Dustwallow Marsh,40.23,58.67
    .use 33101 >> Ride west of the farm. Drop the Captured Totem next to Drywallow Daggermaws and Mottled Drywallow Crocolisks and kill them while it channels into them. Ten kills
    .complete 11169,1 --Totem-marked kills (x10)
step
    .goto Dustwallow Marsh,40.46,53.48,70,0
    .goto Dustwallow Marsh,37.6,54.8,70,0
    .goto Dustwallow Marsh,36.9,52.0,70,0
    .goto Dustwallow Marsh,38.2,55.7
    >>Kill Darkfang Creepers and Noxious Shredders around Lost Point for six Marsh Venom
    .complete 11173,1 --Collect Marsh Venom (x6)
step
    .goto Dustwallow Marsh,46.051,57.236
.target Apprentice Garion
>>Talk to |cRXP_FRIENDLY_Apprentice Garion|r
    .turnin 11169 >> Turn in The Grimtotem Weapon
    .turnin 11173 >> Turn in The Reagent Thief
step
    .goto Dustwallow Marsh,42.823,72.431
    >>Ride south-west along the road to Mudsprocket
    .fp Mudsprocket >> Get the Mudsprocket flight path
step
    .goto Dustwallow Marsh,42.33,72.925
.target Drazzit Dripvalve
>>Talk to |cRXP_FRIENDLY_Drazzit Dripvalve|r
    .turnin 11214 >> Turn in Mission to Mudsprocket
step
    .goto Dustwallow Marsh,41.752,73.128
    >>Click the Wanted Poster
    .accept 11184 >> Accept WANTED: Goreclaw the Ravenous
step
    .goto Dustwallow Marsh,41.857,73.968
.target Brogg
>>Talk to |cRXP_FRIENDLY_Brogg|r
    .accept 11158 >> Accept Bloodfen Feathers
step
    .goto Dustwallow Marsh,41.537,72.985
.target Gizzix Grimegurgle
>>Talk to |cRXP_FRIENDLY_Gizzix Grimegurgle|r
    .accept 11217 >> Accept Catch a Dragon by the Tail
step
    #sticky
    #completewith wyrmtailLoop
    >>Loot Wyrmtail plants (small dark plants on the ground) whenever you see them south and east of Mudsprocket, the Daggermaws drop them too
    .complete 11217,1 --Collect Wyrmtail (x8)
step
    .goto Dustwallow Marsh,31.17,65.92,50,0
    .goto Dustwallow Marsh,32.62,64.51,50,0
    .goto Dustwallow Marsh,34.33,65.72
    >>Ride west into the Bloodfen Burrow. Kill Goreclaw the Ravenous, he patrols around the raptor nests, and Bloodfen Razormaws and Lashtails for five feathers
    .unitscan Goreclaw the Ravenous
    .complete 11184,1 --Kill Goreclaw the Ravenous (x1)
    .complete 11158,1 --Collect Bloodfen Feather (x5)
step
    .goto Dustwallow Marsh,42.33,72.925
    >>Back to Mudsprocket
.target Drazzit Dripvalve
>>Talk to |cRXP_FRIENDLY_Drazzit Dripvalve|r
    .turnin 11184 >> Turn in WANTED: Goreclaw the Ravenous
step
    .goto Dustwallow Marsh,41.857,73.968
.target Brogg
>>Talk to |cRXP_FRIENDLY_Brogg|r
    .turnin 11158 >> Turn in Bloodfen Feathers
step
    .goto Dustwallow Marsh,41.857,73.968
.target Brogg
>>Talk to |cRXP_FRIENDLY_Brogg|r
    .accept 11160 >> Accept Banner of the Stonemaul
    .accept 11161 >> Accept The Essence of Enmity
step
    .goto Dustwallow Marsh,38.50,65.85,30,0
    .goto Dustwallow Marsh,39.93,64.69,40,0
    .goto Dustwallow Marsh,38.113,69.449
    .use 33088 >> Enter the Den of Flame north-west of town. Kill Firemane Scouts, Scalebanes and Ash Tails and use Brogg's Totem on their corpses for ten essences. The Stonemaul Banner is on the ground at the back of the cave
    .complete 11161,1 --Collect Black Dragonkin Essence (x10)
    .complete 11160,1 --Collect Stonemaul Banner (x1)
step
    .goto Dustwallow Marsh,41.857,73.968
.target Brogg
>>Talk to |cRXP_FRIENDLY_Brogg|r
    .turnin 11160 >> Turn in Banner of the Stonemaul
    .turnin 11161 >> Turn in The Essence of Enmity
    .accept 11159 >> Accept Spirits of Stonemaul Hold
step
    .goto Dustwallow Marsh,43.94,67.70,40,0
    .goto Dustwallow Marsh,43.49,67.02,40,0
    .goto Dustwallow Marsh,43.98,65.27,40,0
    .goto Dustwallow Marsh,44.93,65.18,40,0
    .goto Dustwallow Marsh,45.03,66.61
    >>Ride north-east to Stonemaul Hold. Click the Ogre Remains on the ground and kill the Stonemaul Spirits that rise from them. Ten spirits
    .complete 11159,1 --Kill Stonemaul Spirit (x10)
step
    .goto Dustwallow Marsh,41.857,73.976
.target Brogg
>>Talk to |cRXP_FRIENDLY_Brogg|r
    .turnin 11159 >> Turn in Spirits of Stonemaul Hold
    .accept 11162 >> Accept Challenge to the Black Flight
step
    #timer Challenge to the Black Flight roleplay
    .goto Dustwallow Marsh,52.08,75.82
    .use 33095 >> Ride east through the Wyrmbog to the entrance of Onyxia's Lair and plant the Stonemaul Banner outside it. Smolderwing lands after about 20 seconds, kill him
    .timer 20,Challenge to the Black Flight roleplay
    .complete 11162,1 --Kill Smolderwing (x1)
step
    #label wyrmtailLoop
    .goto Dustwallow Marsh,47.9,66.0,60,0
    .goto Dustwallow Marsh,47.9,70.9,60,0
    .goto Dustwallow Marsh,48.6,76.0,60,0
    .goto Dustwallow Marsh,48.0,79.7,60,0
    .goto Dustwallow Marsh,45.7,82.9,60,0
    .goto Dustwallow Marsh,43.5,80.7,60,0
    .goto Dustwallow Marsh,43.9,74.3
    >>Loot Wyrmtail plants in the Wyrmbog on the way back to Mudsprocket until you have eight
    .complete 11217,1 --Collect Wyrmtail (x8)
step
    .goto Dustwallow Marsh,41.537,72.985
.target Gizzix Grimegurgle
>>Talk to |cRXP_FRIENDLY_Gizzix Grimegurgle|r
    .turnin 11217 >> Turn in Catch a Dragon by the Tail
step
    .goto Dustwallow Marsh,41.857,73.976
.target Brogg
>>Talk to |cRXP_FRIENDLY_Brogg|r
    .turnin 11162 >> Turn in Challenge to the Black Flight
step
    >>Clean up before leaving Dustwallow. These only show if the quest is still in your log. Proof of Treachery is kept on purpose
    .abandon 11185 >> Abandon The Apothecary's Letter
    .abandon 11214 >> Abandon Mission to Mudsprocket
    .abandon 11217 >> Abandon Catch a Dragon by the Tail
    .abandon 11162 >> Abandon Challenge to the Black Flight
    .abandon 11159 >> Abandon Spirits of Stonemaul Hold
    .abandon 11207 >> Abandon Secure the Cargo!
    .abandon 11208 >> Abandon Delivery for Drazzit
step << Druid
    .goto Moonglade,52.53,40.57
    >>Cast Teleport: Moonglade and train from Loganaar in Nighthaven. Dire Bear Form unlocks at 40, then hearth to Theramore from here
    .trainer >> Train Dire Bear Form and your class spells
step
    #completewith next
    .hs >> Hearth to Theramore
step << Warrior
    .goto Dustwallow Marsh,67.88,48.41
    .trainer >> Train your class spells
step
    #sticky
    #completewith next
    +Dustwallow is done around level 47. Optional Darnassus trip next (about 25 minutes round trip by gryphon): Hunters, Rogues and Priests have not trained since Ashenvale and the next trainer on the route is Feathermoon Stronghold in Feralas, and Journeyman Riding (100% mount, about 55g with the reputation discount) is only sold in Darnassus for Night Elves. Skip the flight if you would rather keep questing, the steps below skip themselves while you stay in Dustwallow
step
    #completewith next
    .goto Dustwallow Marsh,67.476,51.300
    .fly Teldrassil >> Fly to Rut'theran Village (long multi-hop flight)
step
    .zoneskip Dustwallow Marsh
    .money <55
    .istrained 33391
    .goto Darnassus,38.69,15.84
    >>Take the portal up into Darnassus. Skips itself if you already have Journeyman Riding or cannot afford it
    .skill riding,150 >> Train Journeyman Riding from Jartsam and buy a 100% Nightsaber from Lelanai next to him
step << Warrior
    .zoneskip Dustwallow Marsh
    .goto Darnassus,58.71,34.90
    .trainer >> Train your class spells
step << Hunter
    .zoneskip Dustwallow Marsh
    .goto Darnassus,40.38,8.55
    .trainer >> Train your class spells
step << Rogue
    .zoneskip Dustwallow Marsh
    .goto Darnassus,36.99,21.91
    .trainer >> Train your class spells
step << Priest
    .zoneskip Dustwallow Marsh
    .goto Darnassus,39.52,81.20
    .trainer >> Train your class spells
step << Druid
    .zoneskip Dustwallow Marsh
    .goto Darnassus,35.37,8.40
    .trainer >> Train your class spells
step
    .zoneskip Dustwallow Marsh
    .goto Darnassus,30.41,41.40,30,0
    .goto Teldrassil,58.40,94.02
    >>Take the purple portal next to the bank down to Rut'theran Village
    .fly Theramore >> Fly to Theramore
step
    .goto Dustwallow Marsh,67.476,51.300
    .fly Mudsprocket >> Fly to Mudsprocket. The Tanaris chapter starts there
]])

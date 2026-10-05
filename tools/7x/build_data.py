#!/usr/bin/env python3
"""Rebuild the offline quest data used by rxp7x.py.

Downloads AzerothCore's quest_template / quest_template_addon SQL and the
Wrath Classic QuestXP table (identical values to 3.3.5 for levels 1-80), then
writes quests.json, quests_addon.json, prereqs.json and QuestXP.csv next to
this script. prereqs.json is decoded from the addon's own
DB/wotlk/questPrerequisites_335.lua so the analyzer applies exactly the rules
the addon applies in game.
"""
import json, os, re, sys, urllib.request
HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.abspath(os.path.join(HERE, '..', '..'))
AC = 'https://raw.githubusercontent.com/azerothcore/azerothcore-wotlk/master/data/sql/base/db_world/'
QUESTXP = 'https://wago.tools/db2/QuestXP/csv?build=3.4.3.52237'

COLS = """ID QuestType QuestLevel MinLevel QuestSortID QuestInfoID SuggestedGroupNum RequiredFactionId1 RequiredFactionId2 RequiredFactionValue1 RequiredFactionValue2 RewardNextQuest RewardXPDifficulty RewardMoney RewardMoneyDifficulty RewardDisplaySpell RewardSpell RewardHonor RewardKillHonor StartItem Flags RequiredPlayerKills RewardItem1 RewardAmount1 RewardItem2 RewardAmount2 RewardItem3 RewardAmount3 RewardItem4 RewardAmount4 ItemDrop1 ItemDropQuantity1 ItemDrop2 ItemDropQuantity2 ItemDrop3 ItemDropQuantity3 ItemDrop4 ItemDropQuantity4 RewardChoiceItemID1 RewardChoiceItemQuantity1 RewardChoiceItemID2 RewardChoiceItemQuantity2 RewardChoiceItemID3 RewardChoiceItemQuantity3 RewardChoiceItemID4 RewardChoiceItemQuantity4 RewardChoiceItemID5 RewardChoiceItemQuantity5 RewardChoiceItemID6 RewardChoiceItemQuantity6 POIContinent POIx POIy POIPriority RewardTitle RewardTalents RewardArenaPoints RewardFactionID1 RewardFactionValue1 RewardFactionOverride1 RewardFactionID2 RewardFactionValue2 RewardFactionOverride2 RewardFactionID3 RewardFactionValue3 RewardFactionOverride3 RewardFactionID4 RewardFactionValue4 RewardFactionOverride4 RewardFactionID5 RewardFactionValue5 RewardFactionOverride5 TimeAllowed AllowableRaces LogTitle LogDescription QuestDescription AreaDescription QuestCompletionLog RequiredNpcOrGo1 RequiredNpcOrGo2 RequiredNpcOrGo3 RequiredNpcOrGo4 RequiredNpcOrGoCount1 RequiredNpcOrGoCount2 RequiredNpcOrGoCount3 RequiredNpcOrGoCount4 RequiredItemId1 RequiredItemId2 RequiredItemId3 RequiredItemId4 RequiredItemId5 RequiredItemId6 RequiredItemCount1 RequiredItemCount2 RequiredItemCount3 RequiredItemCount4 RequiredItemCount5 RequiredItemCount6 Unknown0 ObjectiveText1 ObjectiveText2 ObjectiveText3 ObjectiveText4 VerifiedBuild""".split()
KEEP = ['ID','QuestType','QuestLevel','MinLevel','QuestSortID','SuggestedGroupNum','RewardNextQuest','RewardXPDifficulty','RewardMoney','StartItem','Flags','AllowableRaces','LogTitle'] + [f'RequiredNpcOrGo{i}' for i in range(1,5)] + [f'RequiredNpcOrGoCount{i}' for i in range(1,5)] + [f'RequiredItemId{i}' for i in range(1,7)] + [f'RequiredItemCount{i}' for i in range(1,7)]
ADDON_COLS = "ID MaxLevel AllowableClasses SourceSpellID PrevQuestID NextQuestID ExclusiveGroup BreadcrumbForQuestId RewardMailTemplateID RewardMailDelay RequiredSkillID RequiredSkillPoints RequiredMinRepFaction RequiredMaxRepFaction RequiredMinRepValue RequiredMaxRepValue ProvidedItemCount SpecialFlags".split()
ADDON_KEEP = ['ID','MaxLevel','AllowableClasses','PrevQuestID','NextQuestID','ExclusiveGroup','BreadcrumbForQuestId','SpecialFlags','RequiredSkillID','RequiredSkillPoints']

def fetch(url):
    print('downloading', url)
    return urllib.request.urlopen(url, timeout=300).read().decode('utf-8', 'replace')

def split_row(s):
    out, cur, i, inq = [], [], 0, False
    while i < len(s):
        c = s[i]
        if inq:
            if c == '\\': cur.append(s[i+1]); i += 2; continue
            if c == "'": inq = False; i += 1; continue
            cur.append(c)
        else:
            if c == "'": inq = True
            elif c == ',': out.append(''.join(cur)); cur = []
            else: cur.append(c)
        i += 1
    out.append(''.join(cur))
    return out

def parse_values(data):
    rows = {}
    i = data.find('(', data.find('VALUES')); n = len(data)
    while 0 <= i < n:
        j = i + 1; inq = False
        while j < n:
            c = data[j]
            if inq:
                if c == '\\': j += 2; continue
                if c == "'": inq = False
            else:
                if c == "'": inq = True
                elif c == ')': break
            j += 1
        vals = split_row(data[i+1:j]); rows[int(vals[0])] = vals
        k = j + 1
        while k < n and data[k] in ' \r\n\t,;': k += 1
        if k < n and data[k] == '(': i = k
        else:
            nxt = data.find('VALUES', k)
            if nxt == -1: break
            i = data.find('(', nxt)
    return rows

def num(v):
    try: return int(v)
    except ValueError:
        try: return float(v)
        except ValueError: return v

def main():
    rows = parse_values(fetch(AC + 'quest_template.sql'))
    quests = {}
    for qid, vals in rows.items():
        if len(vals) != len(COLS): print('skipping malformed row', qid, file=sys.stderr); continue
        d = dict(zip(COLS, vals)); quests[qid] = {k: num(d[k]) for k in KEEP}
    json.dump(quests, open(os.path.join(HERE, 'quests.json'), 'w'), separators=(',', ':'))
    addon = {}
    for m in re.finditer(r'\((-?\d+(?:,-?\d+){17})\)', fetch(AC + 'quest_template_addon.sql')):
        v = [int(x) for x in m.group(1).split(',')]; d = dict(zip(ADDON_COLS, v)); addon[v[0]] = {k: d[k] for k in ADDON_KEEP}
    json.dump(addon, open(os.path.join(HERE, 'quests_addon.json'), 'w'), separators=(',', ':'))
    open(os.path.join(HERE, 'QuestXP.csv'), 'w').write(fetch(QUESTXP))
    lua = open(os.path.join(ROOT, 'DB', 'wotlk', 'questPrerequisites_335.lua'), encoding='utf-8').read()
    enc = re.search(r'local encoded = \[\[(.*?)\]\]', lua, re.S).group(1)
    pre = {}
    for qid, spec in re.findall(r'(\d+)=([^;\s]+)', enc):
        pre[int(qid)] = [[(s, int(i)) for s, i in re.findall(r'([RAN])(\d+)', clause)] for clause in spec.split('|')]
    json.dump(pre, open(os.path.join(HERE, 'prereqs.json'), 'w'))
    print(len(quests), 'quests,', len(addon), 'addon rows,', len(pre), 'prerequisite rows')

if __name__ == '__main__':
    main()

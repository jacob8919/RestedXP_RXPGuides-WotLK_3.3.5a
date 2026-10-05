#!/usr/bin/env python3
"""Print everything needed to route a quest: giver/ender positions, objective mobs/objects
with spawn coordinates, item sources. Needs questie.json (see build_questie.py)."""
import json, os, sys
HERE=os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
from rxp7x import Q, QA, PRE, XPT
D=json.load(open(os.path.join(HERE,'questie.json')))
npc={int(k):v for k,v in D['npc'].items()}; obj={int(k):v for k,v in D['obj'].items()}; item={int(k):v for k,v in D['item'].items()}; qs={int(k):v for k,v in D['quest'].items()}
def spawns(t, n=6):
    if not isinstance(t, dict): return ''
    return ' '.join(f"z{z}:" + ','.join(f"({p[0]},{p[1]})" for p in pts[:n]) + (f"+{len(pts)-n}" if len(pts)>n else '') for z,pts in t.items())
def N(i,n=6):
    e=npc.get(i); return f"npc{i} {e[0]!r} L{e[3]}-{e[4]} r{e[5]} {spawns(e[6],n)}" if e else f"npc{i} ?"
def O(i,n=6):
    e=obj.get(i); return f"obj{i} {e[0]!r} {spawns(e[3],n)}" if e else f"obj{i} ?"
def I(i):
    e=item.get(i)
    if not e: return [f"item{i} ?"]
    out=[f"item{i} {e[0]!r}"]
    for n in (e[1] or [])[:6]: out.append('    from '+N(n))
    for o in (e[2] or [])[:6]: out.append('    from '+O(o))
    return out
for a in sys.argv[1:]:
    qid=int(a); q=Q.get(qid)
    if not q: print(qid,'unknown'); continue
    xp=XPT.get(q['QuestLevel'],[0]*10)[q['RewardXPDifficulty']] if q['QuestLevel']>0 else f"L*d{q['RewardXPDifficulty']}"
    ad=QA.get(qid,{})
    print(f"=== {qid} {q['LogTitle']} | L{q['QuestLevel']} min{q['MinLevel']} max{ad.get('MaxLevel',0)} xp{xp} grp{q['SuggestedGroupNum']} money{q['RewardMoney']} races{q['AllowableRaces']} cls{ad.get('AllowableClasses',0)} pre{PRE.get(qid,'')} next{ad.get('NextQuestID',0)} excl{ad.get('ExclusiveGroup',0)} special{ad.get('SpecialFlags',0)} startitem{q['StartItem']}")
    e=qs.get(qid)
    if e:
        for lbl,lst in (('start',e[1]),('end',e[2])):
            if not lst: continue
            for n in (lst[0] or []): print(f"  {lbl}: {N(n)}")
            for o in (lst[1] or []) if len(lst)>1 else []: print(f"  {lbl}: {O(o)}")
            for i in (lst[2] or []) if len(lst)>2 else []: print(f"  {lbl}: item{i}")
    for i in range(1,5):
        n=q.get(f'RequiredNpcOrGo{i}'); c=q.get(f'RequiredNpcOrGoCount{i}')
        if n and n>0: print(f"  obj{i}: kill x{c} {N(n)}")
        elif n: print(f"  obj{i}: use x{c} {O(-n)}")
    k=sum(1 for i in range(1,5) if q.get(f'RequiredNpcOrGo{i}'))
    for i in range(1,7):
        it=q.get(f'RequiredItemId{i}'); c=q.get(f'RequiredItemCount{i}')
        if it:
            k+=1; lines=I(it); print(f"  obj{k}: item x{c} {lines[0]}")
            for l in lines[1:]: print('   '+l)

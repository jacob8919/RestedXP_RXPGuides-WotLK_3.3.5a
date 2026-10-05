#!/usr/bin/env python3
"""Summarize an rxp7x --timeline output: per chapter start/end level, turn-ins, decayed share, ERR count."""
import re,sys,os
sys.path.insert(0,'tools/7x')
from rxp7x import Q, XPT, parse_file
simfile=sys.argv[1]; guidefile=sys.argv[2]; rate=float(sys.argv[3]) if len(sys.argv)>3 else 2
# map line -> chapter via parse
chap_of={}
guides=parse_file(guidefile)
bounds=[(g['steps'][0]['line'] if g['steps'] else 0, g['headers'].get('name')) for g in guides]
def chap(ln):
    name=None
    for b,n in bounds:
        if ln>=b: name=n
    return name
rows=[]; errs={}
for line in open(simfile):
    m=re.match(r'L(\d+)\s+(.{18})\s+(.{48})\s+(\d+)xp\s+\((\d+), ([\d.]+)\) -> \((\d+), ([\d.]+)\)',line)
    if m: rows.append((int(m.group(1)),m.group(2).strip(),m.group(3).strip(),int(m.group(4)),int(m.group(5)),float(m.group(6)),int(m.group(7)),float(m.group(8))))
    m=re.match(r'ERR\s+L(\d+): (.*)',line)
    if m: errs.setdefault(chap(int(m.group(1))),[]).append(m.group(2))
from collections import OrderedDict
ch=OrderedDict()
for r in rows:
    c=ch.setdefault(chap(r[0]),{'start':(r[4],r[5]),'end':None,'xp':0,'turnins':0,'decayed':0,'decayed_xp':0,'full_xp':0,'ql':[]})
    c['end']=(r[6],r[7]); c['xp']+=r[3]
    if r[2].startswith('turnin'):
        qid=int(r[2].split()[1]); q=Q.get(qid)
        c['turnins']+=1
        if q and q['QuestLevel']>0:
            c['ql'].append(q['QuestLevel'])
            base=XPT.get(q['QuestLevel'],[0]*10)[q['RewardXPDifficulty']]*rate
            c['full_xp']+=base
            if r[3]<base*0.99: c['decayed']+=1; c['decayed_xp']+=base-r[3]
print(f"{'chapter':<34} {'start':>10} {'end':>10} {'turnins':>7} {'decayed':>7} {'lost%':>6} {'xp':>9} {'qlvl med':>8} {'ERR':>4}")
for k,c in ch.items():
    lost=c['decayed_xp']/c['full_xp']*100 if c['full_xp'] else 0
    ql=sorted(c['ql']); med=ql[len(ql)//2] if ql else 0
    print(f"{str(k):<34} {str(c['start']):>10} {str(c['end']):>10} {c['turnins']:>7} {c['decayed']:>7} {lost:>5.0f}% {c['xp']:>9} {med:>8} {len(errs.get(k,[])):>4}")
for k in errs:
    if k not in ch: print(f"{str(k):<34} (no turn-ins) ERR {len(errs[k])}")
if '--errs' in sys.argv:
    for k,v in errs.items():
        print('\n##',k)
        for e in v: print('  ',e)

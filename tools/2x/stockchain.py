#!/usr/bin/env python3
"""Write the stock Alliance chapter chain in #next order (as the addon resolves it for CLASS at RATE) into one file.
Usage: python3 tools/2x/stockchain.py Druid 1 out.lua [start chapter]   (run from the checkout root)"""
import re, sys, os
sys.path.insert(0,'tools/7x')
from rxp7x import cond_ok, xprate_ok, Profile
STOCK=["Guides/RestedXP Alliance 1-11 NightElf.lua","Guides/RestedXP Alliance 11-23.lua","Guides/RestedXP Alliance 23-30.lua","Guides/TBC/Alliance-Leveling.lua","Guides/WotLK/Alliance-Leveling.lua"]
cls=sys.argv[1]; rate=float(sys.argv[2]); out=sys.argv[3]; start=sys.argv[4] if len(sys.argv)>4 else '1-6 Shadowglen'
prof=Profile('NightElf',cls,rate,1)
blocks={}
ROOT=os.environ.get('STOCK_ROOT','.')
for f in STOCK:
    src=open(os.path.join(ROOT,f),encoding='utf-8').read()
    for m in re.finditer(r'RXPGuides\.RegisterGuide\(\[\[(.*?)\]\]\)', src, re.S):
        body=m.group(1); h={}; cond=''
        for line in body.split('\n'):
            l=line.strip()
            if l.startswith('step'): break
            if l.startswith('<<'): cond=l[2:].strip()
            mm=re.match(r'^#(\w+)\s*(.*?)\s*(?:<<\s*(.*))?$',l)
            if mm:
                if mm.group(3) and not cond_ok(mm.group(3),prof): continue
                h[mm.group(1)]=mm.group(2)
        blocks.setdefault(h.get('name'),[]).append((f,h,cond,m.group(0)))
def active(b):
    f,h,cond,txt=b
    return cond_ok(cond,prof) and xprate_ok(h.get('xprate',''),rate)
name=start; chain=[]; seen=set()
while name and name not in seen:
    seen.add(name)
    cands=[b for b in blocks.get(name,[]) if active(b)]
    if not cands: print('NO ACTIVE BLOCK for',name); break
    b=cands[0]; chain.append(b)
    nxt=b[1].get('next','')
    name=None
    for c in nxt.split(';'):
        c=c.strip()
        if not c: continue
        c=c.split('\\')[-1]
        if any(active(x) for x in blocks.get(c,[])): name=c; break
    if nxt and not name: print('no active next among',nxt)
with open(out,'w') as fh:
    for f,h,cond,txt in chain: fh.write(txt+'\n')
for f,h,cond,txt in chain: print(f"{h.get('name'):<40} xprate={h.get('xprate','-'):<8} <<{cond:<30} {os.path.basename(f)}")

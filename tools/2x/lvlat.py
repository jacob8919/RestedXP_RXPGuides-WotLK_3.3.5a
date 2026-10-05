#!/usr/bin/env python3
"""For a built (concatenated) guide file and its sim timeline, print steps matching a regex with the sim level at that point."""
import sys,re
simfile,guidefile,pat=sys.argv[1],sys.argv[2],sys.argv[3]
sys.path.insert(0,'tools/7x')
from rxp7x import parse_file
tl=[]
for l in open(simfile):
    m=re.match(r'L(\d+)\s+.{18}\s+.{48}\s+\d+xp\s+\(\d+, [\d.]+\) -> \((\d+), ([\d.]+)\)',l)
    if m: tl.append((int(m.group(1)),int(m.group(2)),float(m.group(3))))
def lvl(ln):
    cur=(1,0.0)
    for L,a,b in tl:
        if L>ln: break
        cur=(a,b)
    return cur
for g in parse_file(guidefile):
    for st in g['steps']:
        txt='\n'.join(st['text'])+' '+' '.join(d['name']+' '+','.join(d['args'])+' '+d['text'] for d in st['dirs'])+' '+st['cond']+' '+' '.join(st['tags'])
        if re.search(pat,txt):
            print(f"L{st['line']:<6} lvl={lvl(st['line'])} <<{st['cond']:<10} {g['headers']['name'][:26]:<26} {re.sub(r'\s+',' ',txt)[:130]}")

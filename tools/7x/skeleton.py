#!/usr/bin/env python3
"""Compact one-line-per-step view of a guide file: tags, guards, quest directives,
first goto and a snippet of text. Handy for reading a 2000-line stock chapter."""
import sys, re, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from rxp7x import parse_file, Q
for f in sys.argv[1:]:
    for g in parse_file(f):
        print('##', g['headers'].get('name'), '| next', g['headers'].get('next'))
        for st in g['steps']:
            parts=[]
            tags=' '.join(f"#{k}{(' '+v[0][0]) if v[0][0] else ''}" for k,v in st['tags'].items())
            cond=f"<<{st['cond']}" if st['cond'] else ''
            goto=None; qd=[]; other=[]
            for d in st['dirs']:
                n=d['name']; a=d['args']
                if n=='goto':
                    if goto is None and len(a)>=3 and not (len(a)>=5 and a[4]=='0'): goto=','.join(a[:3])
                    elif goto is None: goto=','.join(a[:3])+'*'
                elif n in ('accept','turnin','complete','collect','abandon'):
                    qid=a[0] if a else '?'
                    nm=Q.get(abs(int(qid)),{}).get('LogTitle','?')[:22] if re.match(r'^-?\d+$',qid) else '?'
                    qd.append(f"{n[:3]} {qid}{'' if n=='collect' else ' '+nm}{(' obj'+a[1]) if n=='complete' and len(a)>1 else ''}")
                elif n in ('isOnQuest','isQuestTurnedIn','isQuestComplete','maxlevel','xp','dungeon','zoneskip','subzoneskip','skipOnQuest','isQuestAvailable','itemcount','money','istrained'):
                    other.append(f".{n} {','.join(a)}")
                elif n in ('fly','fp','home','hs','zone','subzone','use','deathskip','trainer','train','skill','unitscan','gossip'):
                    other.append(f".{n} {','.join(a[:2])}{(' >>'+d['text'][:30]) if d['text'] else ''}")
            text=' '.join(t for t in st['text'] if not t.startswith('>>|T'))
            text=re.sub(r'\|c[A-Z_]+|\|r|\|T[^|]*\|t','',text)[:70]
            print(f"L{st['line']:<5} {cond:<12} {tags:<34} {goto or '':<28} {' ; '.join(qd+other):<90} {text}")

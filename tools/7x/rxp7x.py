#!/usr/bin/env python3
"""Offline RXP guide analyzer for 7x planning.
Parses RXPGuides.RegisterGuide([[...]]) blocks, simulates quest state for a profile,
checks AzerothCore prerequisites / races / classes / max level, and estimates the
level curve at a given XP rate."""
import re, json, sys, math, argparse, os
S=os.path.dirname(os.path.abspath(__file__))
Q=json.load(open(S+'/quests.json')); Q={int(k):v for k,v in Q.items()}
QA=json.load(open(S+'/quests_addon.json')); QA={int(k):v for k,v in QA.items()}
PRE=json.load(open(S+'/prereqs.json')); PRE={int(k):v for k,v in PRE.items()}
XPT={}
for line in open(S+'/QuestXP.csv').read().splitlines()[1:]:
    p=[int(x) for x in line.split(',')]; XPT[p[0]]=p[1:]
LVLXP=[400, 900, 1400, 2100, 2800, 3600, 4500, 5400, 6500, 7600, 8700, 9800, 11000, 12300, 13600, 15000, 16400, 17800, 19300, 20800, 22400, 24000, 25500, 27200, 28900, 30500, 32200, 33900, 36300, 38800, 41600, 44600, 48000, 51400, 55000, 58700, 62400, 66200, 70200, 74300, 78500, 82800, 87100, 91600, 96300, 101000, 105800, 110700, 115700, 120900, 126100, 131500, 137000, 142500, 148200, 154000, 159900, 165800, 172000, 290000, 317000, 349000, 386000, 428000, 475000, 527000, 585000, 648000, 717000, 1523800, 1539600, 1555700, 1571800, 1587900, 1604200, 1620700, 1637400, 1653900, 1670800]
RACEBIT={'Human':1,'Orc':2,'Dwarf':4,'NightElf':8,'Scourge':16,'Undead':16,'Tauren':32,'Gnome':64,'Troll':128,'BloodElf':512,'Draenei':1024}
CLASSBIT={'WARRIOR':1,'PALADIN':2,'HUNTER':4,'ROGUE':8,'PRIEST':16,'DEATHKNIGHT':32,'SHAMAN':64,'MAGE':128,'WARLOCK':256,'DRUID':1024}
CLASSNAMES={'Warrior':'WARRIOR','Paladin':'PALADIN','Hunter':'HUNTER','Rogue':'ROGUE','Priest':'PRIEST','DK':'DEATHKNIGHT','Deathknight':'DEATHKNIGHT','Shaman':'SHAMAN','Mage':'MAGE','Warlock':'WARLOCK','Druid':'DRUID'}

def quest_xp(qid, plevel):
    q=Q.get(qid)
    if not q: return 0
    ql=q['QuestLevel']; 
    if ql==-1: ql=plevel
    base=XPT.get(ql,[0]*10)[q['RewardXPDifficulty']]
    d=plevel-ql
    mult = 1.0 if d<=5 else {6:0.8,7:0.6,8:0.4,9:0.2}.get(d,0.1)
    return int(base*mult)

def gray_level(pl):
    if pl<=5: return 0
    if pl<=39: return pl-5-pl//10
    if pl<=59: return pl-1-pl//5
    return pl-9
def zero_diff(pl):
    for lim,v in ((8,5),(10,6),(12,7),(16,8),(20,9),(30,11),(40,12),(45,13),(50,14),(55,15),(60,16)):
        if pl<lim: return v
    return 17
def mob_xp(pl, ml, content='classic'):
    base=pl*5+{'classic':45,'outland':235,'northrend':580}[content]
    if ml>=pl:
        return ((base*(20+min(ml-pl,4))//10)+1)//2
    if ml>gray_level(pl):
        zd=zero_diff(pl); return base*(zd+ml-pl)//zd
    return 0

class Profile:
    def __init__(s, race, cls, rate, level=1):
        s.race=race; s.cls=cls; s.faction='Alliance' if race in ('Human','Dwarf','NightElf','Gnome','Draenei') else 'Horde'
        s.rate=rate; s.level=level; s.xp=0
    def add_xp(s, amount):
        s.xp+=amount
        while s.level<80 and s.xp>=LVLXP[s.level-1]:
            s.xp-=LVLXP[s.level-1]; s.level+=1
    def frac(s): return s.xp/LVLXP[s.level-1] if s.level<80 else 0.0

def cond_ok(cond, prof, game='wotlk'):
    """RXP condition: alternatives split by '/', tokens ANDed, '!' negates. Numeric = level>=N."""
    if not cond or not cond.strip(): return True
    text=cond.strip()
    def tok(t):
        neg=t.startswith('!'); 
        if neg: t=t[1:]
        u=t.upper()
        if t.isdigit(): v = prof.level>=int(t)
        elif u in ('WOTLK','AC335'): v=True
        elif u in ('TBC','CLASSIC','ERA','SOM','SOD','HARDCORE','DF','RETAIL','CATA','MOP','SKIP'): v=False
        elif u=='SOFTCORE': v=True
        elif u in ('MALE','FEMALE'): v=True
        elif u=='DK': v=prof.cls=='Deathknight'
        elif t=='Undead': v=prof.race=='Scourge'
        else: v = (u==prof.cls.upper()) or (t==prof.race) or (t==prof.faction)
        return (not v) if neg else v
    # parentheses
    while True:
        m=re.search(r'(!?)\(([^()]*)\)', text)
        if not m: break
        v=cond_ok(m.group(2),prof)
        if m.group(1)=='!': v=not v
        text=text[:m.start()]+('__T__' if v else '__F__')+text[m.end():]
    for alt in text.split('/'):
        ok=True
        for t in re.findall(r'!?[A-Za-z0-9_]+', alt):
            if t=='__T__': continue
            if t=='__F__': ok=False; break
            if not tok(t): ok=False; break
        if ok: return True
    return False

def xprate_ok(expr, rate):
    if not expr: return True
    m=re.match(r'^\s*([<>]?)\s*(\d+\.?\d*)-?(\d*\.?\d*)', expr)
    if not m: return True
    op,a,b=m.groups(); a=float(a)
    if op=='<': return rate< a-1e-4
    if op=='>': return rate> a+1e-4
    hi=float(b) if b else 4095
    return a<=rate<=hi

def parse_file(path):
    src=open(path,encoding='utf-8').read()
    guides=[]
    for m in re.finditer(r'RXPGuides\.RegisterGuide\(\[\[(.*?)\]\]\)', src, re.S):
        body=m.group(1); startline=src[:m.start()].count('\n')+2
        g={'headers':{}, 'hconds':{}, 'steps':[], 'file':path, 'cond':''}
        cur=None
        for i,raw in enumerate(body.split('\n')):
            ln=startline+i
            line=raw.strip()
            if not line or line.startswith('--'): continue
            if cur is None and line.startswith('<<'):
                g['cond']=line[2:].strip(); continue
            if re.match(r'^step\b', line):
                c=''
                mm=re.match(r'^step\s*<<\s*(.*)$', line)
                if mm: c=mm.group(1).strip()
                cur={'line':ln,'cond':c,'tags':{},'dirs':[],'text':[]}
                g['steps'].append(cur); continue
            if line.startswith('#'):
                mm=re.match(r'^#(\w+)\s*(.*?)\s*(?:<<\s*(.*))?$', line)
                tag,val,c=mm.group(1),mm.group(2),mm.group(3)
                if cur is None: g['headers'][tag]=val; g['hconds'][tag]=c or ''
                else: cur['tags'].setdefault(tag,[]).append((val,c or ''))
                continue
            if cur is None: continue
            if line.startswith('.'):
                mm=re.match(r'^\.(\w+)\s*([^>]*?)?\s*(?:>>\s*(.*?))?\s*(?:<<\s*(.*))?$', line)
                if not mm: continue
                name,args,text,c=mm.group(1),mm.group(2) or '',mm.group(3) or '',mm.group(4) or ''
                # strip trailing comments
                args=re.sub(r'\s*--.*$','',args)
                if '<<' in args:
                    args,c=args.split('<<',1); c=c.strip()
                argl=[a.strip() for a in args.split(',')] if args.strip() else []
                cur['dirs'].append({'line':ln,'name':name,'args':argl,'text':text,'cond':c.strip()})
            else:
                cur['text'].append(line)
        guides.append(g)
    return guides

def prereq_state(qid, accepted, turned):
    clauses=PRE.get(qid)
    if not clauses: return True, []
    missing_all=[]
    for clause in clauses:
        ok=True; missing=[]
        for st,pid in clause:
            if st=='R': v = pid in turned
            elif st=='A': v = pid in turned or pid in accepted
            else: v = pid not in turned and pid not in accepted
            if not v: ok=False; missing.append((st,pid))
        if ok: return True, []
        missing_all.append(missing)
    return False, missing_all

def qname(qid): return Q.get(qid,{}).get('LogTitle','?')

def simulate(guides, prof, verbose=False, stop_group=None):
    accepted=set(); turned=set(); completed=set(); issues=[]; timeline=[]
    labels={}
    def issue(kind, line, msg): issues.append((kind,line,msg))
    for g in guides:
        h=g['headers']
        if not cond_ok(g['cond'],prof): continue
        gname=h.get('name','?')
        if cond_ok(g.get('hconds',{}).get('xprate',''),prof) and not xprate_ok(h.get('xprate',''), prof.rate): continue
        for st in g['steps']:
            if not cond_ok(st['cond'],prof): continue
            xr=st['tags'].get('xprate')
            if xr:
                skip=False
                for val,c in xr:
                    if cond_ok(c,prof) and not xprate_ok(val,prof.rate): skip=True
                if skip: continue
            ml=st['tags'].get('maxlevel')
            if ml and any(cond_ok(c,prof) and prof.level>int(v) for v,c in ml): continue
            # guard directives that skip a step
            skipstep=False
            for d in st['dirs']:
                if not cond_ok(d['cond'],prof): continue
                n=d['name']; a=d['args']
                ids=[int(x) for x in a if re.match(r'^-?\d+$',x)]
                if n=='isOnQuest' and not any(abs(i) in accepted for i in ids): skipstep=True
                if n=='isNotOnQuest' and any(abs(i) in accepted for i in ids): skipstep=True
                if n=='isQuestTurnedIn':
                    rev=any(i<0 for i in ids); ok=any(abs(i) in turned for i in ids)
                    if rev: ok = not ok
                    if not ok: skipstep=True
                if n=='isQuestAvailable' and any(abs(i) in turned for i in ids): skipstep=True
                if n=='isQuestComplete' and not any(abs(i) in completed for i in ids): skipstep=True
                if n=='isQuestNotComplete' and any(abs(i) in completed for i in ids): skipstep=True
                if n=='maxlevel' and ids and prof.level>ids[0]: skipstep=True
                if n=='skipOnQuest' and ids and ids[0] in accepted: skipstep=True
                if n=='xp' and len(a)>1 and a[1]=='1' and a[0]:
                    # `.xp <N,1` skips the step below level N; `.xp N,1` skips it at level N or above
                    mm=re.match(r'^(<?)(\d+)',a[0].replace(' ',''))
                    if mm:
                        lv=int(mm.group(2))
                        if (mm.group(1) and prof.level<lv) or (not mm.group(1) and prof.level>=lv): skipstep=True
            if skipstep: continue
            for d in st['dirs']:
                if not cond_ok(d['cond'],prof): continue
                n=d['name']; a=d['args']; ln=d['line']
                if n in ('accept','daily'):
                    for x in a[:1] if n=='accept' else a:
                        qid=int(x)
                        if n=='accept' and len(a)>=3 and int(a[1])&2 and int(a[2]) not in turned: continue
                        q=Q.get(qid)
                        if not q: issue('ERR',ln,f'accept {qid}: unknown quest'); continue
                        if qid in turned: issue('WARN',ln,f'accept {qid} {qname(qid)}: already turned in'); continue
                        if qid in accepted: issue('INFO',ln,f'accept {qid} {qname(qid)}: already on quest'); continue
                        ar=q['AllowableRaces']; 
                        if ar and not (ar & RACEBIT[prof.race]): issue('ERR',ln,f'accept {qid} {qname(qid)}: race not allowed'); continue
                        ac=QA.get(qid,{}).get('AllowableClasses',0)
                        if ac and not (ac & CLASSBIT[CLASSNAMES[prof.cls]]): issue('ERR',ln,f'accept {qid} {qname(qid)}: class not allowed'); continue
                        if prof.level<q['MinLevel']: issue('ERR',ln,f'accept {qid} {qname(qid)}: min level {q["MinLevel"]} (est level {prof.level})')
                        mx=QA.get(qid,{}).get('MaxLevel',0)
                        if mx and prof.level>mx: issue('ERR',ln,f'accept {qid} {qname(qid)}: max level {mx} (est level {prof.level})')
                        ok,miss=prereq_state(qid,accepted,turned)
                        if not ok: issue('ERR',ln,f'accept {qid} {qname(qid)}: prereq missing {miss}')
                        accepted.add(qid)
                elif n=='turnin':
                    qid=int(a[0]); skipmissing=qid<0; qid=abs(qid)
                    if qid not in accepted:
                        if qid in turned: issue('INFO',ln,f'turnin {qid} {qname(qid)}: already turned in (auto-completes in the client)')
                        elif not skipmissing: issue('ERR',ln,f'turnin {qid} {qname(qid)}: not on quest')
                        continue
                    q=Q[qid]
                    hasobj=any(q.get(f'RequiredNpcOrGo{i}') for i in range(1,5)) or any(q.get(f'RequiredItemId{i}') for i in range(1,7))
                    if hasobj and qid not in completed: issue('INFO',ln,f'turnin {qid} {qname(qid)}: no .complete step seen')
                    xp=quest_xp(qid,prof.level)*prof.rate
                    before=(prof.level,round(prof.frac(),2)); prof.add_xp(xp)
                    timeline.append((ln,gname,f'turnin {qid} {qname(qid)}',int(xp),before,(prof.level,round(prof.frac(),2))))
                    accepted.discard(qid); turned.add(qid)
                elif n=='complete':
                    qid=int(a[0]); skipmissing=qid<0; qid=abs(qid)
                    if qid not in accepted:
                        if qid in turned: issue('INFO',ln,f'complete {qid} {qname(qid)}: already turned in')
                        elif not skipmissing: issue('ERR',ln,f'complete {qid} {qname(qid)}: not on quest')
                        continue
                    q=Q[qid]; obj=int(a[1]) if len(a)>1 else 1
                    # kill xp estimate
                    kills=0; ml=q['QuestLevel'] if q['QuestLevel']>0 else prof.level
                    npc=q.get(f'RequiredNpcOrGo{obj}',0); cnt=q.get(f'RequiredNpcOrGoCount{obj}',0)
                    if isinstance(npc,int) and npc>0: kills=cnt
                    else:
                        # item objective index counts after npc objectives
                        items=[(q.get(f'RequiredItemId{i}'),q.get(f'RequiredItemCount{i}')) for i in range(1,7) if q.get(f'RequiredItemId{i}')]
                        nnpc=sum(1 for i in range(1,5) if q.get(f'RequiredNpcOrGo{i}'))
                        k=obj-nnpc-1
                        if 0<=k<len(items): kills=int(items[k][1]*1.3)
                    if kills:
                        xp=mob_xp(prof.level,ml)*prof.rate*kills
                        before=(prof.level,round(prof.frac(),2)); prof.add_xp(xp)
                        timeline.append((ln,gname,f'complete {qid},{obj} ~{kills} kills L{ml}',int(xp),before,(prof.level,round(prof.frac(),2))))
                    completed.add(qid)
                elif n=='abandon':
                    accepted.discard(int(a[0]))
                elif n=='xp' and not (len(a)>1 and a[1]=='1'):
                    m=re.match(r'^(<?)(\d+)([+\-]?\d*)',a[0].replace(' ',''))
                    if m and not m.group(1):
                        lv=int(m.group(2))
                        if prof.level<lv: 
                            timeline.append((ln,gname,f'GRIND to {lv}',0,(prof.level,round(prof.frac(),2)),(lv,0.0)))
                            prof.level=lv; prof.xp=0
    return issues, timeline, accepted, turned

if __name__=='__main__':
    ap=argparse.ArgumentParser()
    ap.add_argument('files',nargs='+'); ap.add_argument('--race',default='NightElf'); ap.add_argument('--class',dest='cls',default='Hunter')
    ap.add_argument('--rate',type=float,default=7); ap.add_argument('--level',type=int,default=1); ap.add_argument('--timeline',action='store_true'); ap.add_argument('--quests',action='store_true')
    a=ap.parse_args()
    guides=[]
    for f in a.files: guides+=parse_file(f)
    prof=Profile(a.race,a.cls,a.rate,a.level)
    issues,timeline,acc,turned=simulate(guides,prof)
    print(f'== {a.race} {a.cls} @ {a.rate}x : final level {prof.level} +{prof.frac():.0%} ; still on {sorted(acc)}')
    for k,ln,msg in issues: print(f'{k:4} L{ln}: {msg}')
    if a.timeline:
        for t in timeline: print(f'L{t[0]:<5} {t[1][:18]:<18} {t[2][:48]:<48} {t[3]:>6}xp  {t[4]} -> {t[5]}')
    if a.quests:
        ids=set()
        for g in guides:
            for st in g['steps']:
                for d in st['dirs']:
                    if d['name'] in ('accept','turnin','complete') and d['args'] and re.match(r'^-?\d+$',d['args'][0]): ids.add(abs(int(d['args'][0])))
        print('\nquest  lvl min  diff   xp@lvl  money  races  cls  prereq                     next   title')
        for qid in sorted(ids):
            q=Q.get(qid); 
            if not q: print(qid,'??'); continue
            xp=XPT.get(q['QuestLevel'],[0]*10)[q['RewardXPDifficulty']] if q['QuestLevel']>0 else 0
            print(f"{qid:<6} {q['QuestLevel']:>3} {q['MinLevel']:>3}  {q['RewardXPDifficulty']:>3}  {xp:>7}  {q['RewardMoney']:>5}  {q['AllowableRaces']:>5}  {QA.get(qid,{}).get('AllowableClasses',0):>3}  {str(PRE.get(qid,''))[:26]:<26} {QA.get(qid,{}).get('NextQuestID',0):>6}  {q['LogTitle']}")

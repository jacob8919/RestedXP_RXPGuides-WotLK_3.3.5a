#!/usr/bin/env python3
"""Build the "RestedXP Alliance 2x Druid" chapters (Guides/2x/*.lua) from the stock 3.3.5 chapters.

Each chapter in SPEC is a mechanical copy of one stock RegisterGuide block with:
  * headers rewritten (name, group, next, guide condition; stock #subgroup/#defaultfor/#xprate dropped),
  * `#xprate` step branches resolved for rate 2 at build time (steps that only show below 1.5x are
    removed, the tags of the surviving steps are stripped; a removed step that defines a #label used
    elsewhere is kept with its runtime tag instead),
  * the chapter's edit list applied (drop_step / insert_before / insert_after / replace / prepend / append),
  * comments recording the source.
Run from the checkout root:  python3 tools/2x/build2x.py [--check]
"""
import re, sys, os
ROOT=os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
sys.path.insert(0, ROOT+'/tools/7x')
from rxp7x import cond_ok, xprate_ok, Profile
from spec2x import SPEC, GROUP, COND, FILE_HEADER
RATE=2.0
PROF=Profile('NightElf','Druid',RATE)
STOCK=["Guides/RestedXP Alliance 1-11 NightElf.lua","Guides/RestedXP Alliance 11-23.lua","Guides/RestedXP Alliance 23-30.lua","Guides/TBC/Alliance-Leveling.lua","Guides/WotLK/Alliance-Leveling.lua"]

def load_blocks():
    blocks={}
    for f in STOCK:
        src=open(ROOT+'/'+f,encoding='utf-8').read()
        for m in re.finditer(r'RXPGuides\.RegisterGuide\(\[\[(.*?)\]\]\)', src, re.S):
            body=m.group(1)
            name=re.search(r'^#name\s+(.*?)\s*$',body,re.M).group(1)
            cond=re.search(r'^<<\s*(.*?)\s*$',body,re.M)
            cond=cond.group(1) if cond else ''
            if 'Warlock' in cond and '!Warlock' not in cond: continue   # the Warlock-only Darkshore/Ashenvale variant
            line0=src[:m.start()].count('\n')+1
            blocks[name]=(f,line0,body)
    return blocks

def split_steps(body):
    """Return (header_lines, steps) where steps is a list of line lists, each starting with the 'step' line."""
    lines=body.split('\n'); hdr=[]; steps=[]; cur=None
    for l in lines:
        if re.match(r'^\s*step\b', l):
            cur=[l]; steps.append(cur)
        elif cur is None: hdr.append(l)
        else: cur.append(l)
    return hdr, steps

def step_tags(step):
    tags=[]
    for l in step[1:]:
        m=re.match(r'^\s*#(\w+)\s*(.*?)\s*(?:<<\s*(.*))?$', l.strip())
        if m: tags.append((m.group(1), m.group(2), m.group(3) or '', l))
    return tags

def resolve_xprate(steps):
    """Drop steps whose #xprate branch is off at RATE; strip the tag from the others.
    A dropped step's #label moves to the next surviving step so #completewith/#requires
    references keep a sensible anchor (the loader would otherwise fall back to "next")."""
    drop=[]
    for st in steps:
        xr=[t for t in step_tags(st) if t[0]=='xprate']
        drop.append(bool(xr) and any(cond_ok(c,PROF) and not xprate_ok(v,RATE) for _,v,c,_ in xr))
    out=[]; removed=0; moved=0; pending_labels=[]
    for i,st in enumerate(steps):
        if drop[i]:
            removed+=1
            pending_labels+=[t[3] for t in step_tags(st) if t[0]=='label']
            continue
        st=[l for l in st if not re.match(r'^\s*#xprate\b', l)]
        if pending_labels:
            own={t[1] for t in step_tags(st) if t[0]=='label'}
            for lab in pending_labels:
                name=re.match(r'^\s*#label\s+(\S+)', lab).group(1)
                if name not in own: st.insert(1, lab); own.add(name); moved+=1
            pending_labels=[]
        out.append(st)
    return out, removed, moved

def find_step(steps, anchor):
    """Index of the unique step containing a line whose stripped text equals anchor (or matches it as a regex when it starts with 're:')."""
    if isinstance(anchor, tuple): anchor, nth = anchor
    else: nth=None
    hits=[]
    for i,st in enumerate(steps):
        for l in st:
            s=l.strip()
            if (anchor.startswith('re:') and re.search(anchor[3:], s)) or s==anchor:
                hits.append(i); break
    if nth is not None:
        if nth>=len(hits): raise SystemExit(f'anchor {anchor!r}: occurrence {nth} not found ({len(hits)} hits)')
        return hits[nth]
    if len(hits)!=1: raise SystemExit(f'anchor {anchor!r}: {len(hits)} hits, need exactly 1: {hits}')
    return hits[0]

def as_steps(text):
    _,s=split_steps('\n'+text.strip('\n'))
    return s

def apply_edits(steps, edits, chname):
    for e in edits:
        op=e[0]
        if op=='drop_step':
            i=find_step(steps,e[1]); del steps[i]
        elif op=='insert_before':
            i=find_step(steps,e[1]); steps[i:i]=as_steps(e[2])
        elif op=='insert_after':
            i=find_step(steps,e[1]); steps[i+1:i+1]=as_steps(e[2])
        elif op=='prepend':
            steps[0:0]=as_steps(e[1])
        elif op=='append':
            steps.extend(as_steps(e[1]))
        elif op=='replace':
            i=find_step(steps,e[1]); n=0
            for st in steps:
                for j,l in enumerate(st):
                    if l.strip()==e[1]:
                        st[j]=l[:len(l)-len(l.lstrip())]+e[2]; n+=1
            if n!=1: raise SystemExit(f'{chname}: replace {e[1]!r}: {n} hits')
        elif op=='replace_nth':
            i=find_step(steps,(e[1],e[2])); n=0
            for j,l in enumerate(steps[i]):
                if l.strip()==e[1]: steps[i][j]=l[:len(l)-len(l.lstrip())]+e[3]; n+=1
            if n!=1: raise SystemExit(f'{chname}: replace_nth {e[1]!r}: {n} hits in step')
        elif op=='delete_lines':
            n=0
            for st in steps:
                keep=[l for l in st if not re.search(e[1], l.strip())]; n+=len(st)-len(keep); st[:]=keep
            if n==0: raise SystemExit(f'{chname}: delete_lines {e[1]!r}: no hits')
        elif op=='cond':
            i=find_step(steps,e[1]); steps[i][0]=re.sub(r'^(\s*step\b).*$', r'\1 << '+e[2], steps[i][0])
        elif op=='drop_from':
            i=find_step(steps,e[1]); del steps[i:]
        elif op=='insert_stock':
            _,src,frm,to,pos=e
            f,line0,body=BLOCKS[src]; _,ss=split_steps(body); ss,_,_=resolve_xprate(ss)
            a=find_step(ss,frm); b=find_step(ss,to)
            if b<a: raise SystemExit(f'{chname}: insert_stock range reversed')
            chunk=[list(x) for x in ss[a:b+1]]
            if pos=='prepend': steps[0:0]=chunk
            elif pos=='append': steps.extend(chunk)
            elif pos[0]=='before': i=find_step(steps,pos[1]); steps[i:i]=chunk
            elif pos[0]=='after': i=find_step(steps,pos[1]); steps[i+1:i+1]=chunk
        elif op=='sub':
            n=0
            for st in steps:
                for j,l in enumerate(st):
                    new=re.sub(e[1],e[2],l)
                    if new!=l: st[j]=new; n+=1
            if n==0: raise SystemExit(f'{chname}: sub {e[1]!r}: no hits')
        else: raise SystemExit(f'unknown edit {op}')
    return steps

def build():
    global BLOCKS
    blocks=load_blocks(); BLOCKS=blocks; files={}
    names=[c['name'] for c in SPEC]
    for k,ch in enumerate(SPEC):
        f,line0,body=blocks[ch['src']]
        hdr,steps=split_steps(body)
        steps,removed,kept=resolve_xprate(steps)
        steps=apply_edits(steps, ch.get('edits',[]), ch['name'])
        if ch.get('cleanup'):
            from rxp7x import Q
            lines=['step','>>Clean up before moving on. These only show if the quest is still in your log']
            for qid in ch['cleanup']: lines.append('.abandon %d >> Abandon %s' % (qid, Q.get(qid,{}).get('LogTitle','?')))
            steps.append(lines)
        keep=[]
        for l in hdr:
            s=l.strip()
            if not s or s.startswith('--'): continue
            if s.startswith('<<') or re.match(r'^#(name|group|subgroup|defaultfor|xprate|next|version)\b', s): continue
            keep.append(s)
        nxt = ch.get('next', names[k+1] if k+1<len(names) else None)
        out=['-- Source: "%s" from %s line %d (%d xprate-only steps removed, %d labels moved to the next step)' % (ch['src'], f, line0, removed, kept),
             'RXPGuides.RegisterGuide([[']
        out+=keep
        out+=['<< '+COND, '#name '+ch['name'], '#version 1', '#group '+GROUP]
        if nxt: out.append('#next '+nxt)
        for st in steps: out+=[l.rstrip() for l in st if l.strip()!='']
        out.append(']])')
        files.setdefault(ch['file'],[]).append('\n'.join(out))
    for fn,chunks in files.items():
        path=ROOT+'/Guides/2x/'+fn
        with open(path,'w',encoding='utf-8') as fh:
            fh.write(FILE_HEADER+'\n\n'+'\n\n'.join(chunks)+'\n')
        print('wrote',path)
    return list(files)

if __name__=='__main__':
    build()

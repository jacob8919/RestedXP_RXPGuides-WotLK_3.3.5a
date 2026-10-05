import re, json, sys, os
S=os.path.dirname(os.path.abspath(__file__))
def lua_value(s, i):
    # returns (value, next_index)
    n=len(s)
    while i<n and s[i] in ' \t\r\n': i+=1
    c=s[i]
    if c=='{':
        i+=1; arr=[]; d={}
        while True:
            while i<n and s[i] in ' \t\r\n,': i+=1
            if s[i]=='}': i+=1; break
            if s[i]=='[':
                j=s.index(']',i); key=s[i+1:j].strip().strip('"\'')
                try: key=int(key)
                except: pass
                i=j+1
                while s[i] in ' =': i+=1
                v,i=lua_value(s,i); d[key]=v
            else:
                v,i=lua_value(s,i); arr.append(v)
        if d:
            if arr:
                for k,v in enumerate(arr): d[k+1]=v
            return d,i
        return arr,i
    if c in '"\'':
        q=c; j=i+1; out=[]
        while s[j]!=q:
            if s[j]=='\\': out.append(s[j+1]); j+=2; continue
            out.append(s[j]); j+=1
        return ''.join(out), j+1
    m=re.match(r'-?\d+\.?\d*(e-?\d+)?', s[i:])
    if m: 
        t=m.group(0); return (float(t) if ('.' in t or 'e' in t) else int(t)), i+len(t)
    if s.startswith('nil',i): return None,i+3
    if s.startswith('true',i): return True,i+4
    if s.startswith('false',i): return False,i+5
    raise ValueError('bad lua at %d: %r'%(i,s[i:i+40]))

def load(fname):
    out={}
    for line in open(S+'/'+fname,encoding='utf-8'):
        m=re.match(r'^\[(\d+)\] = (\{.*\}),?\s*$', line)
        if not m: continue
        try: out[int(m.group(1))]=lua_value(m.group(2),0)[0]
        except Exception as e: pass
    return out
if __name__=='__main__':
    npc=load('wotlkNpcDB.lua'); obj=load('wotlkObjectDB.lua'); item=load('wotlkItemDB.lua'); quest=load('wotlkQuestDB.lua')
    print(len(npc),len(obj),len(item),len(quest))
    json.dump({'npc':npc,'obj':obj,'item':item,'quest':quest}, open(S+'/questie.json','w'))

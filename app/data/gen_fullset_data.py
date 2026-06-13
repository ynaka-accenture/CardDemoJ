#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""J-CardDemo フルセット用テストデータ生成(全サブアプリ)。"""
import sys

SO, SI = b'\x0e', b'\x0f'
KANJI = {'田':(0x44,0x41),'中':(0x44,0x42),'山':(0x44,0x43),'本':(0x44,0x44),
         '佐':(0x44,0x45),'藤':(0x44,0x46),'東':(0x45,0x41),'京':(0x45,0x42),
         '都':(0x45,0x43),'区':(0x45,0x44),'外':(0x6A,0x41)}

def mixed(kanji, width, malformed=False):
    b = bytearray(SO)
    for ch in kanji:
        hi,lo = KANJI.get(ch,(0x44,0x41)); b += bytes([hi,lo])
    if not malformed: b += SI
    while len(b) < width: b += b'\x40'
    return bytes(b[:width])

def sbcs(s,w): 
    e = s.encode('latin-1','replace')[:w]; return e + b'\x40'*(w-len(e))
def num(n,w): return str(n).zfill(w).encode('ascii')

def gen_pauth(n):
    """IMS-DB2 与信: 178バイト。CIPAUDJY準拠。"""
    recs=[]
    for i in range(1,n+1):
        r=bytearray()
        r+=sbcs(f"4111{i:012d}",16)              # PA-CARD-NUM
        r+=sbcs("PURC",4)                          # AUTH-TYPE
        r+=sbcs("00",2)                            # RESP-CODE
        r+=b'\x00'*7                               # TRANSACTION-AMT COMP-3 S9(10)V99=7B
        r+=sbcs(f"MID{i}",15)                      # MERCHANT-ID
        r+=sbcs(f"SHOP{i}",22)                     # MERCHANT-NAME(英)
        r+=mixed('東京' if i%4 else '外区',40,malformed=(i%9==0))  # 漢字加盟店名
        r+=sbcs("CITY",13)                         # MERCHANT-CITY
        r+=mixed('都区',30)                        # 漢字所在地
        r+=sbcs("13",2)                            # STATE
        r+=b'\x40'*20                              # FILLER
        recs.append(bytes(r[:171]))
    open('pauthj.lseq','wb').write(b'\n'.join(recs)+b'\n')
    return len(recs)

def gen_acctmq(n):
    """VSAM-MQ 口座: 321バイト。CVACCMJY準拠。"""
    recs=[]
    for i in range(1,n+1):
        r=bytearray()
        r+=num(10000000000+i,11)                   # MQ-ACCT-ID
        r+=sbcs(f"YAMADA{i}",50)                    # MQ-CUST-NAME(英)
        r+=mixed('山田' if i%3 else '外田',40)     # 漢字氏名
        r+=sbcs(f"MSG BODY {i}",200)               # MQ-MSG-BODY
        r+=b'\x40'*20                              # FILLER
        recs.append(bytes(r[:321]))
    open('acctmqj.lseq','wb').write(b'\n'.join(recs)+b'\n')
    return len(recs)

def gen_trantype(n):
    """transaction-type-db2 取引タイプ: 160バイト。CVTRAJ6Y準拠。"""
    recs=[]
    descs=['田中本','山区都東京','佐藤','東京都区丁目本田中山','藤']  # 文字数いろいろ
    for i in range(1,n+1):
        r=bytearray()
        r+=sbcs(f"{i:02d}",2)                       # TRAN-TYPE
        r+=sbcs(f"TYPE DESC {i}",50)                # 英説明
        kanji=descs[(i-1)%len(descs)]
        r+=mixed(kanji,60)                          # 漢字説明(長短さまざま→桁あふれ誘発)
        r+=b'\x40'*48                              # FILLER
        recs.append(bytes(r[:160]))
    open('trantypej.lseq','wb').write(b'\n'.join(recs)+b'\n')
    return len(recs)

if __name__ == '__main__':
    which = sys.argv[1] if len(sys.argv)>1 else 'all'
    n = int(sys.argv[2]) if len(sys.argv)>2 else 20
    if which in ('pauth','all'): print('pauthj:', gen_pauth(n))
    if which in ('acctmq','all'): print('acctmqj:', gen_acctmq(n))
    if which in ('trantype','all'): print('trantypej:', gen_trantype(n))

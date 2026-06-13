#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
素朴なUTF-8一括変換が J-CardDemo データで破綻することを実証する。
各トラップごとに「単純変換 → 失敗の種類」を示す。
"""
import sys

SO, SI = 0x0e, 0x0f
GAIJI_HI = range(0x69, 0x80)
# デモ用 DBCS → 文字 の簡易マップ(gen_custj.py と対応)
DBCS_MAP = {
    (0x44,0x41):'田',(0x44,0x42):'中',(0x44,0x43):'山',(0x44,0x44):'本',
    (0x44,0x45):'佐',(0x44,0x46):'藤',(0x45,0x41):'東',(0x45,0x42):'京',
    (0x45,0x43):'都',(0x45,0x44):'区',(0x45,0x45):'丁',(0x45,0x46):'目',
    (0x6A,0x41):'\ue000',  # 外字 → PUA
}

def naive_utf8(field: bytes):
    """素朴: バイトをそのまま latin-1 で文字列化して UTF-8 出力。
    SO/SI もそのまま残り、DBCS は2バイトが別々の文字に化ける。"""
    return field.decode('latin-1').encode('utf-8')

def proper_jef_to_utf8(field: bytes):
    """正しい: SO/SI を解釈し DBCS を文字へ写像。外字/不整合を検出。"""
    out = []
    i = 0; in_dbcs = False; gaiji = False; malformed = False
    n = len(field)
    while i < n:
        b = field[i]
        if b == SO:
            if in_dbcs: malformed = True
            in_dbcs = True; i += 1
        elif b == SI:
            if not in_dbcs: malformed = True
            in_dbcs = False; i += 1
        elif in_dbcs:
            if i+1 >= n:
                malformed = True; i += 1; continue
            hi, lo = field[i], field[i+1]
            if hi in GAIJI_HI: gaiji = True
            ch = DBCS_MAP.get((hi,lo), '\ufffd')  # 未マップは置換文字
            out.append(ch); i += 2
        else:
            if b == 0x40: out.append(' ')          # EBCDIC space
            elif 0x20 <= b < 0x7f: out.append(chr(b))
            else: out.append('')                    # 制御等は捨てる
            i += 1
    if in_dbcs: malformed = True
    return ''.join(out).rstrip(), gaiji, malformed

def main():
    recs = [r for r in open('custj.lseq','rb').read().split(b'\n') if r]
    print("="*64)
    print(" 素朴なUTF-8一括変換 vs 正しいJEF対応変換 の比較")
    print("="*64)
    # 漢字姓フィールドの位置: ID(9)+FN(25)+MN(25)+LN(25) = 84 から 40バイト
    off, width = 84, 40
    naive_bad = 0; gaiji_total = 0; malform_total = 0
    samples = []
    for idx, r in enumerate(recs, 1):
        field = r[off:off+width]
        naive = naive_utf8(field)
        proper, gaiji, malformed = proper_jef_to_utf8(field)
        # 素朴変換にSO/SI制御文字が残るか
        has_ctrl = (SO in field or SI in field)
        naive_has_ctrl = (b'\x0e' in naive or b'\x0f' in naive)
        if naive_has_ctrl: naive_bad += 1
        if gaiji: gaiji_total += 1
        if malformed: malform_total += 1
        if idx <= 5 or gaiji or malformed:
            samples.append((idx, naive, proper, gaiji, malformed, naive_has_ctrl))

    print("\n[トラップ2/9] SO/SI制御コードの残存(素朴変換):")
    print(f"  {naive_bad}/{len(recs)} 件で SO(0x0E)/SI(0x0F) が制御文字として残存")
    print("  → UTF-8テキストにゴミ制御文字が混入。表示・検索・突合が破綻")

    print("\n[サンプル] (id / 素朴変換hex先頭 / 正しい変換 / 外字 / 不整合)")
    for idx, naive, proper, g, m, nc in samples[:8]:
        nh = naive[:12].hex()
        flags = ('外字' if g else '') + (' 不整合' if m else '')
        print(f"  #{idx:03d} naive=0x{nh}.. proper='{proper}' {flags}")

    print(f"\n[トラップ4] 外字(PUA退避必要): {gaiji_total} 件")
    print(f"[トラップ9] SO/SI不整合(変換例外/破損): {malform_total} 件")

    # トラップ1: バイト長超過の実証
    print("\n[トラップ1] 固定バイト幅 vs UTF-8多バイト:")
    worst = max(recs, key=lambda r: len(proper_jef_to_utf8(r[off:off+width])[0].encode('utf-8')))
    p,_,_ = proper_jef_to_utf8(worst[off:off+width])
    u8len = len(p.encode('utf-8'))
    print(f"  X(40)=40バイト固定。正変換後の文字列 '{p}' は UTF-8で {u8len} バイト想定。")
    print(f"  漢字が増えるほど 40バイト枠を超過 → レコードレイアウト破綻。")

    print("\n" + "="*64)
    print(" 結論: 単バイト前提の一括UTF-8変換は日本語フィールドで破綻する。")
    print(" SO/SI解釈・外字PUA退避・不整合検出・フィールド幅再設計が必須。")
    print("="*64)

if __name__ == '__main__':
    main()

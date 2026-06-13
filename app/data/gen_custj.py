#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
J-CardDemo 顧客テストデータ生成。
EBCDIC-JEFモデルを模し、SO(0x0E)/SI(0x0F)で囲んだDBCS混在フィールドを作る。
各トラップを意図的に埋め込む。レコードは651バイト固定(CVCUSJ1Y準拠)。

DBCSコード化方針(デモ用簡易JEF):
  漢字1文字 = 2バイト。上位/下位バイトを 0x41-0x7E の範囲で割当。
  外字(T4)は上位バイト 0x69-0x7F を使用。
"""
SO = b'\x0e'
SI = b'\x0f'

def dbcs_char(hi, lo):
    return bytes([hi, lo])

# デモ用の漢字「コード」(実際のJEFではないが2バイト構造を再現)
KANJI = {
    '田': (0x44, 0x41), '中': (0x44, 0x42), '山': (0x44, 0x43),
    '本': (0x44, 0x44), '佐': (0x44, 0x45), '藤': (0x44, 0x46),
    '東': (0x45, 0x41), '京': (0x45, 0x42), '都': (0x45, 0x43),
    '区': (0x45, 0x44), '丁': (0x45, 0x45), '目': (0x45, 0x46),
    '外': (0x6A, 0x41),  # T4: 外字領域(上位0x6A)
}
KANA_HALF = {  # T7: 半角カナ JIS X 0201 (0xA1-0xDF)
    'ｱ': 0xB1, 'ｲ': 0xB2, 'ｳ': 0xB3, 'ﾀ': 0xC0, 'ﾅ': 0xC5,
}
DBCS_SPACE = bytes([0x40, 0x40])  # T8: DBCS空白(EBCDIC)

def mixed_field(kanji_str, width, *, malformed=False, dbcs_pad=False):
    """漢字文字列をSO..SIで囲んだ混在フィールド(width固定)へ。"""
    body = bytearray()
    body += SO
    for ch in kanji_str:
        hi, lo = KANJI.get(ch, (0x44, 0x41))
        body += dbcs_char(hi, lo)
    if not malformed:
        body += SI
    # T9: malformed=True のとき SI を付けない(不整合)
    # パディング
    if dbcs_pad:
        # T8: DBCS空白で埋める(SO..SIの外側に)
        while len(body) + 2 <= width:
            body += DBCS_SPACE
        while len(body) < width:
            body += b'\x40'  # EBCDIC space
    else:
        while len(body) < width:
            body += b'\x40'  # EBCDIC single-byte space
    return bytes(body[:width])

def sbcs(s, width):
    b = s.encode('latin-1', 'replace')[:width]
    return b + b'\x40' * (width - len(b))

def num(n, width):
    return str(n).zfill(width).encode('ascii')

def hankana(chars, width):  # T7
    b = bytearray()
    for c in chars:
        b.append(KANA_HALF.get(c, 0x40))
    while len(b) < width:
        b.append(0x40)
    return bytes(b[:width])

def yen_amount(n, width):  # T6: 円記号(単バイト0x5C)
    s = b'\x5c' + str(n).encode('ascii')  # 0x5C = ¥(JIS) / \(ASCII)
    return s + b'\x40' * (width - len(s))

def build_record(i):
    rec = bytearray()
    rec += num(i, 9)                                    # CUST-ID
    rec += sbcs(f"TARO{i}", 25)                          # FIRST-NAME
    rec += sbcs("", 25)                                  # MIDDLE-NAME
    rec += sbcs(f"YAMADA{i}", 25)                        # LAST-NAME
    # T1/T2/T4: 漢字姓(40バイト)。一部レコードに外字、一部にmalformed
    last_kanji = '山田' if i % 5 else '外田'             # T4: 5件に1件 外字
    rec += mixed_field(last_kanji, 40,
                       malformed=(i % 7 == 0),           # T9: 7件に1件 不整合
                       dbcs_pad=(i % 2 == 0))            # T8: 偶数 DBCS空白
    rec += mixed_field('田中', 40)                       # 漢字名
    # T3: カナ氏名 PIC N(20)=DBCS20文字=40バイト相当(ここでは簡易にDBCS)
    rec += mixed_field('山田', 40)[:40]                  # KANA-LAST (N20想定)
    rec += mixed_field('田中', 40)[:40]                  # KANA-FIRST
    rec += sbcs(f"{i} MAIN ST", 50)                      # ADDR-1
    rec += sbcs("", 50)                                  # ADDR-2
    # T1/T2/T5: 漢字住所(波ダッシュ含意)
    rec += mixed_field('東京都区', 60)                   # KANJI-ADDR-1
    rec += mixed_field('丁目', 60)                       # KANJI-ADDR-2
    rec += sbcs("13", 2)                                 # STATE
    rec += sbcs("JPN", 3)                                # COUNTRY
    rec += sbcs("100-0001", 10)                          # ZIP
    rec += hankana('ﾀﾅ', 30)                             # T7: 半角カナ備考
    rec += sbcs("03-1234-5678", 15)                      # PHONE-1
    rec += sbcs("", 15)                                  # PHONE-2
    rec += num(100000000 + i, 9)                         # SSN
    rec += sbcs("DL12345", 20)                           # GOVT-ID
    rec += sbcs("1980-01-01", 10)                        # DOB
    rec += sbcs("", 10)                                  # EFT-ACCT
    rec += sbcs("Y", 1)                                  # PRI-IND
    rec += num(700, 3)                                   # FICO
    rec += b'\x40' * 50                                  # FILLER
    return bytes(rec)

def main():
    import sys
    n = int(sys.argv[1]) if len(sys.argv) > 1 else 50
    recs = [build_record(i) for i in range(1, n + 1)]
    # LINE SEQUENTIAL: 各レコード + 改行。バイトをそのまま書く(latin-1透過)
    with open('custj.lseq', 'wb') as f:
        for r in recs:
            f.write(r)
            f.write(b'\n')
    print(f"written {len(recs)} records, {len(recs[0])} bytes each")
    # 検証用メタ情報
    gaiji = sum(1 for i in range(1, n+1) if i % 5 == 0)
    malform = sum(1 for i in range(1, n+1) if i % 7 == 0)
    print(f"expected gaiji records: {gaiji}, malformed records: {malform}")

if __name__ == '__main__':
    main()

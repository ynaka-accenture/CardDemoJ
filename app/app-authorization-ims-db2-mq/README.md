# 与信(IMS-DB2-MQ)オプション(日本版CardDemo)

与信明細を IMS-DB2 で管理するオプションアプリケーションの日本語版。

## 日本語化の焦点: DB2/IMS CCSID境界

与信明細の加盟店名を漢字対応にし、IMSセグメント・DB2列に格納する。
- DB2列のCCSID(EBCDIC混在)とUTF-8(CCSID1208)の不一致が移行論点
- IMSセグメントの漢字フィールドはバイト列として透過格納され、
  文字コード変換はアプリ層の責務(DBD定義では表現されない)

## プログラム
- CBPAUJ0C — 与信明細バッチ(英字名・実行可能)
- COPAUJA0/S0/S1/S2 — 与信応答・照会
- PAUDBJLD/JUL — 与信DBロード/アンロード

## IMS定義
- ims/DBPAUJP0.dbd — 与信DB DBD(漢字加盟店名セグメント KJMRCHNM, BYTES=280)
- ims/PSBPAUJB.psb — 与信DB PSB

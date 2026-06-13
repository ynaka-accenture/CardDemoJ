       IDENTIFICATION DIVISION.
       PROGRAM-ID. COACMJ01.
       AUTHOR. 日本版CardDemo.
      ******************************************************************
      * 日本版CardDemo - 口座照会MQ連携 (原 COACCT01 の日本語化)
      *
      * 口座に紐づく顧客の漢字氏名を MQ メッセージ本文へ組み立て、
      * 応答キューへ送出する。MQ MD(メッセージ記述子)の CodedCharSetId
      * (CCSID)を明示し、文字コード変換境界を可視化する。
      *
      * 日本語化トラップ(MQ CCSID境界):
      *   - 送信側が CCSID=930(EBCDIC日本語)のまま PUT すると、
      *     受信側が UTF-8(CCSID=1208)基盤の場合、MQGMO-CONVERT による
      *     変換が必要。変換テーブル不備で外字・波ダッシュが化ける。
      *   - SO/SI を含む混在データは、CCSID変換でシフトコードが
      *     除去されるか残存するかがキューマネージャ設定に依存する。
      ******************************************************************
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
      *    MQ 定数コピー句(本番では COPY CMQV / CMQODV / CMQMDV)
       01  MQ-定数.
           05  MQOO-OUTPUT             PIC S9(9) BINARY VALUE 16.
           05  MQOO-INPUT-SHARED       PIC S9(9) BINARY VALUE 2.
           05  MQPMO-NO-SYNCPOINT      PIC S9(9) BINARY VALUE 4.
           05  MQCC-OK                 PIC S9(9) BINARY VALUE 0.
      *    CCSID: 930=EBCDIC日本語(カタカナ), 939=EBCDIC日本語(英小文字),
      *           5035=EBCDIC日本語(拡張), 1208=UTF-8, 943=Shift-JIS
           05  CCSID-EBCDIC-JP         PIC S9(9) BINARY VALUE 930.
           05  CCSID-UTF8              PIC S9(9) BINARY VALUE 1208.
      *    メッセージ記述子(MQMD)の主要項目を抜粋
       01  メッセージ記述子.
           05  MD-構造ID               PIC X(4)  VALUE 'MD  '.
           05  MD-バージョン           PIC S9(9) BINARY VALUE 2.
           05  MD-書式                 PIC X(8)  VALUE 'MQSTR   '.
      *        ★文字コード境界の核心: 送信メッセージの CCSID
           05  MD-文字コードID         PIC S9(9) BINARY.
       01  接続ハンドル                PIC S9(9) BINARY.
       01  オブジェクトハンドル        PIC S9(9) BINARY.
       01  完了コード                  PIC S9(9) BINARY.
       01  理由コード                  PIC S9(9) BINARY.
       01  メッセージ長                PIC S9(9) BINARY.
      *    メッセージ本文(漢字氏名を含む)
       01  メッセージ本文.
           05  本文-口座番号           PIC X(11).
           05  本文-漢字氏名           PIC X(40).
           05  本文-メッセージ         PIC X(200).
       01  キュー名                    PIC X(48) VALUE
           'CARDDEMO.ACCT.REPLY                             '.
       PROCEDURE DIVISION.
       主処理.
      *    1. キューマネージャへ接続(本番では MQCONN)
           PERFORM 接続処理
      *    2. 応答キューをオープン(本番では MQOPEN)
           PERFORM オープン処理
      *    3. 漢字氏名を含むメッセージを組み立て送出
           PERFORM メッセージ送出処理
      *    4. クローズ・切断
           PERFORM 終了処理
           STOP RUN.

       接続処理.
      *    CALL 'MQCONN' USING キューマネージャ名 接続ハンドル
      *                        完了コード 理由コード
           MOVE 0 TO 完了コード.

       オープン処理.
      *    CALL 'MQOPEN' USING 接続ハンドル オブジェクト記述子
      *                        MQOO-OUTPUT オブジェクトハンドル
      *                        完了コード 理由コード
           MOVE 0 TO 完了コード.

       メッセージ送出処理.
      *    ★ CCSID境界: 送信時に EBCDIC日本語(930)を設定。
      *       受信側がUTF-8(1208)なら MQGMO-CONVERT で変換が必要。
           MOVE CCSID-EBCDIC-JP TO MD-文字コードID
      *    漢字氏名は SO..SI 混在のバイト列として本文へ格納
           MOVE '00000000123'          TO 本文-口座番号
      *        (漢字氏名は上流の顧客レコードから受領した混在バイト列)
           MOVE SPACE                  TO 本文-漢字氏名
           MOVE '口座照会応答'         TO 本文-メッセージ
      *    CALL 'MQPUT' USING 接続ハンドル オブジェクトハンドル
      *                       メッセージ記述子 PUTオプション
      *                       メッセージ長 メッセージ本文
      *                       完了コード 理由コード
           IF 完了コード = MQCC-OK
               DISPLAY 'MQPUT 成功 CCSID=' MD-文字コードID
           END-IF.

       終了処理.
      *    CALL 'MQCLOSE' / 'MQDISC'
           CONTINUE.

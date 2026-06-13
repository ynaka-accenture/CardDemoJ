       IDENTIFICATION DIVISION.
       PROGRAM-ID. COACVJWC.
       AUTHOR. 日本版CardDemo.
      ******************************************************************
      * 口座照会 オンラインプログラム(日本版・CICS)
      * 原 COACTVWC の日本語化。BMS マップ COACVJW を介して、
      * 口座に紐づく顧客の漢字氏名・漢字住所・円記号残高を表示する。
      *
      * 日本語オンライン処理の要点:
      *   - RECEIVE MAP で受け取った漢字フィールドは SO/SI 混在バイト列
      *   - 表示前に 漢字解析(JCKANJ0C)で有効文字数・外字・不整合を検証
      *   - SEND MAP で DBCS 属性フィールドへ漢字を送出(端末が SO/SI 解釈)
      *   - UTF-8 基盤の画面エミュレータへ移行する際、全角=2カラムの
      *     桁計算と SO/SI 制御の扱いが BMS と異なり再設計が必要(T1/T2)
      ******************************************************************
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-PROGRAM-ID            PIC X(8) VALUE 'COACVJWC'.
       01  WS-TRANID                PIC X(4) VALUE 'CAVJ'.
       01  WS-MAPNAME               PIC X(7) VALUE 'COACVJW'.
       01  WS-MAPSET                PIC X(7) VALUE 'COACVJW'.
       01  WS-RESP                  PIC S9(8) COMP.
       01  WS-CUST-FILE             PIC X(8) VALUE 'CUSTJ   '.

      *    顧客レコード(漢字フィールドを含む)
       COPY CVCUSJ1Y.
      *    共通JEF定義 + 漢字解析パラメタ
       COPY CSJEFCHY.

      *    表示編集
       01  WS-DISP-BAL              PIC X(15).
       01  WS-MSG                   PIC X(78).

      *    BMS マップ DSECT(本番では COPY COACVJW)
       01  COACVJI.
           05  ACCTIDI              PIC X(11).
           05  KJNAMEI              PIC X(40).
           05  KANAMEI              PIC X(40).
           05  KJADDR1I             PIC X(60).
           05  KJADDR2I             PIC X(60).
           05  CURBALO              PIC X(15).
           05  KJNAMEO              PIC X(40).
           05  KJADDR1O             PIC X(60).
           05  ERRMSGO              PIC X(78).

       PROCEDURE DIVISION.
       0000-主処理.
      *    EXEC CICS RECEIVE MAP(WS-MAPNAME) MAPSET(WS-MAPSET)
      *              INTO(COACVJI) RESP(WS-RESP) END-EXEC
           PERFORM 1000-口座読込
           PERFORM 2000-漢字検証
           PERFORM 3000-画面編集
      *    EXEC CICS SEND MAP(WS-MAPNAME) MAPSET(WS-MAPSET)
      *              FROM(COACVJI) ERASE RESP(WS-RESP) END-EXEC
      *    EXEC CICS RETURN TRANSID(WS-TRANID) END-EXEC
           GOBACK.

       1000-口座読込.
      *    口座番号で顧客マスタを READ(本番は VSAM KSDS)
      *    EXEC CICS READ FILE(WS-CUST-FILE) INTO(CUSTOMER-J-RECORD)
      *              RIDFLD(ACCTIDI) RESP(WS-RESP) END-EXEC
           CONTINUE.

       2000-漢字検証.
      *    漢字氏名の有効文字数・外字・不整合を検証
           MOVE CUST-KANJI-LAST-NAME TO JCK-FIELD
           MOVE 40 TO JCK-FIELD-LEN
           CALL 'JCKANJ0C' USING JCK-PARM-AREA
           EVALUATE TRUE
               WHEN JCK-MALFORMED = 'Y'
                   MOVE 'SOSI不整合'
                        TO WS-MSG
               WHEN JCK-GAIJI-FOUND = 'Y'
                   MOVE '外字あり'
                        TO WS-MSG
               WHEN OTHER
                   MOVE SPACES TO WS-MSG
           END-EVALUATE.

       3000-画面編集.
      *    漢字氏名・住所を DBCS フィールドへ
           MOVE CUST-KANJI-LAST-NAME TO KJNAMEO
           MOVE CUST-KANJI-ADDR-1    TO KJADDR1O
      *    残高に円記号を付与(T6: 単バイト 0x5C)
           STRING JEF-YEN-SIGN DELIMITED BY SIZE
                  '1,234,567'   DELIMITED BY SIZE
                  INTO WS-DISP-BAL
           MOVE WS-DISP-BAL TO CURBALO
           MOVE WS-MSG      TO ERRMSGO.

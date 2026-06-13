       IDENTIFICATION DIVISION.
       PROGRAM-ID. COTRTJLI.
       AUTHOR. 日本版CardDemo.
      ******************************************************************
      * 取引タイプ一覧 オンラインプログラム(日本版・CICS)
      * 取引タイプの漢字説明を一覧表示する
      * BMS マップ COTRTJL を介し、漢字フィールドを DBCS 属性で表示/入力。
      *
      * 日本語オンライン処理の要点:
      *   - 受信した漢字フィールドは SO/SI 混在バイト列
      *   - 表示/登録前に 漢字解析(JCKANJ0C)で文字数・外字・不整合を検証
      *   - UTF-8 基盤への移行時、全角=2カラムの桁計算と SO/SI 制御の
      *     扱いが BMS と異なり再設計が必要(トラップ T1/T2)
      ******************************************************************
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-PROGRAM-ID            PIC X(8) VALUE 'COTRTJLI'.
       01  WS-TRANID                PIC X(4) VALUE 'CL00'.
       01  WS-MAPNAME               PIC X(7) VALUE 'COTRTJL'.
       01  WS-RESP                  PIC S9(8) COMP.
       01  WS-MSG                   PIC X(78).
       COPY CVTRAJ6Y.
       COPY CSJEFCHY.
       PROCEDURE DIVISION.
       0000-主処理.
      *    EXEC CICS RECEIVE MAP(WS-MAPNAME) RESP(WS-RESP) END-EXEC
           PERFORM 1000-業務処理
           PERFORM 2000-漢字検証
      *    EXEC CICS SEND MAP(WS-MAPNAME) ERASE RESP(WS-RESP) END-EXEC
      *    EXEC CICS RETURN TRANSID(WS-TRANID) END-EXEC
           GOBACK.
       1000-業務処理.
      *    READ/WRITE 等の業務処理(本番は VSAM/DB2/IMS アクセス)
           CONTINUE.
       2000-漢字検証.
      *    漢字フィールドの SO/SI 解析(有効文字数・外字・不整合)
           MOVE TRAN-TYPE-KANJI-DESC TO JCK-FIELD
           MOVE 40 TO JCK-FIELD-LEN
           CALL 'JCKANJ0C' USING JCK-PARM-AREA
           EVALUATE TRUE
               WHEN JCK-MALFORMED = 'Y'
                   MOVE 'SOSI不整合' TO WS-MSG
               WHEN JCK-GAIJI-FOUND = 'Y'
                   MOVE '外字あり' TO WS-MSG
               WHEN OTHER
                   MOVE SPACES TO WS-MSG
           END-EVALUATE.

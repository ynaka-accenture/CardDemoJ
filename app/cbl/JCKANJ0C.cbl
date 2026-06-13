       IDENTIFICATION DIVISION.
       PROGRAM-ID. JCKANJ0C.
      ******************************************************************
      * J-CardDemo 漢字ユーティリティ
      * SO(0x0E)/SI(0x0F)混在フィールドの有効文字数計算と外字検出。
      *
      * このプログラムは「混在フィールドの文字数は単純な LENGTH では
      * 求まらない」という日本語固有の難しさ(トラップ2)を体現する。
      * 素朴な UTF-8 一括変換ではこのロジックが意味を失う。
      *
      * 呼出: CALL 'JCKANJ0C' USING JCK-PARM
      ******************************************************************
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-SO                   PIC X VALUE X'0E'.
       01  WS-SI                   PIC X VALUE X'0F'.
       01  WS-IDX                  PIC 9(04) COMP.
       01  WS-IN-DBCS              PIC X VALUE 'N'.
       01  WS-BYTE                 PIC X.
       01  WS-DBCS-HI              PIC X.
       01  WS-DBCS-LO              PIC X.
      * 外字(JEF利用者定義領域)の判定境界(例: 上位バイト 0x69-0x7F)
       01  WS-GAIJI-LO             PIC X VALUE X'69'.
       01  WS-GAIJI-HI             PIC X VALUE X'7F'.
       LINKAGE SECTION.
       01  JCK-PARM.
           05  JCK-FIELD           PIC X(80).
           05  JCK-FIELD-LEN       PIC 9(04) COMP.
           05  JCK-SBCS-COUNT      PIC 9(04) COMP.
           05  JCK-DBCS-COUNT      PIC 9(04) COMP.
           05  JCK-GAIJI-FOUND     PIC X.
           05  JCK-MALFORMED       PIC X.
       PROCEDURE DIVISION USING JCK-PARM.
       0000-MAIN.
           MOVE 0   TO JCK-SBCS-COUNT
           MOVE 0   TO JCK-DBCS-COUNT
           MOVE 'N' TO JCK-GAIJI-FOUND
           MOVE 'N' TO JCK-MALFORMED
           MOVE 'N' TO WS-IN-DBCS
           MOVE 1   TO WS-IDX
           PERFORM UNTIL WS-IDX > JCK-FIELD-LEN
               MOVE JCK-FIELD(WS-IDX:1) TO WS-BYTE
               EVALUATE TRUE
      *        --- SO: DBCS区間開始 ---
                   WHEN WS-BYTE = WS-SO
                       IF WS-IN-DBCS = 'Y'
      *                    T9: SOの中でさらにSO=不整合
                           MOVE 'Y' TO JCK-MALFORMED
                       END-IF
                       MOVE 'Y' TO WS-IN-DBCS
                       ADD 1 TO WS-IDX
      *        --- SI: DBCS区間終了 ---
                   WHEN WS-BYTE = WS-SI
                       IF WS-IN-DBCS = 'N'
      *                    T9: SOなしのSI=不整合
                           MOVE 'Y' TO JCK-MALFORMED
                       END-IF
                       MOVE 'N' TO WS-IN-DBCS
                       ADD 1 TO WS-IDX
      *        --- DBCS区間内: 2バイトで1文字 ---
                   WHEN WS-IN-DBCS = 'Y'
                       IF WS-IDX + 1 > JCK-FIELD-LEN
      *                    T9: 奇数バイトでDBCSが途切れる
                           MOVE 'Y' TO JCK-MALFORMED
                           ADD 1 TO WS-IDX
                       ELSE
                           MOVE JCK-FIELD(WS-IDX:1)   TO WS-DBCS-HI
                           MOVE JCK-FIELD(WS-IDX + 1:1) TO WS-DBCS-LO
                           ADD 1 TO JCK-DBCS-COUNT
      *                    T4: 外字判定(上位バイトが利用者定義領域)
                           IF WS-DBCS-HI >= WS-GAIJI-LO
                              AND WS-DBCS-HI <= WS-GAIJI-HI
                               MOVE 'Y' TO JCK-GAIJI-FOUND
                           END-IF
                           ADD 2 TO WS-IDX
                       END-IF
      *        --- SBCS区間: 1バイトで1文字 ---
                   WHEN OTHER
                       ADD 1 TO JCK-SBCS-COUNT
                       ADD 1 TO WS-IDX
               END-EVALUATE
           END-PERFORM
      *    区間が閉じずに終了=不整合(T9)
           IF WS-IN-DBCS = 'Y'
               MOVE 'Y' TO JCK-MALFORMED
           END-IF
           GOBACK.

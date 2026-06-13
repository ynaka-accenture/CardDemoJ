       IDENTIFICATION DIVISION.
       PROGRAM-ID. 漢字解析.
       AUTHOR. 日本版CardDemo.
      ******************************************************************
      * 漢字解析サブルーチン(日本語データ名版)
      *
      * SO(0x0E)/SI(0x0F)で囲まれた混在フィールドの有効文字数を計算し、
      * 外字(利用者定義文字)の有無・SO/SI不整合を検出する。
      *
      * 「混在フィールドの文字数は単純な LENGTH では求まらない」という
      * 日本語固有の難しさ(トラップT2)を体現する共通部品。
      * 全ての日本語化プログラムから CALL '漢字解析' で呼び出される。
      *
      * IBM Enterprise COBOL for z/OS の DBCS 利用者語を用いた本番ソース。
      * 実行検証は英字名版(JCKANJ0C.cbl)で行う。
      ******************************************************************
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  シフトアウト              PIC X VALUE X'0E'.
       01  シフトイン                PIC X VALUE X'0F'.
       01  添字                      PIC 9(04) COMP.
       01  漢字区間フラグ            PIC X VALUE 'N'.
       01  対象バイト                PIC X.
       01  漢字上位バイト            PIC X.
      *    外字(利用者定義)領域: 上位バイト 0x69-0x7F
       01  外字下限                  PIC X VALUE X'69'.
       01  外字上限                  PIC X VALUE X'7F'.
       LINKAGE SECTION.
       01  漢字解析パラメタ.
           05  解析対象フィールド    PIC X(80).
           05  解析対象長            PIC 9(04) COMP.
           05  単バイト文字数        PIC 9(04) COMP.
           05  漢字文字数            PIC 9(04) COMP.
           05  外字検出フラグ        PIC X.
           05  不整合フラグ          PIC X.
       PROCEDURE DIVISION USING 漢字解析パラメタ.
       主処理.
           MOVE 0   TO 単バイト文字数
           MOVE 0   TO 漢字文字数
           MOVE 'N' TO 外字検出フラグ
           MOVE 'N' TO 不整合フラグ
           MOVE 'N' TO 漢字区間フラグ
           MOVE 1   TO 添字
           PERFORM UNTIL 添字 > 解析対象長
               MOVE 解析対象フィールド(添字:1) TO 対象バイト
               EVALUATE TRUE
      *        --- シフトアウト: 漢字区間開始 ---
                   WHEN 対象バイト = シフトアウト
                       IF 漢字区間フラグ = 'Y'
                           MOVE 'Y' TO 不整合フラグ
                       END-IF
                       MOVE 'Y' TO 漢字区間フラグ
                       ADD 1 TO 添字
      *        --- シフトイン: 漢字区間終了 ---
                   WHEN 対象バイト = シフトイン
                       IF 漢字区間フラグ = 'N'
                           MOVE 'Y' TO 不整合フラグ
                       END-IF
                       MOVE 'N' TO 漢字区間フラグ
                       ADD 1 TO 添字
      *        --- 漢字区間内: 2バイトで1文字 ---
                   WHEN 漢字区間フラグ = 'Y'
                       IF 添字 + 1 > 解析対象長
                           MOVE 'Y' TO 不整合フラグ
                           ADD 1 TO 添字
                       ELSE
                           MOVE 解析対象フィールド(添字:1)
                                TO 漢字上位バイト
                           ADD 1 TO 漢字文字数
      *                    外字判定(上位バイトが利用者定義領域)
                           IF 漢字上位バイト >= 外字下限
                              AND 漢字上位バイト <= 外字上限
                               MOVE 'Y' TO 外字検出フラグ
                           END-IF
                           ADD 2 TO 添字
                       END-IF
      *        --- 単バイト区間: 1バイトで1文字 ---
                   WHEN OTHER
                       ADD 1 TO 単バイト文字数
                       ADD 1 TO 添字
               END-EVALUATE
           END-PERFORM
      *    区間が閉じずに終了=不整合
           IF 漢字区間フラグ = 'Y'
               MOVE 'Y' TO 不整合フラグ
           END-IF
           GOBACK.

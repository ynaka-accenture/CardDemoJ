       IDENTIFICATION DIVISION.
       PROGRAM-ID. 顧客帳票.
       AUTHOR. 日本版CardDemo.
      ******************************************************************
      * 顧客帳票作成プログラム(日本語データ名版)
      *
      * 顧客ファイル(漢字氏名・漢字住所を含む)を読み込み、漢字フィールドの
      * 有効文字数・外字有無・SO/SI不整合を判定して帳票を出力する。
      *
      * IBM Enterprise COBOL for z/OS の DBCS 利用者語を用いた本番ソース。
      * データ項目名・段落名・コメントをすべて日本語化している。
      *
      * ※GnuCOBOLは多バイトデータ名・多バイトプログラム名に非対応のため、
      *   実行検証は英字名版(CBCUSJ1C.cbl)で行う。本ファイルは本番表現。
      ******************************************************************
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT 顧客ファイル ASSIGN TO "custj.lseq"
                  ORGANIZATION IS LINE SEQUENTIAL
                  FILE STATUS  IS 顧客ファイル状態.
           SELECT 帳票ファイル ASSIGN TO "custjrpt.out"
                  ORGANIZATION IS LINE SEQUENTIAL.
       DATA DIVISION.
       FILE SECTION.
       FD  顧客ファイル.
       01  顧客レコード入力域            PIC X(642).
       FD  帳票ファイル.
       01  帳票レコード                  PIC X(160).

       WORKING-STORAGE SECTION.
       COPY 顧客レコード.

       01  顧客ファイル状態              PIC X(02).
       01  終了フラグ                    PIC X VALUE 'N'.
       01  顧客件数                      PIC 9(06) VALUE 0.
       01  外字件数                      PIC 9(06) VALUE 0.
       01  不整合件数                    PIC 9(06) VALUE 0.

      *    漢字ユーティリティ呼出域(SO/SI解析)
       01  漢字解析パラメタ.
           05  解析対象フィールド        PIC X(80).
           05  解析対象長                PIC 9(04) COMP.
           05  単バイト文字数            PIC 9(04) COMP.
           05  漢字文字数                PIC 9(04) COMP.
           05  外字検出フラグ            PIC X.
           05  不整合フラグ              PIC X.

       01  帳票明細.
           05  明細-顧客番号             PIC 9(09).
           05  FILLER                    PIC X VALUE '|'.
           05  明細-漢字文字数           PIC ZZ9.
           05  FILLER                    PIC X VALUE '|'.
           05  明細-外字                 PIC X.
           05  FILLER                    PIC X VALUE '|'.
           05  明細-不整合               PIC X.
       01  帳票合計.
           05  FILLER       PIC X(12) VALUE '合計|件数='.
           05  合計-件数    PIC 9(06).
           05  FILLER       PIC X(8)  VALUE '|外字='.
           05  合計-外字    PIC 9(06).
           05  FILLER       PIC X(10) VALUE '|不整合='.
           05  合計-不整合  PIC 9(06).

       PROCEDURE DIVISION.
       主処理.
           OPEN INPUT 顧客ファイル
           OPEN OUTPUT 帳票ファイル
           PERFORM UNTIL 終了フラグ = 'Y'
               READ 顧客ファイル INTO 顧客レコード
                   AT END
                       MOVE 'Y' TO 終了フラグ
                   NOT AT END
                       PERFORM 顧客明細処理
               END-READ
           END-PERFORM
           MOVE 顧客件数   TO 合計-件数
           MOVE 外字件数   TO 合計-外字
           MOVE 不整合件数 TO 合計-不整合
           WRITE 帳票レコード FROM 帳票合計
           CLOSE 顧客ファイル 帳票ファイル
           STOP RUN.

       顧客明細処理.
           ADD 1 TO 顧客件数
      *    漢字姓フィールドを解析(SO/SI混在の有効文字数・外字・不整合)
           MOVE 漢字姓 TO 解析対象フィールド
           MOVE 40 TO 解析対象長
           CALL '漢字解析' USING 漢字解析パラメタ
           IF 外字検出フラグ = 'Y'
               ADD 1 TO 外字件数
           END-IF
           IF 不整合フラグ = 'Y'
               ADD 1 TO 不整合件数
           END-IF
           MOVE 顧客番号       TO 明細-顧客番号
           MOVE 漢字文字数     TO 明細-漢字文字数
           MOVE 外字検出フラグ TO 明細-外字
           MOVE 不整合フラグ   TO 明細-不整合
           WRITE 帳票レコード FROM 帳票明細.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. CBCUSJ1C.
       AUTHOR. J-CardDemo.
      ******************************************************************
      * 日本版 顧客レポート (原 CBCUS01C の日本語拡張)
      * 顧客ファイル(漢字氏名・住所を含む)を読み、漢字フィールドの
      * 有効文字数・外字有無・不整合を JCKANJ0C で判定して帳票出力する。
      *
      * 実演テストベッドとして GnuCOBOL で動くよう LINE SEQUENTIAL を採用。
      * トラップ T1/T2/T4/T8/T9 を実処理で扱う。
      ******************************************************************
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT CUSTFILE-FILE ASSIGN TO "custj.lseq"
                  ORGANIZATION IS LINE SEQUENTIAL
                  FILE STATUS  IS CUSTFILE-STATUS.
           SELECT REPORT-FILE ASSIGN TO "custjrpt.out"
                  ORGANIZATION IS LINE SEQUENTIAL.
       DATA DIVISION.
       FILE SECTION.
       FD  CUSTFILE-FILE.
       01  FD-CUST-REC                 PIC X(642).
       FD  REPORT-FILE.
       01  REPORT-REC                  PIC X(160).

       WORKING-STORAGE SECTION.
       COPY CVCUSJ1Y.

       01  CUSTFILE-STATUS             PIC X(02).
       01  WS-EOF                      PIC X VALUE 'N'.
       01  WS-CUST-CNT                 PIC 9(06) VALUE 0.
       01  WS-GAIJI-CNT                PIC 9(06) VALUE 0.
       01  WS-MALFORM-CNT              PIC 9(06) VALUE 0.

      * JCKANJ0C 呼出パラメタ
       01  JCK-PARM.
           05  JCK-FIELD               PIC X(80).
           05  JCK-FIELD-LEN           PIC 9(04) COMP.
           05  JCK-SBCS-COUNT          PIC 9(04) COMP.
           05  JCK-DBCS-COUNT          PIC 9(04) COMP.
           05  JCK-GAIJI-FOUND         PIC X.
           05  JCK-MALFORMED           PIC X.

      * 帳票明細
       01  R-LINE.
           05  R-ID                    PIC 9(09).
           05  FILLER                  PIC X VALUE '|'.
           05  R-KANJI-CHARS           PIC ZZ9.
           05  FILLER                  PIC X VALUE '|'.
           05  R-GAIJI                 PIC X.
           05  FILLER                  PIC X VALUE '|'.
           05  R-MALFORM               PIC X.
       01  R-SUMMARY.
           05  FILLER       PIC X(12) VALUE 'SUMMARY|cnt='.
           05  RS-CNT       PIC 9(06).
           05  FILLER       PIC X(7)  VALUE '|gaiji='.
           05  RS-GAIJI     PIC 9(06).
           05  FILLER       PIC X(9)  VALUE '|malform='.
           05  RS-MALFORM   PIC 9(06).

       PROCEDURE DIVISION.
       0000-MAIN.
           OPEN INPUT CUSTFILE-FILE
           OPEN OUTPUT REPORT-FILE
           PERFORM UNTIL WS-EOF = 'Y'
               READ CUSTFILE-FILE INTO CUSTOMER-J-RECORD
                   AT END
                       MOVE 'Y' TO WS-EOF
                   NOT AT END
                       PERFORM 1000-PROCESS-CUST
               END-READ
           END-PERFORM
           MOVE WS-CUST-CNT    TO RS-CNT
           MOVE WS-GAIJI-CNT   TO RS-GAIJI
           MOVE WS-MALFORM-CNT TO RS-MALFORM
           WRITE REPORT-REC FROM R-SUMMARY
           CLOSE CUSTFILE-FILE REPORT-FILE
           STOP RUN.

       1000-PROCESS-CUST.
           ADD 1 TO WS-CUST-CNT
      *    漢字姓フィールドを解析(SO/SI混在)
           MOVE CUST-KANJI-LAST-NAME TO JCK-FIELD
           MOVE 40 TO JCK-FIELD-LEN
           CALL 'JCKANJ0C' USING JCK-PARM
           IF JCK-GAIJI-FOUND = 'Y'
               ADD 1 TO WS-GAIJI-CNT
           END-IF
           IF JCK-MALFORMED = 'Y'
               ADD 1 TO WS-MALFORM-CNT
           END-IF
           MOVE CUST-ID         TO R-ID
           MOVE JCK-DBCS-COUNT  TO R-KANJI-CHARS
           MOVE JCK-GAIJI-FOUND TO R-GAIJI
           MOVE JCK-MALFORMED   TO R-MALFORM
           WRITE REPORT-REC FROM R-LINE.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. CBTRNJ2C.
       AUTHOR. J-CardDemo.
      ******************************************************************
      * 日本版 取引分析バッチ (原 CBTRN02C の日本語拡張・抜粋)
      * 取引の漢字摘要・円記号金額・全角受付番号を扱い、
      * 「単バイト前提の数値/文字処理」が日本語データで破綻する箇所を示す。
      * トラップ T2/T6/T10 を実処理で扱う。
      ******************************************************************
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT TRANFILE ASSIGN TO "tranj.lseq"
                  ORGANIZATION IS LINE SEQUENTIAL
                  FILE STATUS  IS TRAN-STATUS.
           SELECT RPTFILE ASSIGN TO "tranjrpt.out"
                  ORGANIZATION IS LINE SEQUENTIAL.
       DATA DIVISION.
       FILE SECTION.
       FD  TRANFILE.
       01  FD-TRAN-REC               PIC X(60).
       FD  RPTFILE.
       01  RPT-REC                   PIC X(120).
       WORKING-STORAGE SECTION.
       01  TRAN-STATUS               PIC X(02).
       01  WS-EOF                    PIC X VALUE 'N'.
      * 簡易取引レコード(デモ用): ID + 円記号金額 + 全角受付番号
       01  WS-TRAN.
           05  WS-TR-ID              PIC X(16).
           05  WS-TR-YEN             PIC X(15).
           05  WS-TR-ZENKAKU-REF     PIC X(20).
           05  FILLER                PIC X(09).
       01  WS-YEN-SIGN               PIC X VALUE X'5C'.
       01  WS-CNT                    PIC 9(06) VALUE 0.
       01  WS-YEN-OK                 PIC 9(06) VALUE 0.
       01  WS-ZENKAKU-CNT            PIC 9(06) VALUE 0.
       01  WS-IDX                    PIC 9(04) COMP.
       01  WS-BYTE                   PIC X.
       01  WS-HAS-ZENKAKU            PIC X.
       01  R-LINE.
           05  R-ID                  PIC X(16).
           05  FILLER                PIC X VALUE '|'.
           05  R-YEN-FLAG            PIC X.
           05  FILLER                PIC X VALUE '|'.
           05  R-ZENKAKU-FLAG       PIC X.
       01  R-SUM.
           05  FILLER     PIC X(10) VALUE 'SUM|cnt='.
           05  RS-CNT     PIC 9(06).
           05  FILLER     PIC X(6)  VALUE '|yen='.
           05  RS-YEN     PIC 9(06).
           05  FILLER     PIC X(10) VALUE '|zenkaku='.
           05  RS-ZEN     PIC 9(06).
       PROCEDURE DIVISION.
       0000-MAIN.
           OPEN INPUT TRANFILE
           OPEN OUTPUT RPTFILE
           PERFORM UNTIL WS-EOF = 'Y'
               READ TRANFILE INTO WS-TRAN
                   AT END MOVE 'Y' TO WS-EOF
                   NOT AT END PERFORM 1000-PROC
               END-READ
           END-PERFORM
           MOVE WS-CNT        TO RS-CNT
           MOVE WS-YEN-OK     TO RS-YEN
           MOVE WS-ZENKAKU-CNT TO RS-ZEN
           WRITE RPT-REC FROM R-SUM
           CLOSE TRANFILE RPTFILE
           STOP RUN.
       1000-PROC.
           ADD 1 TO WS-CNT
      *    T6: 円記号(0x5C)で始まる金額か
           IF WS-TR-YEN(1:1) = WS-YEN-SIGN
               MOVE 'Y' TO R-YEN-FLAG
               ADD 1 TO WS-YEN-OK
           ELSE
               MOVE 'N' TO R-YEN-FLAG
           END-IF
      *    T10: 全角数字(2バイト)を含むか。簡易に上位バイト0x82域を検出
           MOVE 'N' TO WS-HAS-ZENKAKU
           PERFORM VARYING WS-IDX FROM 1 BY 1
                   UNTIL WS-IDX > 20
               MOVE WS-TR-ZENKAKU-REF(WS-IDX:1) TO WS-BYTE
               IF WS-BYTE = X'82' OR WS-BYTE = X'A3'
                   MOVE 'Y' TO WS-HAS-ZENKAKU
               END-IF
           END-PERFORM
           IF WS-HAS-ZENKAKU = 'Y'
               ADD 1 TO WS-ZENKAKU-CNT
           END-IF
           MOVE WS-TR-ID        TO R-ID
           MOVE WS-HAS-ZENKAKU  TO R-ZENKAKU-FLAG
           WRITE RPT-REC FROM R-LINE.

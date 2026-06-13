       IDENTIFICATION DIVISION.
       PROGRAM-ID. CBPAUJ0C.
       AUTHOR. J-CardDemo.
      ******************************************************************
      * 日本版 与信明細バッチ (IMS-DB2-MQ オプションアプリ)
      * 原 CBPAUP0C 相当の与信処理を日本語化。加盟店名を漢字対応にし、
      * DB2列/IMSセグメントへ格納する際のCCSID境界トラップを再現する。
      *
      * 本デモはGnuCOBOLで動くようファイル化(実際はIMS DL/I + DB2 SQL)。
      * トラップ T1/T2 + DB2 CCSID境界(漢字をEBCDICのまま格納し移行で破綻)。
      ******************************************************************
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT PAUTH-FILE ASSIGN TO "pauthj.lseq"
                  ORGANIZATION IS LINE SEQUENTIAL
                  FILE STATUS  IS PA-STATUS.
           SELECT RPT-FILE ASSIGN TO "pauthjrpt.out"
                  ORGANIZATION IS LINE SEQUENTIAL.
       DATA DIVISION.
       FILE SECTION.
       FD  PAUTH-FILE.
       01  FD-PAUTH-REC              PIC X(171).
       FD  RPT-FILE.
       01  RPT-REC                   PIC X(120).
       WORKING-STORAGE SECTION.
       COPY CIPAUDJY.
       COPY CSJEFCHY.
       01  PA-STATUS                 PIC X(02).
       01  WS-EOF                    PIC X VALUE 'N'.
       01  WS-CNT                    PIC 9(06) VALUE 0.
       01  WS-APPROVED               PIC 9(06) VALUE 0.
       01  WS-KANJI-MERCH            PIC 9(06) VALUE 0.
       01  R-LINE.
           05  R-CARD                PIC X(16).
           05  FILLER                PIC X VALUE '|'.
           05  R-MERCH-KANJI-CHARS   PIC ZZ9.
           05  FILLER                PIC X VALUE '|'.
           05  R-CCSID-NOTE          PIC X(20).
       01  R-SUM.
           05  FILLER    PIC X(10) VALUE 'SUM|cnt='.
           05  RS-CNT    PIC 9(06).
           05  FILLER    PIC X(13) VALUE '|kanjiMerch='.
           05  RS-KANJI  PIC 9(06).
       PROCEDURE DIVISION.
       0000-MAIN.
           OPEN INPUT PAUTH-FILE
           OPEN OUTPUT RPT-FILE
           PERFORM UNTIL WS-EOF = 'Y'
               READ PAUTH-FILE INTO PA-AUTH-J-DETAIL
                   AT END MOVE 'Y' TO WS-EOF
                   NOT AT END PERFORM 1000-PROC
               END-READ
           END-PERFORM
           MOVE WS-CNT       TO RS-CNT
           MOVE WS-KANJI-MERCH TO RS-KANJI
           WRITE RPT-REC FROM R-SUM
           CLOSE PAUTH-FILE RPT-FILE
           STOP RUN.
       1000-PROC.
           ADD 1 TO WS-CNT
      *    漢字加盟店名の文字数を JCKANJ0C で算定(SO/SI解釈)
           MOVE PA-KANJI-MERCHANT-NAME TO JCK-FIELD
           MOVE 40 TO JCK-FIELD-LEN
           CALL 'JCKANJ0C' USING JCK-PARM-AREA
           IF JCK-DBCS-COUNT > 0
               ADD 1 TO WS-KANJI-MERCH
           END-IF
           MOVE PA-CARD-NUM    TO R-CARD
           MOVE JCK-DBCS-COUNT TO R-MERCH-KANJI-CHARS
      *    DB2 CCSID境界の注記(漢字はEBCDIC格納→UTF-8 DB2へ移行時に変換要)
           MOVE 'EBCDIC->CCSID1208' TO R-CCSID-NOTE
           WRITE RPT-REC FROM R-LINE.

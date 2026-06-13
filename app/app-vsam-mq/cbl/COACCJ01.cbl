       IDENTIFICATION DIVISION.
       PROGRAM-ID. COACCJ01.
       AUTHOR. J-CardDemo.
      ******************************************************************
      * 日本版 口座MQ連携バッチ (VSAM-MQ オプションアプリ)
      * 原 COACCT01 相当。口座に紐づく顧客漢字氏名をMQメッセージ本文へ
      * 組み立てる際の CCSID 変換境界トラップを再現する。
      *
      * MQ MD(メッセージ記述子)の CCSID が EBCDIC(例 930)のまま送信されると、
      * 受信側UTF-8基盤で漢字が文字化けする。SO/SIの扱いもキューマネージャ依存。
      * トラップ T1/T2 + MQ CCSID境界。
      ******************************************************************
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT ACCT-FILE ASSIGN TO "acctmqj.lseq"
                  ORGANIZATION IS LINE SEQUENTIAL
                  FILE STATUS  IS ACCT-STATUS.
           SELECT MQOUT-FILE ASSIGN TO "acctmqj.out"
                  ORGANIZATION IS LINE SEQUENTIAL.
       DATA DIVISION.
       FILE SECTION.
       FD  ACCT-FILE.
       01  FD-ACCT-REC               PIC X(321).
       FD  MQOUT-FILE.
       01  MQOUT-REC                 PIC X(160).
       WORKING-STORAGE SECTION.
       COPY CVACCMJY.
       COPY CSJEFCHY.
       01  ACCT-STATUS               PIC X(02).
       01  WS-EOF                    PIC X VALUE 'N'.
       01  WS-CNT                    PIC 9(06) VALUE 0.
      * MQ MD 模擬: CCSID をメッセージに付与
       01  WS-MQMD.
           05  WS-MQMD-CCSID         PIC 9(05) VALUE 00930.
           05  WS-MQMD-FORMAT        PIC X(08) VALUE 'MQSTR   '.
       01  R-LINE.
           05  R-ACCT                PIC 9(11).
           05  FILLER                PIC X VALUE '|'.
           05  R-CCSID               PIC 9(05).
           05  FILLER                PIC X VALUE '|'.
           05  R-KANJI-CHARS         PIC ZZ9.
           05  FILLER                PIC X VALUE '|'.
           05  R-NOTE                PIC X(24).
       01  R-SUM.
           05  FILLER   PIC X(10) VALUE 'SUM|cnt='.
           05  RS-CNT   PIC 9(06).
       PROCEDURE DIVISION.
       0000-MAIN.
           OPEN INPUT ACCT-FILE
           OPEN OUTPUT MQOUT-FILE
           PERFORM UNTIL WS-EOF = 'Y'
               READ ACCT-FILE INTO ACCT-MQ-J-RECORD
                   AT END MOVE 'Y' TO WS-EOF
                   NOT AT END PERFORM 1000-PROC
               END-READ
           END-PERFORM
           MOVE WS-CNT TO RS-CNT
           WRITE MQOUT-REC FROM R-SUM
           CLOSE ACCT-FILE MQOUT-FILE
           STOP RUN.
       1000-PROC.
           ADD 1 TO WS-CNT
           MOVE MQ-KANJI-CUST-NAME TO JCK-FIELD
           MOVE 40 TO JCK-FIELD-LEN
           CALL 'JCKANJ0C' USING JCK-PARM-AREA
           MOVE MQ-ACCT-ID     TO R-ACCT
           MOVE WS-MQMD-CCSID  TO R-CCSID
           MOVE JCK-DBCS-COUNT TO R-KANJI-CHARS
      *    CCSID 930(EBCDIC)のまま送出=受信UTF-8で要変換(トラップ)
           MOVE 'CCSID930-needs-convert' TO R-NOTE
           WRITE MQOUT-REC FROM R-LINE.

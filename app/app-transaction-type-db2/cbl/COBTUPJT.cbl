       IDENTIFICATION DIVISION.
       PROGRAM-ID. COBTUPJT.
       AUTHOR. J-CardDemo.
      ******************************************************************
      * 日本版 取引タイプ更新バッチ (transaction-type-db2 オプションアプリ)
      * 原 COBTUPDT 相当。取引タイプの漢字説明を扱い、
      * DB2 VARCHAR列への漢字格納時の桁数(バイト数 vs 文字数)トラップを再現。
      *
      * DB2では CHAR(n)/VARCHAR(n) の n がEBCDICではバイト、UTF-8では…と
      * 解釈が変わり、漢字説明が桁あふれ・切詰めされる。
      * トラップ T1/T2 + DB2 桁定義境界。
      ******************************************************************
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT TT-FILE ASSIGN TO "trantypej.lseq"
                  ORGANIZATION IS LINE SEQUENTIAL
                  FILE STATUS  IS TT-STATUS.
           SELECT RPT-FILE ASSIGN TO "trantypejrpt.out"
                  ORGANIZATION IS LINE SEQUENTIAL.
       DATA DIVISION.
       FILE SECTION.
       FD  TT-FILE.
       01  FD-TT-REC                 PIC X(160).
       FD  RPT-FILE.
       01  RPT-REC                   PIC X(120).
       WORKING-STORAGE SECTION.
       COPY CVTRAJ6Y.
       COPY CSJEFCHY.
       01  TT-STATUS                 PIC X(02).
       01  WS-EOF                    PIC X VALUE 'N'.
       01  WS-CNT                    PIC 9(06) VALUE 0.
       01  WS-OVERFLOW               PIC 9(06) VALUE 0.
      * DB2 VARCHAR(30) を想定。漢字説明のバイト数がこれを超えると桁あふれ(EBCDIC2バイト幅で定義された列がUTF-8 3バイトで超過)。
       01  WS-DB2-VARCHAR-LIMIT      PIC 9(04) VALUE 20.
       01  WS-BYTE-LEN               PIC 9(04).
       01  R-LINE.
           05  R-TYPE                PIC X(02).
           05  FILLER                PIC X VALUE '|'.
           05  R-KANJI-CHARS         PIC ZZ9.
           05  FILLER                PIC X VALUE '|'.
           05  R-BYTES               PIC ZZ9.
           05  FILLER                PIC X VALUE '|'.
           05  R-OVERFLOW            PIC X.
       01  R-SUM.
           05  FILLER    PIC X(10) VALUE 'SUM|cnt='.
           05  RS-CNT    PIC 9(06).
           05  FILLER    PIC X(11) VALUE '|overflow='.
           05  RS-OVF    PIC 9(06).
       PROCEDURE DIVISION.
       0000-MAIN.
           OPEN INPUT TT-FILE
           OPEN OUTPUT RPT-FILE
           PERFORM UNTIL WS-EOF = 'Y'
               READ TT-FILE INTO TRAN-TYPE-J-RECORD
                   AT END MOVE 'Y' TO WS-EOF
                   NOT AT END PERFORM 1000-PROC
               END-READ
           END-PERFORM
           MOVE WS-CNT      TO RS-CNT
           MOVE WS-OVERFLOW TO RS-OVF
           WRITE RPT-REC FROM R-SUM
           CLOSE TT-FILE RPT-FILE
           STOP RUN.
       1000-PROC.
           ADD 1 TO WS-CNT
           MOVE TRAN-TYPE-KANJI-DESC TO JCK-FIELD
           MOVE 60 TO JCK-FIELD-LEN
           CALL 'JCKANJ0C' USING JCK-PARM-AREA
      *    UTF-8換算バイト数 = 漢字数*3 (混在フィールドの有効DBCS部分)
      *    ※末尾SBCS空白パディングは桁数に含めない(SI以降は余白)
           COMPUTE WS-BYTE-LEN = JCK-DBCS-COUNT * 3
           MOVE TRAN-TYPE        TO R-TYPE
           MOVE JCK-DBCS-COUNT   TO R-KANJI-CHARS
           MOVE WS-BYTE-LEN      TO R-BYTES
      *    T1: UTF-8バイト数がDB2 VARCHAR(30)を超えるか
           IF WS-BYTE-LEN > WS-DB2-VARCHAR-LIMIT
               MOVE 'Y' TO R-OVERFLOW
               ADD 1 TO WS-OVERFLOW
           ELSE
               MOVE 'N' TO R-OVERFLOW
           END-IF
           WRITE RPT-REC FROM R-LINE.

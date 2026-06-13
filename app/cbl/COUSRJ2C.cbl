       IDENTIFICATION DIVISION.
       PROGRAM-ID. COUSRJ2C.
       AUTHOR. 日本版CardDemo.
      ******************************************************************
      * 利用者更新(日本版・CICS)
      * 利用者更新
      * 画面 COUSRJ1 の固定文言を日本語化。業務データは英数字中心。
      ******************************************************************
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-PROGRAM-ID  PIC X(8) VALUE 'COUSRJ2C'.
       01  WS-MAPNAME     PIC X(7) VALUE 'COUSRJ1'.
       01  WS-RESP        PIC S9(8) COMP.
       PROCEDURE DIVISION.
       0000-主処理.
      *    EXEC CICS RECEIVE/SEND MAP(WS-MAPNAME) ... END-EXEC
           CONTINUE
           GOBACK.

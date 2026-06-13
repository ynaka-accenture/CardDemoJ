       IDENTIFICATION DIVISION.
       PROGRAM-ID. COCRDJLI.
       AUTHOR. 日本版CardDemo.
      ******************************************************************
      * カード採番(日本版・CICS)
      * カード番号採番(数値)
      * 画面 COCRDJL の固定文言を日本語化。業務データは英数字中心。
      ******************************************************************
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-PROGRAM-ID  PIC X(8) VALUE 'COCRDJLI'.
       01  WS-MAPNAME     PIC X(7) VALUE 'COCRDJL'.
       01  WS-RESP        PIC S9(8) COMP.
       PROCEDURE DIVISION.
       0000-主処理.
      *    EXEC CICS RECEIVE/SEND MAP(WS-MAPNAME) ... END-EXEC
           CONTINUE
           GOBACK.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. COMENJ1C.
       AUTHOR. 日本版CardDemo.
      ******************************************************************
      * メインメニュー(日本版・CICS)
      * 利用者機能メニュー(日本語文言)
      * 画面 COMENJ1 の固定文言を日本語化。業務データは英数字中心。
      ******************************************************************
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-PROGRAM-ID  PIC X(8) VALUE 'COMENJ1C'.
       01  WS-MAPNAME     PIC X(7) VALUE 'COMENJ1'.
       01  WS-RESP        PIC S9(8) COMP.
       PROCEDURE DIVISION.
       0000-主処理.
      *    EXEC CICS RECEIVE/SEND MAP(WS-MAPNAME) ... END-EXEC
           CONTINUE
           GOBACK.

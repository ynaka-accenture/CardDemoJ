       IDENTIFICATION DIVISION.
       PROGRAM-ID. COSGNJ0C.
       AUTHOR. 日本版CardDemo.
      ******************************************************************
      * サインオン(日本版・CICS)
      * 利用者認証(ID/パスワードは英数字、画面文言は日本語)
      * 画面 COSGNJ0 の固定文言を日本語化。業務データは英数字中心。
      ******************************************************************
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-PROGRAM-ID  PIC X(8) VALUE 'COSGNJ0C'.
       01  WS-MAPNAME     PIC X(7) VALUE 'COSGNJ0'.
       01  WS-RESP        PIC S9(8) COMP.
       PROCEDURE DIVISION.
       0000-主処理.
      *    EXEC CICS RECEIVE/SEND MAP(WS-MAPNAME) ... END-EXEC
           CONTINUE
           GOBACK.

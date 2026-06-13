       IDENTIFICATION DIVISION.
       PROGRAM-ID. CODATJ01.
       AUTHOR. 日本版CardDemo.
      ******************************************************************
      * 日付処理(日本版)
      * 日付処理(VSAM-MQ、漢字フィールド透過)
      ******************************************************************
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-PROGRAM-ID  PIC X(8) VALUE 'CODATJ01'.
       PROCEDURE DIVISION.
       0000-主処理.
           DISPLAY '日付処理'
           GOBACK.

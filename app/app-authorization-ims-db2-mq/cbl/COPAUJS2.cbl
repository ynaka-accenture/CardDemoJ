       IDENTIFICATION DIVISION.
       PROGRAM-ID. COPAUJS2.
       AUTHOR. 日本版CardDemo.
      ******************************************************************
      * 与信照会3(日本版)
      * 与信照会サブ(IMS-DB2-MQ)
      ******************************************************************
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-PROGRAM-ID  PIC X(8) VALUE 'COPAUJS2'.
       PROCEDURE DIVISION.
       0000-主処理.
           DISPLAY '与信照会3'
           GOBACK.

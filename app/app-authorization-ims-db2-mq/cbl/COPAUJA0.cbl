       IDENTIFICATION DIVISION.
       PROGRAM-ID. COPAUJA0.
       AUTHOR. 日本版CardDemo.
      ******************************************************************
      * 与信応答(日本版)
      * 与信応答処理。漢字加盟店名を応答に含む(IMS-DB2-MQ)
      ******************************************************************
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-PROGRAM-ID  PIC X(8) VALUE 'COPAUJA0'.
       PROCEDURE DIVISION.
       0000-主処理.
           DISPLAY '与信応答'
           GOBACK.

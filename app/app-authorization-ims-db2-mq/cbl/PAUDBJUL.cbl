       IDENTIFICATION DIVISION.
       PROGRAM-ID. PAUDBJUL.
       AUTHOR. 日本版CardDemo.
      ******************************************************************
      * 与信DBアンロード(日本版)
      * 与信DBから漢字を含むセグメントをアンロード(IMS)
      ******************************************************************
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-PROGRAM-ID  PIC X(8) VALUE 'PAUDBJUL'.
       PROCEDURE DIVISION.
       0000-主処理.
           DISPLAY '与信DBアンロード'
           GOBACK.

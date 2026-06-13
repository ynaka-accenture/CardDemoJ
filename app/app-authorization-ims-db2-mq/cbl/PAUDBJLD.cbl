       IDENTIFICATION DIVISION.
       PROGRAM-ID. PAUDBJLD.
       AUTHOR. 日本版CardDemo.
      ******************************************************************
      * 与信DBロード(日本版)
      * 与信DBへ漢字加盟店名を含むセグメントをロード(IMS)
      ******************************************************************
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-PROGRAM-ID  PIC X(8) VALUE 'PAUDBJLD'.
       PROCEDURE DIVISION.
       0000-主処理.
           DISPLAY '与信DBロード'
           GOBACK.

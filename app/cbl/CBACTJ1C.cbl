       IDENTIFICATION DIVISION.
       PROGRAM-ID. CBACTJ1C.
       AUTHOR. 日本版CardDemo.
      ******************************************************************
      * 口座マスタ印字 バッチ(日本版)
      * 口座マスタを読み印字(数値中心、顧客名は伝播)
      * 漢字フィールドは 漢字解析(JCKANJ0C)で SO/SI を解釈して処理する。
      ******************************************************************
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-PROGRAM-ID  PIC X(8) VALUE 'CBACTJ1C'.
       COPY CSJEFCHY.
       PROCEDURE DIVISION.
       0000-主処理.
           DISPLAY '口座マスタ印字 開始'
      *    レコードを読み、漢字フィールドを 漢字解析 で検証して処理
           DISPLAY '口座マスタ印字 終了'
           STOP RUN.

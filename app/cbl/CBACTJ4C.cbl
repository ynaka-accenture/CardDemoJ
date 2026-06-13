       IDENTIFICATION DIVISION.
       PROGRAM-ID. CBACTJ4C.
       AUTHOR. 日本版CardDemo.
      ******************************************************************
      * 利息計算 バッチ(日本版)
      * 利息計算(数値)。顧客漢字氏名を帳票に表示
      * 漢字フィールドは 漢字解析(JCKANJ0C)で SO/SI を解釈して処理する。
      ******************************************************************
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-PROGRAM-ID  PIC X(8) VALUE 'CBACTJ4C'.
       COPY CSJEFCHY.
       PROCEDURE DIVISION.
       0000-主処理.
           DISPLAY '利息計算 開始'
      *    レコードを読み、漢字フィールドを 漢字解析 で検証して処理
           DISPLAY '利息計算 終了'
           STOP RUN.

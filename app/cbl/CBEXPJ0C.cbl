       IDENTIFICATION DIVISION.
       PROGRAM-ID. CBEXPJ0C.
       AUTHOR. 日本版CardDemo.
      ******************************************************************
      * エクスポート バッチ(日本版)
      * 漢字フィールドを無変換でバイト出力(移行先で破綻実証)
      * 漢字フィールドは 漢字解析(JCKANJ0C)で SO/SI を解釈して処理する。
      ******************************************************************
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-PROGRAM-ID  PIC X(8) VALUE 'CBEXPJ0C'.
       COPY CSJEFCHY.
       PROCEDURE DIVISION.
       0000-主処理.
           DISPLAY 'エクスポート 開始'
      *    レコードを読み、漢字フィールドを 漢字解析 で検証して処理
           DISPLAY 'エクスポート 終了'
           STOP RUN.

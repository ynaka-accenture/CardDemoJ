       IDENTIFICATION DIVISION.
       PROGRAM-ID. CBIMPJ0C.
       AUTHOR. 日本版CardDemo.
      ******************************************************************
      * インポート バッチ(日本版)
      * SO/SI整合性チェック付き取込(T2,T9)
      * 漢字フィールドは 漢字解析(JCKANJ0C)で SO/SI を解釈して処理する。
      ******************************************************************
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-PROGRAM-ID  PIC X(8) VALUE 'CBIMPJ0C'.
       COPY CSJEFCHY.
       PROCEDURE DIVISION.
       0000-主処理.
           DISPLAY 'インポート 開始'
      *    レコードを読み、漢字フィールドを 漢字解析 で検証して処理
           DISPLAY 'インポート 終了'
           STOP RUN.

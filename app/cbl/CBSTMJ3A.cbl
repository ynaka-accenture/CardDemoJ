       IDENTIFICATION DIVISION.
       PROGRAM-ID. CBSTMJ3A.
       AUTHOR. 日本版CardDemo.
      ******************************************************************
      * 明細書作成 バッチ(日本版)
      * 明細書に漢字氏名・住所・加盟店名を印字(T1,T2,T8)
      * 漢字フィールドは 漢字解析(JCKANJ0C)で SO/SI を解釈して処理する。
      ******************************************************************
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-PROGRAM-ID  PIC X(8) VALUE 'CBSTMJ3A'.
       COPY CSJEFCHY.
       PROCEDURE DIVISION.
       0000-主処理.
           DISPLAY '明細書作成 開始'
      *    レコードを読み、漢字フィールドを 漢字解析 で検証して処理
           DISPLAY '明細書作成 終了'
           STOP RUN.

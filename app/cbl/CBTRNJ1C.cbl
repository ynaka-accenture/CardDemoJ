       IDENTIFICATION DIVISION.
       PROGRAM-ID. CBTRNJ1C.
       AUTHOR. 日本版CardDemo.
      ******************************************************************
      * 取引日次処理 バッチ(日本版)
      * 取引の漢字摘要・円記号金額を処理(T1,T2,T6)
      * 漢字フィールドは 漢字解析(JCKANJ0C)で SO/SI を解釈して処理する。
      ******************************************************************
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-PROGRAM-ID  PIC X(8) VALUE 'CBTRNJ1C'.
       COPY CSJEFCHY.
       PROCEDURE DIVISION.
       0000-主処理.
           DISPLAY '取引日次処理 開始'
      *    レコードを読み、漢字フィールドを 漢字解析 で検証して処理
           DISPLAY '取引日次処理 終了'
           STOP RUN.

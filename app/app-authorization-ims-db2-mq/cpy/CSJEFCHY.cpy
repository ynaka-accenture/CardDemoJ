      ******************************************************************
      * CSJEFCHY - 日本版CardDemo 共通 DBCS(IBM漢字/DBCS-Host)文字定義コピー句
      * 全プログラムで共有する SO/SI・外字境界・DBCS空白の定数定義。
      * これを各プログラムの WORKING-STORAGE に COPY して使う。
      ******************************************************************
       01  JEF-CONSTANTS.
           05  JEF-SO              PIC X VALUE X'0E'.
           05  JEF-SI              PIC X VALUE X'0F'.
           05  JEF-DBCS-SPACE      PIC X(02) VALUE X'4040'.
           05  JEF-SBCS-SPACE      PIC X VALUE X'40'.
           05  JEF-YEN-SIGN        PIC X VALUE X'5C'.
      *    外字(利用者定義)領域: 上位バイト境界
           05  JEF-GAIJI-LO        PIC X VALUE X'69'.
           05  JEF-GAIJI-HI        PIC X VALUE X'7F'.
      *    半角カナ領域(JIS X 0201): 0xA1-0xDF
           05  JEF-HANKANA-LO      PIC X VALUE X'A1'.
           05  JEF-HANKANA-HI      PIC X VALUE X'DF'.
      ******************************************************************
      * JCKANJ0C 呼出パラメタの標準レイアウト
      ******************************************************************
       01  JCK-PARM-AREA.
           05  JCK-FIELD           PIC X(80).
           05  JCK-FIELD-LEN       PIC 9(04) COMP.
           05  JCK-SBCS-COUNT      PIC 9(04) COMP.
           05  JCK-DBCS-COUNT      PIC 9(04) COMP.
           05  JCK-GAIJI-FOUND     PIC X.
           05  JCK-MALFORMED       PIC X.

      ******************************************************************
      * COCRDJU - 記号マップ(symbolic map)コピー句  日本版CardDemo
      * BMS マップ生成物。漢字フィールドは混在バイト列として保持。
      ******************************************************************
       01  COCRDJUI.
           02  FILLER PIC X(12).
           02  TITLEL    COMP  PIC  S9(4).
           02  TITLEF    PICTURE X.
           02  FILLER REDEFINES TITLEF.
             03 TITLEA    PICTURE X.
           02  TITLEI  PIC X(40).
           02  CRDNUL    COMP  PIC  S9(4).
           02  CRDNUF    PICTURE X.
           02  FILLER REDEFINES CRDNUF.
             03 CRDNUA    PICTURE X.
           02  CRDNUI  PIC X(16).
           02  EMBNAL    COMP  PIC  S9(4).
           02  EMBNAF    PICTURE X.
           02  FILLER REDEFINES EMBNAF.
             03 EMBNAA    PICTURE X.
           02  EMBNAI  PIC X(50).
           02  KJEMBL    COMP  PIC  S9(4).
           02  KJEMBF    PICTURE X.
           02  FILLER REDEFINES KJEMBF.
             03 KJEMBA    PICTURE X.
           02  KJEMBI  PIC X(40).
           02  ERRMSL    COMP  PIC  S9(4).
           02  ERRMSF    PICTURE X.
           02  FILLER REDEFINES ERRMSF.
             03 ERRMSA    PICTURE X.
           02  ERRMSI  PIC X(78).
       01  COCRDJUO REDEFINES COCRDJUI.
           02  FILLER PIC X(12).
           02  FILLER PICTURE X(3).
           02  TITLEO  PIC X(40).
           02  FILLER PICTURE X(3).
           02  CRDNUO  PIC X(16).
           02  FILLER PICTURE X(3).
           02  EMBNAO  PIC X(50).
           02  FILLER PICTURE X(3).
           02  KJEMBO  PIC X(40).
           02  FILLER PICTURE X(3).
           02  ERRMSO  PIC X(78).

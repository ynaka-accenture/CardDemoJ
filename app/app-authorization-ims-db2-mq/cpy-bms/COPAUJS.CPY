      ******************************************************************
      * COPAUJS - 記号マップ(symbolic map)コピー句  日本版CardDemo
      * BMS マップ生成物。漢字フィールドは混在バイト列として保持。
      ******************************************************************
       01  COPAUJSI.
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
           02  KJMRCL    COMP  PIC  S9(4).
           02  KJMRCF    PICTURE X.
           02  FILLER REDEFINES KJMRCF.
             03 KJMRCA    PICTURE X.
           02  KJMRCI  PIC X(60).
           02  RESULL    COMP  PIC  S9(4).
           02  RESULF    PICTURE X.
           02  FILLER REDEFINES RESULF.
             03 RESULA    PICTURE X.
           02  RESULI  PIC X(10).
           02  ERRMSL    COMP  PIC  S9(4).
           02  ERRMSF    PICTURE X.
           02  FILLER REDEFINES ERRMSF.
             03 ERRMSA    PICTURE X.
           02  ERRMSI  PIC X(78).
       01  COPAUJSO REDEFINES COPAUJSI.
           02  FILLER PIC X(12).
           02  FILLER PICTURE X(3).
           02  TITLEO  PIC X(40).
           02  FILLER PICTURE X(3).
           02  CRDNUO  PIC X(16).
           02  FILLER PICTURE X(3).
           02  KJMRCO  PIC X(60).
           02  FILLER PICTURE X(3).
           02  RESULO  PIC X(10).
           02  FILLER PICTURE X(3).
           02  ERRMSO  PIC X(78).

      ******************************************************************
      * CORPTJ0 - 記号マップ(symbolic map)コピー句  日本版CardDemo
      * BMS マップ生成物。漢字フィールドは混在バイト列として保持。
      ******************************************************************
       01  CORPTJ0I.
           02  FILLER PIC X(12).
           02  TITLEL    COMP  PIC  S9(4).
           02  TITLEF    PICTURE X.
           02  FILLER REDEFINES TITLEF.
             03 TITLEA    PICTURE X.
           02  TITLEI  PIC X(40).
           02  FROMDL    COMP  PIC  S9(4).
           02  FROMDF    PICTURE X.
           02  FILLER REDEFINES FROMDF.
             03 FROMDA    PICTURE X.
           02  FROMDI  PIC X(10).
           02  TODTL    COMP  PIC  S9(4).
           02  TODTF    PICTURE X.
           02  FILLER REDEFINES TODTF.
             03 TODTA    PICTURE X.
           02  TODTI  PIC X(10).
           02  RPTTYL    COMP  PIC  S9(4).
           02  RPTTYF    PICTURE X.
           02  FILLER REDEFINES RPTTYF.
             03 RPTTYA    PICTURE X.
           02  RPTTYI  PIC X(20).
           02  ERRMSL    COMP  PIC  S9(4).
           02  ERRMSF    PICTURE X.
           02  FILLER REDEFINES ERRMSF.
             03 ERRMSA    PICTURE X.
           02  ERRMSI  PIC X(78).
       01  CORPTJ0O REDEFINES CORPTJ0I.
           02  FILLER PIC X(12).
           02  FILLER PICTURE X(3).
           02  TITLEO  PIC X(40).
           02  FILLER PICTURE X(3).
           02  FROMDO  PIC X(10).
           02  FILLER PICTURE X(3).
           02  TODTO  PIC X(10).
           02  FILLER PICTURE X(3).
           02  RPTTYO  PIC X(20).
           02  FILLER PICTURE X(3).
           02  ERRMSO  PIC X(78).

      ******************************************************************
      * COTRTJL - 記号マップ(symbolic map)コピー句  日本版CardDemo
      * BMS マップ生成物。漢字フィールドは混在バイト列として保持。
      ******************************************************************
       01  COTRTJLI.
           02  FILLER PIC X(12).
           02  TITLEL    COMP  PIC  S9(4).
           02  TITLEF    PICTURE X.
           02  FILLER REDEFINES TITLEF.
             03 TITLEA    PICTURE X.
           02  TITLEI  PIC X(40).
           02  TTYPEL    COMP  PIC  S9(4).
           02  TTYPEF    PICTURE X.
           02  FILLER REDEFINES TTYPEF.
             03 TTYPEA    PICTURE X.
           02  TTYPEI  PIC X(2).
           02  KJDESL    COMP  PIC  S9(4).
           02  KJDESF    PICTURE X.
           02  FILLER REDEFINES KJDESF.
             03 KJDESA    PICTURE X.
           02  KJDESI  PIC X(60).
           02  ERRMSL    COMP  PIC  S9(4).
           02  ERRMSF    PICTURE X.
           02  FILLER REDEFINES ERRMSF.
             03 ERRMSA    PICTURE X.
           02  ERRMSI  PIC X(78).
       01  COTRTJLO REDEFINES COTRTJLI.
           02  FILLER PIC X(12).
           02  FILLER PICTURE X(3).
           02  TITLEO  PIC X(40).
           02  FILLER PICTURE X(3).
           02  TTYPEO  PIC X(2).
           02  FILLER PICTURE X(3).
           02  KJDESO  PIC X(60).
           02  FILLER PICTURE X(3).
           02  ERRMSO  PIC X(78).

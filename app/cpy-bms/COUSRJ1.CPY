      ******************************************************************
      * COUSRJ1 - 記号マップ(symbolic map)コピー句  日本版CardDemo
      * BMS マップ生成物。漢字フィールドは混在バイト列として保持。
      ******************************************************************
       01  COUSRJ1I.
           02  FILLER PIC X(12).
           02  TITLEL    COMP  PIC  S9(4).
           02  TITLEF    PICTURE X.
           02  FILLER REDEFINES TITLEF.
             03 TITLEA    PICTURE X.
           02  TITLEI  PIC X(40).
           02  USERIL    COMP  PIC  S9(4).
           02  USERIF    PICTURE X.
           02  FILLER REDEFINES USERIF.
             03 USERIA    PICTURE X.
           02  USERII  PIC X(8).
           02  KJNAML    COMP  PIC  S9(4).
           02  KJNAMF    PICTURE X.
           02  FILLER REDEFINES KJNAMF.
             03 KJNAMA    PICTURE X.
           02  KJNAMI  PIC X(40).
           02  ERRMSL    COMP  PIC  S9(4).
           02  ERRMSF    PICTURE X.
           02  FILLER REDEFINES ERRMSF.
             03 ERRMSA    PICTURE X.
           02  ERRMSI  PIC X(78).
       01  COUSRJ1O REDEFINES COUSRJ1I.
           02  FILLER PIC X(12).
           02  FILLER PICTURE X(3).
           02  TITLEO  PIC X(40).
           02  FILLER PICTURE X(3).
           02  USERIO  PIC X(8).
           02  FILLER PICTURE X(3).
           02  KJNAMO  PIC X(40).
           02  FILLER PICTURE X(3).
           02  ERRMSO  PIC X(78).

      ******************************************************************
      * COSGNJ0 - 記号マップ(symbolic map)コピー句  日本版CardDemo
      * BMS マップ生成物。漢字フィールドは混在バイト列として保持。
      ******************************************************************
       01  COSGNJ0I.
           02  FILLER PIC X(12).
           02  TRNNAL    COMP  PIC  S9(4).
           02  TRNNAF    PICTURE X.
           02  FILLER REDEFINES TRNNAF.
             03 TRNNAA    PICTURE X.
           02  TRNNAI  PIC X(4).
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
           02  PASSWL    COMP  PIC  S9(4).
           02  PASSWF    PICTURE X.
           02  FILLER REDEFINES PASSWF.
             03 PASSWA    PICTURE X.
           02  PASSWI  PIC X(8).
           02  ERRMSL    COMP  PIC  S9(4).
           02  ERRMSF    PICTURE X.
           02  FILLER REDEFINES ERRMSF.
             03 ERRMSA    PICTURE X.
           02  ERRMSI  PIC X(78).
       01  COSGNJ0O REDEFINES COSGNJ0I.
           02  FILLER PIC X(12).
           02  FILLER PICTURE X(3).
           02  TRNNAO  PIC X(4).
           02  FILLER PICTURE X(3).
           02  TITLEO  PIC X(40).
           02  FILLER PICTURE X(3).
           02  USERIO  PIC X(8).
           02  FILLER PICTURE X(3).
           02  PASSWO  PIC X(8).
           02  FILLER PICTURE X(3).
           02  ERRMSO  PIC X(78).

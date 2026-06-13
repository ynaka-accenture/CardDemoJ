      ******************************************************************
      * COACVJW - 記号マップ(symbolic map)コピー句  日本版CardDemo
      * BMS マップ生成物。漢字フィールドは混在バイト列として保持。
      ******************************************************************
       01  COACVJWI.
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
           02  ACCTIL    COMP  PIC  S9(4).
           02  ACCTIF    PICTURE X.
           02  FILLER REDEFINES ACCTIF.
             03 ACCTIA    PICTURE X.
           02  ACCTII  PIC X(11).
           02  KJNAML    COMP  PIC  S9(4).
           02  KJNAMF    PICTURE X.
           02  FILLER REDEFINES KJNAMF.
             03 KJNAMA    PICTURE X.
           02  KJNAMI  PIC X(40).
           02  KANAML    COMP  PIC  S9(4).
           02  KANAMF    PICTURE X.
           02  FILLER REDEFINES KANAMF.
             03 KANAMA    PICTURE X.
           02  KANAMI  PIC X(40).
           02  KJADDL    COMP  PIC  S9(4).
           02  KJADDF    PICTURE X.
           02  FILLER REDEFINES KJADDF.
             03 KJADDA    PICTURE X.
           02  KJADDI  PIC X(60).
           02  KJADDL    COMP  PIC  S9(4).
           02  KJADDF    PICTURE X.
           02  FILLER REDEFINES KJADDF.
             03 KJADDA    PICTURE X.
           02  KJADDI  PIC X(60).
           02  CURBAL    COMP  PIC  S9(4).
           02  CURBAF    PICTURE X.
           02  FILLER REDEFINES CURBAF.
             03 CURBAA    PICTURE X.
           02  CURBAI  PIC X(15).
           02  ERRMSL    COMP  PIC  S9(4).
           02  ERRMSF    PICTURE X.
           02  FILLER REDEFINES ERRMSF.
             03 ERRMSA    PICTURE X.
           02  ERRMSI  PIC X(78).
       01  COACVJWO REDEFINES COACVJWI.
           02  FILLER PIC X(12).
           02  FILLER PICTURE X(3).
           02  TRNNAO  PIC X(4).
           02  FILLER PICTURE X(3).
           02  TITLEO  PIC X(40).
           02  FILLER PICTURE X(3).
           02  ACCTIO  PIC X(11).
           02  FILLER PICTURE X(3).
           02  KJNAMO  PIC X(40).
           02  FILLER PICTURE X(3).
           02  KANAMO  PIC X(40).
           02  FILLER PICTURE X(3).
           02  KJADDO  PIC X(60).
           02  FILLER PICTURE X(3).
           02  KJADDO  PIC X(60).
           02  FILLER PICTURE X(3).
           02  CURBAO  PIC X(15).
           02  FILLER PICTURE X(3).
           02  ERRMSO  PIC X(78).

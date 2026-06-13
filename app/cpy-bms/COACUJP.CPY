      ******************************************************************
      * COACUJP - 記号マップ(symbolic map)コピー句  日本版CardDemo
      * BMS マップ生成物。漢字フィールドは混在バイト列として保持。
      ******************************************************************
       01  COACUJPI.
           02  FILLER PIC X(12).
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
           02  KJLNAL    COMP  PIC  S9(4).
           02  KJLNAF    PICTURE X.
           02  FILLER REDEFINES KJLNAF.
             03 KJLNAA    PICTURE X.
           02  KJLNAI  PIC X(40).
           02  KJFNAL    COMP  PIC  S9(4).
           02  KJFNAF    PICTURE X.
           02  FILLER REDEFINES KJFNAF.
             03 KJFNAA    PICTURE X.
           02  KJFNAI  PIC X(40).
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
           02  ERRMSL    COMP  PIC  S9(4).
           02  ERRMSF    PICTURE X.
           02  FILLER REDEFINES ERRMSF.
             03 ERRMSA    PICTURE X.
           02  ERRMSI  PIC X(78).
       01  COACUJPO REDEFINES COACUJPI.
           02  FILLER PIC X(12).
           02  FILLER PICTURE X(3).
           02  TITLEO  PIC X(40).
           02  FILLER PICTURE X(3).
           02  ACCTIO  PIC X(11).
           02  FILLER PICTURE X(3).
           02  KJLNAO  PIC X(40).
           02  FILLER PICTURE X(3).
           02  KJFNAO  PIC X(40).
           02  FILLER PICTURE X(3).
           02  KJADDO  PIC X(60).
           02  FILLER PICTURE X(3).
           02  KJADDO  PIC X(60).
           02  FILLER PICTURE X(3).
           02  ERRMSO  PIC X(78).

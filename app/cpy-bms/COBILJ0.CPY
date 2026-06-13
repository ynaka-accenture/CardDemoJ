      ******************************************************************
      * COBILJ0 - 記号マップ(symbolic map)コピー句  日本版CardDemo
      * BMS マップ生成物。漢字フィールドは混在バイト列として保持。
      ******************************************************************
       01  COBILJ0I.
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
           02  KJNAML    COMP  PIC  S9(4).
           02  KJNAMF    PICTURE X.
           02  FILLER REDEFINES KJNAMF.
             03 KJNAMA    PICTURE X.
           02  KJNAMI  PIC X(40).
           02  BILLYL    COMP  PIC  S9(4).
           02  BILLYF    PICTURE X.
           02  FILLER REDEFINES BILLYF.
             03 BILLYA    PICTURE X.
           02  BILLYI  PIC X(15).
           02  DUEDAL    COMP  PIC  S9(4).
           02  DUEDAF    PICTURE X.
           02  FILLER REDEFINES DUEDAF.
             03 DUEDAA    PICTURE X.
           02  DUEDAI  PIC X(10).
           02  ERRMSL    COMP  PIC  S9(4).
           02  ERRMSF    PICTURE X.
           02  FILLER REDEFINES ERRMSF.
             03 ERRMSA    PICTURE X.
           02  ERRMSI  PIC X(78).
       01  COBILJ0O REDEFINES COBILJ0I.
           02  FILLER PIC X(12).
           02  FILLER PICTURE X(3).
           02  TITLEO  PIC X(40).
           02  FILLER PICTURE X(3).
           02  ACCTIO  PIC X(11).
           02  FILLER PICTURE X(3).
           02  KJNAMO  PIC X(40).
           02  FILLER PICTURE X(3).
           02  BILLYO  PIC X(15).
           02  FILLER PICTURE X(3).
           02  DUEDAO  PIC X(10).
           02  FILLER PICTURE X(3).
           02  ERRMSO  PIC X(78).

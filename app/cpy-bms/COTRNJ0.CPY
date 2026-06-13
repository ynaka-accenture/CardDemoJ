      ******************************************************************
      * COTRNJ0 - 記号マップ(symbolic map)コピー句  日本版CardDemo
      * BMS マップ生成物。漢字フィールドは混在バイト列として保持。
      ******************************************************************
       01  COTRNJ0I.
           02  FILLER PIC X(12).
           02  TITLEL    COMP  PIC  S9(4).
           02  TITLEF    PICTURE X.
           02  FILLER REDEFINES TITLEF.
             03 TITLEA    PICTURE X.
           02  TITLEI  PIC X(40).
           02  TRNIDL    COMP  PIC  S9(4).
           02  TRNIDF    PICTURE X.
           02  FILLER REDEFINES TRNIDF.
             03 TRNIDA    PICTURE X.
           02  TRNIDI  PIC X(16).
           02  KJDESL    COMP  PIC  S9(4).
           02  KJDESF    PICTURE X.
           02  FILLER REDEFINES KJDESF.
             03 KJDESA    PICTURE X.
           02  KJDESI  PIC X(60).
           02  AMTYEL    COMP  PIC  S9(4).
           02  AMTYEF    PICTURE X.
           02  FILLER REDEFINES AMTYEF.
             03 AMTYEA    PICTURE X.
           02  AMTYEI  PIC X(15).
           02  KJMRCL    COMP  PIC  S9(4).
           02  KJMRCF    PICTURE X.
           02  FILLER REDEFINES KJMRCF.
             03 KJMRCA    PICTURE X.
           02  KJMRCI  PIC X(60).
           02  REFNOL    COMP  PIC  S9(4).
           02  REFNOF    PICTURE X.
           02  FILLER REDEFINES REFNOF.
             03 REFNOA    PICTURE X.
           02  REFNOI  PIC X(20).
           02  ERRMSL    COMP  PIC  S9(4).
           02  ERRMSF    PICTURE X.
           02  FILLER REDEFINES ERRMSF.
             03 ERRMSA    PICTURE X.
           02  ERRMSI  PIC X(78).
       01  COTRNJ0O REDEFINES COTRNJ0I.
           02  FILLER PIC X(12).
           02  FILLER PICTURE X(3).
           02  TITLEO  PIC X(40).
           02  FILLER PICTURE X(3).
           02  TRNIDO  PIC X(16).
           02  FILLER PICTURE X(3).
           02  KJDESO  PIC X(60).
           02  FILLER PICTURE X(3).
           02  AMTYEO  PIC X(15).
           02  FILLER PICTURE X(3).
           02  KJMRCO  PIC X(60).
           02  FILLER PICTURE X(3).
           02  REFNOO  PIC X(20).
           02  FILLER PICTURE X(3).
           02  ERRMSO  PIC X(78).

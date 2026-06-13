      ******************************************************************
      * COCRDJL - 記号マップ(symbolic map)コピー句  日本版CardDemo
      * BMS マップ生成物。漢字フィールドは混在バイト列として保持。
      ******************************************************************
       01  COCRDJLI.
           02  FILLER PIC X(12).
           02  TITLEL    COMP  PIC  S9(4).
           02  TITLEF    PICTURE X.
           02  FILLER REDEFINES TITLEF.
             03 TITLEA    PICTURE X.
           02  TITLEI  PIC X(40).
           02  CRDNML    COMP  PIC  S9(4).
           02  CRDNMF    PICTURE X.
           02  FILLER REDEFINES CRDNMF.
             03 CRDNMA    PICTURE X.
           02  CRDNMI  PIC X(16).
           02  EMBNML    COMP  PIC  S9(4).
           02  EMBNMF    PICTURE X.
           02  FILLER REDEFINES EMBNMF.
             03 EMBNMA    PICTURE X.
           02  EMBNMI  PIC X(20).
           02  KJEMBL    COMP  PIC  S9(4).
           02  KJEMBF    PICTURE X.
           02  FILLER REDEFINES KJEMBF.
             03 KJEMBA    PICTURE X.
           02  KJEMBI  PIC X(30).
           02  CRDNML    COMP  PIC  S9(4).
           02  CRDNMF    PICTURE X.
           02  FILLER REDEFINES CRDNMF.
             03 CRDNMA    PICTURE X.
           02  CRDNMI  PIC X(16).
           02  EMBNML    COMP  PIC  S9(4).
           02  EMBNMF    PICTURE X.
           02  FILLER REDEFINES EMBNMF.
             03 EMBNMA    PICTURE X.
           02  EMBNMI  PIC X(20).
           02  KJEMBL    COMP  PIC  S9(4).
           02  KJEMBF    PICTURE X.
           02  FILLER REDEFINES KJEMBF.
             03 KJEMBA    PICTURE X.
           02  KJEMBI  PIC X(30).
           02  ERRMSL    COMP  PIC  S9(4).
           02  ERRMSF    PICTURE X.
           02  FILLER REDEFINES ERRMSF.
             03 ERRMSA    PICTURE X.
           02  ERRMSI  PIC X(78).
       01  COCRDJLO REDEFINES COCRDJLI.
           02  FILLER PIC X(12).
           02  FILLER PICTURE X(3).
           02  TITLEO  PIC X(40).
           02  FILLER PICTURE X(3).
           02  CRDNMO  PIC X(16).
           02  FILLER PICTURE X(3).
           02  EMBNMO  PIC X(20).
           02  FILLER PICTURE X(3).
           02  KJEMBO  PIC X(30).
           02  FILLER PICTURE X(3).
           02  CRDNMO  PIC X(16).
           02  FILLER PICTURE X(3).
           02  EMBNMO  PIC X(20).
           02  FILLER PICTURE X(3).
           02  KJEMBO  PIC X(30).
           02  FILLER PICTURE X(3).
           02  ERRMSO  PIC X(78).

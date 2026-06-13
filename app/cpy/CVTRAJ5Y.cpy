      ******************************************************************
      * CVTRAJ5Y - 日本版 取引レコード
      * J-CardDemo: 原 CVTRA05Y を拡張し日本語フィールド+トラップを追加。
      * 文字コードモデル: IBM EBCDIC日本語(IBM漢字/DBCS-Host, CCSID 930等). DBCSはSO(0E)..SI(0F)で囲む。
      * トラップ: T1,T2,T6,T8,T10
      ******************************************************************
       01  TRAN-J-RECORD.
           05  TRAN-ID                       PIC X(16).
           05  TRAN-TYPE-CD                  PIC X(02).
           05  TRAN-CAT-CD                   PIC 9(04).
           05  TRAN-SOURCE                   PIC X(10).
      *    英数字摘要(原資産互換)
           05  TRAN-DESC                     PIC X(100).
      *    T1/T2: 漢字摘要(SO..SI)
           05  TRAN-KANJI-DESC               PIC X(80).
           05  TRAN-AMT                      PIC S9(09)V99.
      *    T6: 円記号(0x5C)付き金額表示
           05  TRAN-AMT-DISP-YEN             PIC X(15).
           05  TRAN-MERCHANT-ID              PIC 9(09).
      *    英数字加盟店名(原資産互換)
           05  TRAN-MERCHANT-NAME            PIC X(50).
      *    T1/T2/T8: 漢字加盟店名
           05  TRAN-KANJI-MERCHANT-NAME      PIC X(60).
           05  TRAN-MERCHANT-CITY            PIC X(50).
      *    T1/T2: 漢字所在地
           05  TRAN-KANJI-MERCHANT-CITY      PIC X(40).
           05  TRAN-MERCHANT-ZIP             PIC X(10).
           05  TRAN-CARD-NUM                 PIC X(16).
           05  TRAN-ORIG-TS                  PIC X(26).
           05  TRAN-PROC-TS                  PIC X(26).
      *    T10: 全角数字混入の受付番号
           05  TRAN-ZENKAKU-REFNO            PIC X(20).
           05  FILLER                        PIC X(20).
      ******************************************************************
      * レコード長(EBCDIC前提概算): 563 バイト
      * ※漢字フィールドをUTF-8化するとバイト幅が変わりレイアウト破綻(T1)
      ******************************************************************

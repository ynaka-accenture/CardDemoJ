      ******************************************************************
      * CVACTJ1Y - 日本版 口座レコード
      * J-CardDemo: 原 CVACT01Y を拡張し日本語フィールド+トラップを追加。
      * 文字コードモデル: IBM EBCDIC日本語(IBM漢字/DBCS-Host, CCSID 930等). DBCSはSO(0E)..SI(0F)で囲む。
      * トラップ: (伝播のみ)
      ******************************************************************
       01  ACCOUNT-J-RECORD.
           05  ACCT-ID                       PIC 9(11).
           05  ACCT-ACTIVE-STATUS            PIC X(01).
           05  ACCT-CURR-BAL                 PIC S9(10)V99.
           05  ACCT-CREDIT-LIMIT             PIC S9(10)V99.
           05  ACCT-CASH-CREDIT-LIMIT        PIC S9(10)V99.
           05  ACCT-OPEN-DATE                PIC X(10).
           05  ACCT-EXPIRAION-DATE           PIC X(10).
           05  ACCT-REISSUE-DATE             PIC X(10).
           05  ACCT-CURR-CYC-CREDIT          PIC S9(10)V99.
           05  ACCT-CURR-CYC-DEBIT           PIC S9(10)V99.
           05  ACCT-ADDR-ZIP                 PIC X(10).
           05  ACCT-GROUP-ID                 PIC X(10).
           05  FILLER                        PIC X(178).
      ******************************************************************
      * レコード長(EBCDIC前提概算): 290 バイト
      * ※漢字フィールドをUTF-8化するとバイト幅が変わりレイアウト破綻(T1)
      ******************************************************************

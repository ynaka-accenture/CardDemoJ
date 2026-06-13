      ******************************************************************
      * CVCUSJ1Y - 日本版 顧客レコード (J-CardDemo)
      * 原 CVCUS01Y を拡張し、日本語固有のトラップを埋め込む。
      * 文字コードモデル: EBCDIC日本語(JEF) / DBCSはSO(0E)..SI(0F)で囲む
      *
      * 埋め込みトラップ:
      *  T1 固定バイト幅 vs 多バイト文字  (漢字氏名・住所)
      *  T2 SO/SIシフトコード             (混在フィールド)
      *  T3 PIC N / USAGE NATIONAL        (カナ氏名)
      *  T4 ベンダー外字                  (漢字氏名に混入しうる)
      *  T5 波ダッシュ/全角チルダ         (住所)
      *  T7 半角カナ(JIS X 0201)          (備考)
      *  T8 DBCS空白パディング(0x4040)    (漢字フィールド余白)
      ******************************************************************
       01  CUSTOMER-J-RECORD.
           05  CUST-ID                       PIC 9(09).
      *    --- 英数字氏名(原資産互換: 単バイト) ---
           05  CUST-FIRST-NAME               PIC X(25).
           05  CUST-MIDDLE-NAME              PIC X(25).
           05  CUST-LAST-NAME                PIC X(25).
      *    --- T1/T2/T4/T8: 漢字氏名(混在フィールド,SO..SI) ---
      *        X(40)=40バイト。漢字18文字+SO/SI で設計。
      *        UTF-8では漢字3バイト化で容易に超過する。
           05  CUST-KANJI-LAST-NAME          PIC X(40).
           05  CUST-KANJI-FIRST-NAME         PIC X(40).
      *    --- T3: カナ氏名(各国語項目 N) ---
      *        PIC N(20)=DBCS20文字。USAGE指定なし=処理系依存。
           05  CUST-KANA-LAST-NAME           PIC N(20).
           05  CUST-KANA-FIRST-NAME          PIC N(20).
      *    --- 英数字住所(原資産互換) ---
           05  CUST-ADDR-LINE-1              PIC X(50).
           05  CUST-ADDR-LINE-2              PIC X(50).
      *    --- T1/T2/T5/T8: 漢字住所(混在,SO..SI,波ダッシュ含む) ---
           05  CUST-KANJI-ADDR-1             PIC X(60).
           05  CUST-KANJI-ADDR-2             PIC X(60).
           05  CUST-ADDR-STATE-CD            PIC X(02).
           05  CUST-ADDR-COUNTRY-CD          PIC X(03).
      *    --- T6: 郵便番号(全角ハイフン混入の余地) ---
           05  CUST-ADDR-ZIP                 PIC X(10).
      *    --- T7: 半角カナ備考(JIS X 0201 片仮名 0xA1-0xDF) ---
           05  CUST-MEMO-HANKANA             PIC X(30).
           05  CUST-PHONE-NUM-1              PIC X(15).
           05  CUST-PHONE-NUM-2              PIC X(15).
           05  CUST-SSN                      PIC 9(09).
           05  CUST-GOVT-ISSUED-ID           PIC X(20).
           05  CUST-DOB-YYYY-MM-DD           PIC X(10).
           05  CUST-EFT-ACCOUNT-ID           PIC X(10).
           05  CUST-PRI-CARD-HOLDER-IND      PIC X(01).
           05  CUST-FICO-CREDIT-SCORE        PIC 9(03).
           05  FILLER                        PIC X(50).
      ******************************************************************
      * レコード長メモ:
      *   原 CVCUS01Y = 500バイト
      *   CVCUSJ1Y    = 9+25*3+40*2+40(N20*2)+50*2+60*2+2+3+10+30
      *                 +15*2+9+20+10+10+1+3+50 = 642バイト(EBCDIC前提)
      * ※N項目をUTF-16/UTF-8化すると長さが変わるためレイアウト破綻(T1/T3)
      ******************************************************************

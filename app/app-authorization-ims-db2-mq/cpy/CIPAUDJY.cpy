      ******************************************************************
      * CIPAUDJY - 日本版 与信明細レコード(IMS-DB2)
      * J-CardDemo: 原 CIPAUDTY を拡張し日本語フィールド+トラップを追加。
      * 文字コードモデル: IBM EBCDIC日本語(IBM漢字/DBCS-Host, CCSID 930等). DBCSはSO(0E)..SI(0F)で囲む。
      * トラップ: T1,T2 / DB2 CCSID境界
      ******************************************************************
       01  PA-AUTH-J-DETAIL.
           05  PA-CARD-NUM                   PIC X(16).
           05  PA-AUTH-TYPE                  PIC X(04).
           05  PA-AUTH-RESP-CODE             PIC X(02).
           05  PA-TRANSACTION-AMT            PIC S9(10)V99 COMP-3.
           05  PA-MERCHANT-ID                PIC X(15).
      *    英数字加盟店名(原資産互換)
           05  PA-MERCHANT-NAME              PIC X(22).
      *    T1/T2: 漢字加盟店名(DB2 CCSID/IMS DBD文字コード定義が新トラップ)
           05  PA-KANJI-MERCHANT-NAME        PIC X(40).
           05  PA-MERCHANT-CITY              PIC X(13).
      *    T1/T2: 漢字所在地
           05  PA-KANJI-MERCHANT-CITY        PIC X(30).
           05  PA-MERCHANT-STATE             PIC X(02).
           05  FILLER                        PIC X(20).
      ******************************************************************
      * レコード長(EBCDIC前提概算): 170 バイト
      * ※漢字フィールドをUTF-8化するとバイト幅が変わりレイアウト破綻(T1)
      ******************************************************************

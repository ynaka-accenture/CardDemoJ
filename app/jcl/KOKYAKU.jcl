//KOKYAKU  JOB (ACCT),'KOKYAKU CHOHYO',CLASS=A,MSGCLASS=X,
//             NOTIFY=&SYSUID
//*********************************************************************
//* 日本版CardDemo - 顧客帳票作成ジョブ
//* 顧客ファイル(漢字氏名・住所を含む)を読み、漢字フィールドの
//* 文字数・外字・SO/SI不整合を判定して帳票を出力する。
//*
//* 文字コード: IBM EBCDIC日本語(IBM漢字, CCSID 930/939/5035)。漢字はSO/SIで囲む混在フィールド。
//* ※UTF-8基盤へ移行する際、SORT/帳票の桁揃えが全角=2カラム前提のため
//*   再設計が必要(トラップT1/T8)。
//*********************************************************************
//*------------------------------------------------------------------
//* ステップ1: 顧客帳票作成(CBCUSJ1C / 本番は 顧客帳票)
//*------------------------------------------------------------------
//STEP010  EXEC PGM=CBCUSJ1C
//STEPLIB  DD DSN=CARDDEMO.J.LOADLIB,DISP=SHR
//*        顧客マスタ(VSAM KSDS、漢字氏名・住所を含む)
//CUSTFILE DD DSN=CARDDEMO.J.CUSTDATA,DISP=SHR
//*        漢字解析サブルーチン(JCKANJ0C / 漢字解析)をロード
//SYSOUT   DD SYSOUT=*
//*        顧客帳票(漢字を含む)
//CUSTRPT  DD DSN=CARDDEMO.J.CUSTRPT,DISP=(NEW,CATLG,DELETE),
//             SPACE=(CYL,(1,1)),
//             DCB=(RECFM=FB,LRECL=160,BLKSIZE=1600)
//SYSIN    DD DUMMY
//*------------------------------------------------------------------
//* ステップ2: 帳票印刷(漢字対応プリンタへ。CCSID指定が必要)
//*------------------------------------------------------------------
//STEP020  EXEC PGM=IEBGENER,COND=(0,NE)
//SYSUT1   DD DSN=CARDDEMO.J.CUSTRPT,DISP=SHR
//SYSUT2   DD SYSOUT=*,
//*           OUTPUT CHARS=(漢字フォント指定が移行時の論点)
//             OUTLIM=100000
//SYSPRINT DD SYSOUT=*
//SYSIN    DD DUMMY
//

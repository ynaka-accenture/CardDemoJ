//YOSIN    JOB (ACCT),'YOSIN MEISAI',CLASS=A,MSGCLASS=X,
//             NOTIFY=&SYSUID
//*********************************************************************
//* 日本版CardDemo - 与信明細バッチ(IMS-DB2-MQ オプション)
//* 与信明細を読み、漢字加盟店名の文字数を判定。
//* IMSデータベース(DBPAUJP0)にアクセスし、DB2へ与信結果を格納。
//*
//* 文字コード境界:
//*   IMSセグメントの漢字フィールドはEBCDICバイト列。
//*   DB2列のCCSID(EBCDIC混在)とUTF-8(CCSID1208)の不一致が移行論点。
//*********************************************************************
//*------------------------------------------------------------------
//* ステップ1: 与信明細処理(CBPAUJ0C)
//*            IMS DL/I バッチとして PSB(PSBPAUJB)を指定して実行
//*------------------------------------------------------------------
//STEP010  EXEC PGM=DFSRRC00,
//             PARM='DLI,CBPAUJ0C,PSBPAUJB'
//STEPLIB  DD DSN=CARDDEMO.J.LOADLIB,DISP=SHR
//         DD DSN=IMS.SDFSRESL,DISP=SHR
//*        IMS DBD/PSB ライブラリ
//IMS      DD DSN=CARDDEMO.J.DBDLIB,DISP=SHR
//         DD DSN=CARDDEMO.J.PSBLIB,DISP=SHR
//*        与信DB(HIDAM VSAM)
//DDPAUJP0 DD DSN=CARDDEMO.J.PAUTH.DB,DISP=SHR
//*        与信明細入力(漢字加盟店名を含む)
//PAUTHIN  DD DSN=CARDDEMO.J.PAUTH.IN,DISP=SHR
//*        DB2接続(CCSID変換を伴う)
//SYSTSIN  DD *
  DSN SYSTEM(DB2P)
  RUN PROGRAM(CBPAUJ0C) PLAN(CBPAUJ0C)
  END
/*
//SYSOUT   DD SYSOUT=*
//SYSPRINT DD SYSOUT=*
//

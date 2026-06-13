//MEISAI   JOB (ACCT),'MEISAI',CLASS=A,MSGCLASS=X,
//             NOTIFY=&SYSUID
//*********************************************************************
//* 日本版CardDemo - 明細書ジョブ
//* 明細書作成(漢字氏名・住所・加盟店名)
//* 文字コード: IBM EBCDIC日本語(IBM漢字, CCSID 930/939/5035)。漢字はSO/SIで囲む混在フィールド。
//*********************************************************************
//STEP010  EXEC PGM=CBSTMJ3A
//STEPLIB  DD DSN=CARDDEMO.J.LOADLIB,DISP=SHR
//INFILE   DD DSN=CARDDEMO.J.STMTDATA,DISP=SHR
//SYSOUT   DD SYSOUT=*
//OUTFILE  DD DSN=CARDDEMO.J.STMTDATA.OUT,DISP=(NEW,CATLG,DELETE),
//             SPACE=(CYL,(1,1)),
//             DCB=(RECFM=FB,LRECL=160,BLKSIZE=1600)
//SYSIN    DD DUMMY
//

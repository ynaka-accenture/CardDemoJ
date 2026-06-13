//TRANTYPE JOB (ACCT),'TRANTYPE',CLASS=A,MSGCLASS=X,
//             NOTIFY=&SYSUID
//*********************************************************************
//* 日本版CardDemo - 取引タイプジョブ
//* 取引タイプDB2更新(桁あふれ)
//* 文字コード: IBM EBCDIC日本語(IBM漢字, CCSID 930/939/5035)。漢字はSO/SIで囲む混在フィールド。
//*********************************************************************
//STEP010  EXEC PGM=COBTUPJT
//STEPLIB  DD DSN=CARDDEMO.J.LOADLIB,DISP=SHR
//INFILE   DD DSN=CARDDEMO.J.TRANTYPE,DISP=SHR
//SYSOUT   DD SYSOUT=*
//OUTFILE  DD DSN=CARDDEMO.J.TRANTYPE.OUT,DISP=(NEW,CATLG,DELETE),
//             SPACE=(CYL,(1,1)),
//             DCB=(RECFM=FB,LRECL=160,BLKSIZE=1600)
//SYSIN    DD DUMMY
//

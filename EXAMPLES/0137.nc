$BR0137.MIN%
O0137
VGRIN[1]=1 VGRFN[1]=1 VGRL[1]=40 VGRA2[1]=3 VGRA1[1]=55
VGRIN[6]=19 VGRFN[6]=1 VGRW[6]=3.1 VGRL[6]=40 VGRA1[6]=90
VGRIN[3]=4 VGRFN[3]=1 VGRL[3]=40 VGRA2[3]=5 VGRA1[3]=55
VGRIN[6]=19 VGRFN[6]=1 VGRW[6]=3.1 VGRL[6]=40 VGRA1[6]=90
VGRIN[7]=10 VGRFN[7]=1 VGRL[7]=40 VGRA2[7]=5 VGRA1[7]=55
VGRIN[11]=10 VGRFN[11]=1 VGRL[11]=40 VGRA2[11]=3 VGRA1[11]=55
VGRIN[5]=7 VGRFN[5]=1 VGRL[5]=40 VGRA2[5]=3 VGRA1[5]=55
VGRIN[10]=7 VGRFN[10]=1 VGRL[10]=40 VGRA2[10]=5 VGRA1[10]=55
VTSL=82 VTSDB=36 VTSDA=5 VWKR=602
VCHKL=0 VCHKD=0 VCHKX=80 VCHKZ=0
DEF WORK
PT LF,LC,[0,0],[80,80],[602,0]
END
CLEAR
DRAW
N0002 G50 S3200
NAT00
N0100 M90
N0101 CALL OCHEK
N0102 CALL OCHK1
N0103 CALL OSETZ DRIV=88.5
NAG01
N0200 G00 X1000 Z605
N0201 M216
N0202 VLMON[1]=11
N0203 G97 S995 M42 M03 M08
N0204 X80 TG=01 OG=1
N0205 G96 S250
N0206 G85 N0207 D7 F0.4 U0.4 W0.1
N0207 G81
N0208 G00 X42.018
N0209 G01 Z602.5 G42 E0.4
N0210 G03 X48.018 Z599.5 K-3
N0211 G01 Z552
N0212 X47.62
N0213 Z550.8
N0214 G02 X49.22 Z550 I0.8
N0215 G01 X49.68
N0216 G03 X49.98 Z549.85 K-0.15
N0217 G01 Z532.5
N0218 X50.013
N0219 Z513
N0220 G02 X52.013 Z512 I1
N0221 G01 X55.02
N0222 G03 X57.02 Z511 K-1
N0223 G01 Z483
N0224 G02 X59.02 Z482 I1
N0225 G01 X70.9
N0226 G03 X72.9 Z481 K-1
N0227 G01 Z452
N0228 X73.1
N0229 Z287
N0230 X72.7
N0231 Z285
N0232 X77
N0233 G03 X78 Z284.5 K-0.5
N0234 G01 Z284
N0235 Z210
N0236 G40
N0237 G80
N0238 VLMON[1]=0
N0239 M215
N0241 G00 X1000 Z605
NAT00
N0300 VTOFX[16]=VTOFX[6]VTOFZ[16]=VTOFZ[6]-3.1(2ND OFFSET)
N0301 VNSRX[6]=0.3 VNSRZ[6]=0.3
N0302 VNSRX[16]=0.3 VNSRZ[16]=-0.3
NAG06
N0400 G00 X1000 Z531.05
N0401 M216
N0402 VLMON[2]=1
N0404 X52 TG=06 OG=1
N0405 G96 S140
N0406 G73 X47 Z534.15 K2.79 D4 L12.4 F0.1 E0.14 OG=2
N0407 G00 Z530.45 TG=06 OG=1
N0408 G01 X50.013 G41 F0.1
N0409 G02 X48.813 Z531.05 I-0.6
N0410 G40 G01 K1
N0411 G00 X52
N0412 Z534.75 TG=06 OG=2
N0413 G01 X50.013 G42 F0.1
N0414 G03 X48.813 Z534.15 I-0.6
N0415 G40 G01 K-1
N0416 G00 X52
N0417 VLMON[2]=0
N0418 M215
N0420 G00 X1000 Z531.05
NAG03
N0500 G00 X1000 Z-3
N0501 M216
N0502 VLMON[3]=11
N0504 X88 TG=03 OG=1
N0505 X80
N0506 G96 S250
N0507 G85 N0508 D7 F0.4 U0.4 W0.1
N0508 G81
N0509 G00 X49.01
N0510 G01 Z-0.5 G41 E0.4
N0511 X49.011
N0512 G02 X55.011 Z2.5 K3
N0513 G01 X55.03 Z109
N0514 G03 X57.03 Z110 I1
N0515 G01 X57.98
N0516 G02 X59.98 Z111 K1
N0517 G01 Z142.5
N0518 X60.015
N0519 Z173
N0520 G03 X62.015 Z174 I1
N0521 G01 X70.02
N0522 G02 X72.02 Z175 K1
N0523 G01 Z214
N0524 G03 X74.02 Z215 I1
N0525 G01 X77
N0526 G02 X78 Z215.5 K0.5
N0527 G01 Z216
N0528 G40
N0529 G80
N0530 VLMON[3]=0
N0531 M215
N0533 G00 X88
N0534 X1000 Z-3
NAT00
N0600 VTOFX[16]=VTOFX[6]VTOFZ[16]=VTOFZ[6]-3.1(2ND OFFSET)
N0601 VNSRX[6]=0.3 VNSRZ[6]=0.3
N0602 VNSRX[16]=0.3 VNSRZ[16]=-0.3
NAG06
N0700 G00 X1000 Z140.9
N0701 M216
N0702 VLMON[4]=1
N0704 X62 TG=06 OG=1
N0705 G96 S140
N0706 G73 X56.9 Z144 K2.79 D4 L12.4 F0.1 E0.167 OG=2
N0707 G00 Z140.3 TG=06 OG=1
N0708 G01 X60.015 G41 F0.1
N0709 G02 X58.815 Z140.9 I-0.6
N0710 G40 G01 K1
N0711 G00 X62
N0712 Z144.6 TG=06 OG=2
N0713 G01 X60.015 G42 F0.1
N0714 G03 X58.815 Z144 I-0.6
N0715 G40 G01 K-1
N0716 G00 X62
N0717 VLMON[4]=0
N0718 M215
N0719 G97 S719 M05 M09
N0720 G00 X1000 Z140.9
NAG07
N0800 G00 X1000 Z-3
N0801 M216
N0802 VLMON[5]=1
N0803 G97 S1600 M44 M03 M08
N0804 X88 Z-1 TG=07 OG=1
N0805 X80
N0807 G87 N0808
N0808 G81
N0809 G00 X49.020
N0810 G01 Z-0.5 G41 F0.2
N0812 G02 X55.020 Z2.5 K3 F.1
N0813 G01 X55.03 Z109
N0814 G03 X57.03 Z110 I1
N0815 G01 X57.98
N0816 G02 X59.98 Z111 K1
N0817 G01 Z142.5
N0818 X60.015
N0819 Z173
N0820 G03 X62.015 Z174 I1
N0821 G01 X70.02
N0822 G02 X72.02 Z175 K1
N0823 G40 G01
N0824 G80
N0825 G01 X72.22 Z173.9
N0826 VLMON[5]=0
N0827 M215
N0829 G00 X88
N0830 X1000 Z-3
NAG11
N0900 G00 X1000 Z169
N0901 M216
N0902 VLMON[6]=1
N0904 X88 TG=11 OG=1
N0905 X80
N0906 S1600
N0907 G87 N0908
N0908 G81
N0909 G00 X72
N0910 G01 Z172 G41 F0.2
N0911 Z214 F0.1
N0912 G03 X74 Z215 I1
N0913 G01 X77
N0914 G02 X78 Z215.5 K0.5
N0915 G01 Z216
N0916 G40
N0917 G80
N0918 G01 X78.2 Z214.9
N0919 VLMON[6]=0
N0920 M215
N0922 G00 X88
N0923 X1000 Z169
NAG05
N1000 G00 Z607
N1001 X1000
N1002 M216
N1003 VLMON[7]=1
N1005 X80 Z603 TG=05 OG=1
N1006 S1600
N1007 G87 N1008
N1008 G81
N1009 G00 X42.010
N1010 G01 Z602.5 G42 F0.2
N1011 G03 X48.010 Z599.5 K-3 F0.1
N1012 G01 Z552
N1013 X47.62
N1014 Z550.8
N1015 G02 X49.22 Z550 I0.8
N1016 G01 X49.68
N1017 G03 X49.98 Z549.85 K-0.15
N1018 G01 Z532.5
N1019 X50.013
N1020 Z513
N1021 G02 X52.013 Z512 I1
N1022 G01 X55.02
N1023 G03 X57.02 Z511 K-1
N1024 G40 G01
N1025 G80
N1026 G01 X57.22 Z512.1
N1027 VLMON[7]=0
N1028 M215
N1030 G00 X1000 Z607
NAG10
N1100 G00 X1000
N1101 Z517
N1102 M216
N1103 VLMON[8]=1
N1105 X80 TG=10 OG=1
N1106 S1600
N1107 G87 N1108
N1108 G81
N1109 G00 X57
N1110 G01 Z514 G42 F0.2
N1111 Z483 F0.1
N1112 G02 X59 Z482 I1
N1113 G01 X70.9
N1114 G03 X72.9 Z481 K-1
N1115 G01 Z452
N1116 X73.1
N1117 Z287 F0.3
N1118 X72.7 F0.1
N1119 Z285
N1120 X77
N1121 G03 X78 Z284.5 K-0.5
N1122 G01 Z284
N1123 G40
N1124 G80
N1125 G01 X78.2 Z285.1
N1126 VLMON[8]=0
N1127 M215
N1128 G97 S1628 M05 M09
N1129 G00 X1000 Z700
N1130 TLID
N1130 M91
N1131 M02
%
   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.3 - 22 May 2025
   3                     ; Generator (Limited) V4.6.5 - 22 May 2025
  14                     	bsct
  15  0000               _change:
  16  0000 01            	dc.b	1
  17  0001               _seconds_counter:
  18  0001 00            	dc.b	0
  19  0002               _timeout_active:
  20  0002 00            	dc.b	0
  21  0003               _timeout_hold_counter:
  22  0003 00            	dc.b	0
  72                     ; 19 void delay_ms(uint16_t ms)
  72                     ; 20 {
  74                     	switch	.text
  75  0000               _delay_ms:
  77  0000 89            	pushw	x
  78       00000002      OFST:	set	2
  81                     ; 21     uint16_t count = ms * 0.4;
  83  0001 cd0000        	call	c_uitof
  85  0004 ae0000        	ldw	x,#L73
  86  0007 cd0000        	call	c_fmul
  88  000a cd0000        	call	c_ftoi
  90  000d 1f01          	ldw	(OFST-1,sp),x
  93  000f 2001          	jra	L74
  94  0011               L34:
  95                     ; 22     while(count--) { nop(); }
  98  0011 9d            nop
 101  0012               L74:
 104  0012 1e01          	ldw	x,(OFST-1,sp)
 105  0014 1d0001        	subw	x,#1
 106  0017 1f01          	ldw	(OFST-1,sp),x
 107  0019 1c0001        	addw	x,#1
 109  001c a30000        	cpw	x,#0
 110  001f 26f0          	jrne	L34
 111                     ; 23 }
 114  0021 85            	popw	x
 115  0022 81            	ret
 160                     ; 26 void ws_write_byte_top(uint8_t byte)
 160                     ; 27 {
 161                     	switch	.text
 162  0023               _ws_write_byte_top:
 164  0023 88            	push	a
 165  0024 88            	push	a
 166       00000001      OFST:	set	1
 169                     ; 28     uint8_t mask = 0x80;
 171  0025 a680          	ld	a,#128
 172  0027 6b01          	ld	(OFST+0,sp),a
 174  0029               L57:
 175                     ; 30         if(byte & mask) {
 177  0029 7b02          	ld	a,(OFST+1,sp)
 178  002b 1501          	bcp	a,(OFST+0,sp)
 179  002d 2716          	jreq	L301
 180                     ; 31             _asm("bset 20495,#4");
 183  002f 7218500f      bset 20495,#4
 185                     ; 32             nop();nop();nop();nop();nop();nop();nop();nop();
 188  0033 9d            nop
 194  0034 9d            nop
 200  0035 9d            nop
 206  0036 9d            nop
 212  0037 9d            nop
 218  0038 9d            nop
 224  0039 9d            nop
 230  003a 9d            nop
 232                     ; 33             nop();nop();nop();nop();
 236  003b 9d            nop
 242  003c 9d            nop
 248  003d 9d            nop
 254  003e 9d            nop
 256                     ; 34             _asm("bres 20495,#4");
 260  003f 7219500f      bres 20495,#4
 263  0043 2011          	jra	L501
 264  0045               L301:
 265                     ; 36             _asm("bset 20495,#4");
 268  0045 7218500f      bset 20495,#4
 270                     ; 37             nop();nop();nop();nop();nop();nop();
 273  0049 9d            nop
 279  004a 9d            nop
 285  004b 9d            nop
 291  004c 9d            nop
 297  004d 9d            nop
 303  004e 9d            nop
 305                     ; 38             _asm("bres 20495,#4");
 309  004f 7219500f      bres 20495,#4
 311                     ; 39             nop();nop();nop();
 314  0053 9d            nop
 320  0054 9d            nop
 326  0055 9d            nop
 328  0056               L501:
 329                     ; 41         mask >>= 1;
 331  0056 0401          	srl	(OFST+0,sp)
 333                     ; 29     while(mask) {
 335  0058 0d01          	tnz	(OFST+0,sp)
 336  005a 26cd          	jrne	L57
 337                     ; 43 }
 340  005c 85            	popw	x
 341  005d 81            	ret
 386                     ; 45 void ws_write_byte_bot(uint8_t byte)
 386                     ; 46 {
 387                     	switch	.text
 388  005e               _ws_write_byte_bot:
 390  005e 88            	push	a
 391  005f 88            	push	a
 392       00000001      OFST:	set	1
 395                     ; 47     uint8_t mask = 0x80;
 397  0060 a680          	ld	a,#128
 398  0062 6b01          	ld	(OFST+0,sp),a
 400  0064               L131:
 401                     ; 49         if(byte & mask) {
 403  0064 7b02          	ld	a,(OFST+1,sp)
 404  0066 1501          	bcp	a,(OFST+0,sp)
 405  0068 2716          	jreq	L731
 406                     ; 50             _asm("bset 20495,#5");
 409  006a 721a500f      bset 20495,#5
 411                     ; 51             nop();nop();nop();nop();nop();nop();nop();nop();
 414  006e 9d            nop
 420  006f 9d            nop
 426  0070 9d            nop
 432  0071 9d            nop
 438  0072 9d            nop
 444  0073 9d            nop
 450  0074 9d            nop
 456  0075 9d            nop
 458                     ; 52             nop();nop();nop();nop();
 462  0076 9d            nop
 468  0077 9d            nop
 474  0078 9d            nop
 480  0079 9d            nop
 482                     ; 53             _asm("bres 20495,#5");
 486  007a 721b500f      bres 20495,#5
 489  007e 2011          	jra	L141
 490  0080               L731:
 491                     ; 55             _asm("bset 20495,#5");
 494  0080 721a500f      bset 20495,#5
 496                     ; 56             nop();nop();nop();nop();nop();nop();
 499  0084 9d            nop
 505  0085 9d            nop
 511  0086 9d            nop
 517  0087 9d            nop
 523  0088 9d            nop
 529  0089 9d            nop
 531                     ; 57             _asm("bres 20495,#5");
 535  008a 721b500f      bres 20495,#5
 537                     ; 58             nop();nop();nop();
 540  008e 9d            nop
 546  008f 9d            nop
 552  0090 9d            nop
 554  0091               L141:
 555                     ; 60         mask >>= 1;
 557  0091 0401          	srl	(OFST+0,sp)
 559                     ; 48     while(mask) {
 561  0093 0d01          	tnz	(OFST+0,sp)
 562  0095 26cd          	jrne	L131
 563                     ; 62 }
 566  0097 85            	popw	x
 567  0098 81            	ret
 603                     ; 64 static void ws_write_grb_top(uint8_t *c)
 603                     ; 65 {
 604                     	switch	.text
 605  0099               L341_ws_write_grb_top:
 607  0099 89            	pushw	x
 608       00000000      OFST:	set	0
 611                     ; 66     ws_write_byte_top(c[0]);
 613  009a f6            	ld	a,(x)
 614  009b ad86          	call	_ws_write_byte_top
 616                     ; 67     ws_write_byte_top(c[1]);
 618  009d 1e01          	ldw	x,(OFST+1,sp)
 619  009f e601          	ld	a,(1,x)
 620  00a1 ad80          	call	_ws_write_byte_top
 622                     ; 68     ws_write_byte_top(c[2]);
 624  00a3 1e01          	ldw	x,(OFST+1,sp)
 625  00a5 e602          	ld	a,(2,x)
 626  00a7 cd0023        	call	_ws_write_byte_top
 628                     ; 69 }
 631  00aa 85            	popw	x
 632  00ab 81            	ret
 668                     ; 71 static void ws_write_grb_bot(uint8_t *c)
 668                     ; 72 {
 669                     	switch	.text
 670  00ac               L361_ws_write_grb_bot:
 672  00ac 89            	pushw	x
 673       00000000      OFST:	set	0
 676                     ; 73     ws_write_byte_bot(c[0]);
 678  00ad f6            	ld	a,(x)
 679  00ae adae          	call	_ws_write_byte_bot
 681                     ; 74     ws_write_byte_bot(c[1]);
 683  00b0 1e01          	ldw	x,(OFST+1,sp)
 684  00b2 e601          	ld	a,(1,x)
 685  00b4 ada8          	call	_ws_write_byte_bot
 687                     ; 75     ws_write_byte_bot(c[2]);
 689  00b6 1e01          	ldw	x,(OFST+1,sp)
 690  00b8 e602          	ld	a,(2,x)
 691  00ba ada2          	call	_ws_write_byte_bot
 693                     ; 76 }
 696  00bc 85            	popw	x
 697  00bd 81            	ret
 736                     ; 79 void write_display(void)
 736                     ; 80 {
 737                     	switch	.text
 738  00be               _write_display:
 740  00be 88            	push	a
 741       00000001      OFST:	set	1
 744                     ; 83     CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
 746  00bf 4f            	clr	a
 747  00c0 cd0000        	call	_CLK_HSIPrescalerConfig
 749                     ; 84     CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
 751  00c3 a680          	ld	a,#128
 752  00c5 cd0000        	call	_CLK_SYSCLKConfig
 754                     ; 86     for(i = 0; i < NUM_LEDS_HALF; i++)
 756  00c8 0f01          	clr	(OFST+0,sp)
 758  00ca               L122:
 759                     ; 87         ws_write_grb_top(lights[i]);
 761  00ca 7b01          	ld	a,(OFST+0,sp)
 762  00cc 97            	ld	xl,a
 763  00cd a603          	ld	a,#3
 764  00cf 42            	mul	x,a
 765  00d0 01            	rrwa	x,a
 766  00d1 ab00          	add	a,#_lights
 767  00d3 2401          	jrnc	L02
 768  00d5 5c            	incw	x
 769  00d6               L02:
 770  00d6 5f            	clrw	x
 771  00d7 97            	ld	xl,a
 772  00d8 adbf          	call	L341_ws_write_grb_top
 774                     ; 86     for(i = 0; i < NUM_LEDS_HALF; i++)
 776  00da 0c01          	inc	(OFST+0,sp)
 780  00dc 7b01          	ld	a,(OFST+0,sp)
 781  00de a107          	cp	a,#7
 782  00e0 25e8          	jrult	L122
 783                     ; 89     for(i = 0; i < NUM_LEDS_HALF; i++)
 785  00e2 0f01          	clr	(OFST+0,sp)
 787  00e4               L722:
 788                     ; 90         ws_write_grb_bot(lights[i]);
 790  00e4 7b01          	ld	a,(OFST+0,sp)
 791  00e6 97            	ld	xl,a
 792  00e7 a603          	ld	a,#3
 793  00e9 42            	mul	x,a
 794  00ea 01            	rrwa	x,a
 795  00eb ab00          	add	a,#_lights
 796  00ed 2401          	jrnc	L22
 797  00ef 5c            	incw	x
 798  00f0               L22:
 799  00f0 5f            	clrw	x
 800  00f1 97            	ld	xl,a
 801  00f2 adb8          	call	L361_ws_write_grb_bot
 803                     ; 89     for(i = 0; i < NUM_LEDS_HALF; i++)
 805  00f4 0c01          	inc	(OFST+0,sp)
 809  00f6 7b01          	ld	a,(OFST+0,sp)
 810  00f8 a107          	cp	a,#7
 811  00fa 25e8          	jrult	L722
 812                     ; 92     CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV8);
 814  00fc a618          	ld	a,#24
 815  00fe cd0000        	call	_CLK_HSIPrescalerConfig
 817                     ; 93     CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV128);
 819  0101 a687          	ld	a,#135
 820  0103 cd0000        	call	_CLK_SYSCLKConfig
 822                     ; 94 }
 825  0106 84            	pop	a
 826  0107 81            	ret
 861                     ; 97 void clear_lights(void)
 861                     ; 98 {
 862                     	switch	.text
 863  0108               _clear_lights:
 865  0108 88            	push	a
 866       00000001      OFST:	set	1
 869                     ; 100     for(i=0;i<NUM_LEDS;i++)
 871  0109 0f01          	clr	(OFST+0,sp)
 873  010b               L352:
 874                     ; 101         lights[i][0] = lights[i][1] = lights[i][2] = 0;
 876  010b 7b01          	ld	a,(OFST+0,sp)
 877  010d 97            	ld	xl,a
 878  010e a603          	ld	a,#3
 879  0110 42            	mul	x,a
 880  0111 6f02          	clr	(_lights+2,x)
 881  0113 7b01          	ld	a,(OFST+0,sp)
 882  0115 97            	ld	xl,a
 883  0116 a603          	ld	a,#3
 884  0118 42            	mul	x,a
 885  0119 6f01          	clr	(_lights+1,x)
 886  011b 7b01          	ld	a,(OFST+0,sp)
 887  011d 97            	ld	xl,a
 888  011e a603          	ld	a,#3
 889  0120 42            	mul	x,a
 890  0121 6f00          	clr	(_lights,x)
 891                     ; 100     for(i=0;i<NUM_LEDS;i++)
 893  0123 0c01          	inc	(OFST+0,sp)
 897  0125 7b01          	ld	a,(OFST+0,sp)
 898  0127 a10e          	cp	a,#14
 899  0129 25e0          	jrult	L352
 900                     ; 102 }
 903  012b 84            	pop	a
 904  012c 81            	ret
 938                     ; 105 uint8_t linearSine(uint8_t v)
 938                     ; 106 {
 939                     	switch	.text
 940  012d               _linearSine:
 942  012d 88            	push	a
 943       00000000      OFST:	set	0
 946                     ; 107     v &= 255;
 948  012e 7b01          	ld	a,(OFST+1,sp)
 949  0130 a4ff          	and	a,#255
 950  0132 6b01          	ld	(OFST+1,sp),a
 951                     ; 108     return (v < 128) ? v : (255 - v);
 953  0134 7b01          	ld	a,(OFST+1,sp)
 954  0136 a180          	cp	a,#128
 955  0138 2404          	jruge	L03
 956  013a 7b01          	ld	a,(OFST+1,sp)
 957  013c 2004          	jra	L23
 958  013e               L03:
 959  013e a6ff          	ld	a,#255
 960  0140 1001          	sub	a,(OFST+1,sp)
 961  0142               L23:
 964  0142 5b01          	addw	sp,#1
 965  0144 81            	ret
1059                     ; 112 void downwardFade(void)
1059                     ; 113 {
1060                     	switch	.text
1061  0145               _downwardFade:
1063  0145 5208          	subw	sp,#8
1064       00000008      OFST:	set	8
1067                     ; 114     uint8_t t = 0;
1069  0147 0f04          	clr	(OFST-4,sp)
1071                     ; 117     int startHue = rand() & 0xFF;
1073  0149 cd0000        	call	_rand
1075  014c 01            	rrwa	x,a
1076  014d a4ff          	and	a,#255
1077  014f 5f            	clrw	x
1078  0150 02            	rlwa	x,a
1079  0151 1f02          	ldw	(OFST-6,sp),x
1080  0153 01            	rrwa	x,a
1082                     ; 119     change = FALSE;
1084  0154 3f00          	clr	_change
1085                     ; 120     clear_lights();
1087  0156 adb0          	call	_clear_lights
1090  0158 ac350235      	jpf	L743
1091  015c               L543:
1092                     ; 124 				for(i = 0; i < NUM_LEDS; i++)
1094  015c 0f07          	clr	(OFST-1,sp)
1096  015e               L353:
1097                     ; 127             hue = (startHue + t + i*12) & 0xFF;
1099  015e 7b07          	ld	a,(OFST-1,sp)
1100  0160 97            	ld	xl,a
1101  0161 a60c          	ld	a,#12
1102  0163 42            	mul	x,a
1103  0164 9f            	ld	a,xl
1104  0165 6b01          	ld	(OFST-7,sp),a
1106  0167 7b03          	ld	a,(OFST-5,sp)
1107  0169 1b04          	add	a,(OFST-4,sp)
1108  016b 1b01          	add	a,(OFST-7,sp)
1109  016d a4ff          	and	a,#255
1110  016f 6b08          	ld	(OFST+0,sp),a
1112                     ; 129             if(hue < 85) {
1114  0171 7b08          	ld	a,(OFST+0,sp)
1115  0173 a155          	cp	a,#85
1116  0175 2419          	jruge	L163
1117                     ; 130                 r = 255 - hue*3;
1119  0177 7b08          	ld	a,(OFST+0,sp)
1120  0179 97            	ld	xl,a
1121  017a a603          	ld	a,#3
1122  017c 42            	mul	x,a
1123  017d 9f            	ld	a,xl
1124  017e a0ff          	sub	a,#255
1125  0180 40            	neg	a
1126  0181 6b05          	ld	(OFST-3,sp),a
1128                     ; 131                 g = hue*3;
1130  0183 7b08          	ld	a,(OFST+0,sp)
1131  0185 97            	ld	xl,a
1132  0186 a603          	ld	a,#3
1133  0188 42            	mul	x,a
1134  0189 9f            	ld	a,xl
1135  018a 6b06          	ld	(OFST-2,sp),a
1137                     ; 132                 b = 0;
1139  018c 0f08          	clr	(OFST+0,sp)
1142  018e 203a          	jra	L363
1143  0190               L163:
1144                     ; 133             } else if(hue < 170) {
1146  0190 7b08          	ld	a,(OFST+0,sp)
1147  0192 a1aa          	cp	a,#170
1148  0194 241b          	jruge	L563
1149                     ; 134                 r = 0;
1151  0196 0f05          	clr	(OFST-3,sp)
1153                     ; 135                 g = 255 - (hue-85)*3;
1155  0198 7b08          	ld	a,(OFST+0,sp)
1156  019a 97            	ld	xl,a
1157  019b a603          	ld	a,#3
1158  019d 42            	mul	x,a
1159  019e 9f            	ld	a,xl
1160  019f a0fe          	sub	a,#254
1161  01a1 40            	neg	a
1162  01a2 6b06          	ld	(OFST-2,sp),a
1164                     ; 136                 b = (hue-85)*3;
1166  01a4 7b08          	ld	a,(OFST+0,sp)
1167  01a6 97            	ld	xl,a
1168  01a7 a603          	ld	a,#3
1169  01a9 42            	mul	x,a
1170  01aa 9f            	ld	a,xl
1171  01ab a0ff          	sub	a,#255
1172  01ad 6b08          	ld	(OFST+0,sp),a
1175  01af 2019          	jra	L363
1176  01b1               L563:
1177                     ; 138                 r = (hue-170)*3;
1179  01b1 7b08          	ld	a,(OFST+0,sp)
1180  01b3 97            	ld	xl,a
1181  01b4 a603          	ld	a,#3
1182  01b6 42            	mul	x,a
1183  01b7 9f            	ld	a,xl
1184  01b8 a0fe          	sub	a,#254
1185  01ba 6b05          	ld	(OFST-3,sp),a
1187                     ; 139                 g = 0;
1189  01bc 0f06          	clr	(OFST-2,sp)
1191                     ; 140                 b = 255 - (hue-170)*3;
1193  01be 7b08          	ld	a,(OFST+0,sp)
1194  01c0 97            	ld	xl,a
1195  01c1 a603          	ld	a,#3
1196  01c3 42            	mul	x,a
1197  01c4 9f            	ld	a,xl
1198  01c5 a0fd          	sub	a,#253
1199  01c7 40            	neg	a
1200  01c8 6b08          	ld	(OFST+0,sp),a
1202  01ca               L363:
1203                     ; 143             r = (r * MAX_BRIGHTNESS) / 255;
1205  01ca 7b05          	ld	a,(OFST-3,sp)
1206  01cc 97            	ld	xl,a
1207  01cd a614          	ld	a,#20
1208  01cf 42            	mul	x,a
1209  01d0 90ae00ff      	ldw	y,#255
1210  01d4 cd0000        	call	c_idiv
1212  01d7 01            	rrwa	x,a
1213  01d8 6b05          	ld	(OFST-3,sp),a
1214  01da 02            	rlwa	x,a
1216                     ; 144             g = (g * MAX_BRIGHTNESS) / 255;
1218  01db 7b06          	ld	a,(OFST-2,sp)
1219  01dd 97            	ld	xl,a
1220  01de a614          	ld	a,#20
1221  01e0 42            	mul	x,a
1222  01e1 90ae00ff      	ldw	y,#255
1223  01e5 cd0000        	call	c_idiv
1225  01e8 01            	rrwa	x,a
1226  01e9 6b06          	ld	(OFST-2,sp),a
1227  01eb 02            	rlwa	x,a
1229                     ; 145             b = (b * MAX_BRIGHTNESS) / 255;
1231  01ec 7b08          	ld	a,(OFST+0,sp)
1232  01ee 97            	ld	xl,a
1233  01ef a614          	ld	a,#20
1234  01f1 42            	mul	x,a
1235  01f2 90ae00ff      	ldw	y,#255
1236  01f6 cd0000        	call	c_idiv
1238  01f9 01            	rrwa	x,a
1239  01fa 6b08          	ld	(OFST+0,sp),a
1240  01fc 02            	rlwa	x,a
1242                     ; 147             lights[i][0] = r;
1244  01fd 7b07          	ld	a,(OFST-1,sp)
1245  01ff 97            	ld	xl,a
1246  0200 a603          	ld	a,#3
1247  0202 42            	mul	x,a
1248  0203 7b05          	ld	a,(OFST-3,sp)
1249  0205 e700          	ld	(_lights,x),a
1250                     ; 148             lights[i][1] = g;
1252  0207 7b07          	ld	a,(OFST-1,sp)
1253  0209 97            	ld	xl,a
1254  020a a603          	ld	a,#3
1255  020c 42            	mul	x,a
1256  020d 7b06          	ld	a,(OFST-2,sp)
1257  020f e701          	ld	(_lights+1,x),a
1258                     ; 149             lights[i][2] = b;
1260  0211 7b07          	ld	a,(OFST-1,sp)
1261  0213 97            	ld	xl,a
1262  0214 a603          	ld	a,#3
1263  0216 42            	mul	x,a
1264  0217 7b08          	ld	a,(OFST+0,sp)
1265  0219 e702          	ld	(_lights+2,x),a
1266                     ; 124 				for(i = 0; i < NUM_LEDS; i++)
1268  021b 0c07          	inc	(OFST-1,sp)
1272  021d 7b07          	ld	a,(OFST-1,sp)
1273  021f a10e          	cp	a,#14
1274  0221 2403          	jruge	L63
1275  0223 cc015e        	jp	L353
1276  0226               L63:
1277                     ; 152         write_display();
1279  0226 cd00be        	call	_write_display
1281                     ; 154         t -= 6;
1283  0229 7b04          	ld	a,(OFST-4,sp)
1284  022b a006          	sub	a,#6
1285  022d 6b04          	ld	(OFST-4,sp),a
1287                     ; 155         delay_ms(15);
1289  022f ae000f        	ldw	x,#15
1290  0232 cd0000        	call	_delay_ms
1292  0235               L743:
1293                     ; 122     while(!change)
1295  0235 3d00          	tnz	_change
1296  0237 2603          	jrne	L04
1297  0239 cc015c        	jp	L543
1298  023c               L04:
1299                     ; 157 }
1302  023c 5b08          	addw	sp,#8
1303  023e 81            	ret
1326                     ; 160 void init_tim2(void)
1326                     ; 161 {
1327                     	switch	.text
1328  023f               _init_tim2:
1332                     ; 162     TIM2->PSCR = 0x0E;     // prescaler ~16384
1334  023f 350e530e      	mov	21262,#14
1335                     ; 163     TIM2->ARRH = 0x03;     // ARR = 31250 ? 1 Hz (approx)
1337  0243 3503530f      	mov	21263,#3
1338                     ; 164     TIM2->ARRL = 0xD0;
1340  0247 35d05310      	mov	21264,#208
1341                     ; 165     TIM2->IER  = 0x01;     // enable update interrupt
1343  024b 35015303      	mov	21251,#1
1344                     ; 166     TIM2->CR1 |= 0x01;     // start timer
1346  024f 72105300      	bset	21248,#0
1347                     ; 167 }
1350  0253 81            	ret
1384                     ; 170 int main(void)
1384                     ; 171 {
1385                     	switch	.text
1386  0254               _main:
1390                     ; 172     sim();
1393  0254 9b            sim
1395                     ; 173     CLK_DeInit();
1398  0255 cd0000        	call	_CLK_DeInit
1400                     ; 174     CLK_HSICmd(ENABLE);
1402  0258 a601          	ld	a,#1
1403  025a cd0000        	call	_CLK_HSICmd
1405                     ; 176     CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV8);
1407  025d a618          	ld	a,#24
1408  025f cd0000        	call	_CLK_HSIPrescalerConfig
1410                     ; 177     CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV128);
1412  0262 a687          	ld	a,#135
1413  0264 cd0000        	call	_CLK_SYSCLKConfig
1415                     ; 179     GPIO_Init(GPIOD, GPIO_PIN_4, GPIO_MODE_OUT_PP_LOW_FAST);
1417  0267 4be0          	push	#224
1418  0269 4b10          	push	#16
1419  026b ae500f        	ldw	x,#20495
1420  026e cd0000        	call	_GPIO_Init
1422  0271 85            	popw	x
1423                     ; 180     GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_LOW_FAST);
1425  0272 4be0          	push	#224
1426  0274 4b20          	push	#32
1427  0276 ae500f        	ldw	x,#20495
1428  0279 cd0000        	call	_GPIO_Init
1430  027c 85            	popw	x
1431                     ; 182     GPIO_Init(GPIOA, GPIO_PIN_1, GPIO_MODE_OUT_PP_HIGH_FAST); // PA1 starts high
1433  027d 4bf0          	push	#240
1434  027f 4b02          	push	#2
1435  0281 ae5000        	ldw	x,#20480
1436  0284 cd0000        	call	_GPIO_Init
1438  0287 85            	popw	x
1439                     ; 184     srand(1234); // fixed seed, or replace with ADC seeding
1441  0288 ae04d2        	ldw	x,#1234
1442  028b cd0000        	call	_srand
1444                     ; 186     clear_lights();
1446  028e cd0108        	call	_clear_lights
1448                     ; 187     init_tim2();
1450  0291 adac          	call	_init_tim2
1452                     ; 188     rim();  // enable interrupts
1455  0293 9a            rim
1457  0294               L114:
1458                     ; 191         downwardFade();
1460  0294 cd0145        	call	_downwardFade
1463  0297 20fb          	jra	L114
1494                     ; 196 @svlreg @far @interrupt void tim2Handler(void)
1494                     ; 197 {
1496                     	switch	.text
1497  0299               f_tim2Handler:
1499  0299 8a            	push	cc
1500  029a 84            	pop	a
1501  029b a4bf          	and	a,#191
1502  029d 88            	push	a
1503  029e 86            	pop	cc
1504  029f 3b0002        	push	c_x+2
1505  02a2 be00          	ldw	x,c_x
1506  02a4 89            	pushw	x
1507  02a5 3b0002        	push	c_y+2
1508  02a8 be00          	ldw	x,c_y
1509  02aa 89            	pushw	x
1510  02ab be02          	ldw	x,c_lreg+2
1511  02ad 89            	pushw	x
1512  02ae be00          	ldw	x,c_lreg
1513  02b0 89            	pushw	x
1516                     ; 198     TIM2->SR1 &= ~0x01;  // clear interrupt flag
1518  02b1 72115304      	bres	21252,#0
1519                     ; 200     if(!timeout_active)
1521  02b5 3d02          	tnz	_timeout_active
1522  02b7 2625          	jrne	L524
1523                     ; 202         seconds_counter++;
1525  02b9 3c01          	inc	_seconds_counter
1526                     ; 203         if(seconds_counter >= TIMEOUT_SECONDS)
1528  02bb b601          	ld	a,_seconds_counter
1529  02bd a10a          	cp	a,#10
1530  02bf 2532          	jrult	L134
1531                     ; 205 						clear_lights();
1533  02c1 cd0108        	call	_clear_lights
1535                     ; 206 						write_display();
1537  02c4 cd00be        	call	_write_display
1539                     ; 208             GPIO_WriteLow(GPIOA, GPIO_PIN_1); // pull PA1 low
1541  02c7 4b02          	push	#2
1542  02c9 ae5000        	ldw	x,#20480
1543  02cc cd0000        	call	_GPIO_WriteLow
1545  02cf 84            	pop	a
1546                     ; 209             timeout_active = TRUE;
1548  02d0 35010002      	mov	_timeout_active,#1
1549                     ; 210             timeout_hold_counter = 0;
1551  02d4 3f03          	clr	_timeout_hold_counter
1552                     ; 212 						delay_ms(2000);
1554  02d6 ae07d0        	ldw	x,#2000
1555  02d9 cd0000        	call	_delay_ms
1557  02dc 2015          	jra	L134
1558  02de               L524:
1559                     ; 218         timeout_hold_counter++;
1561  02de 3c03          	inc	_timeout_hold_counter
1562                     ; 219         if(timeout_hold_counter >= TIMEOUT_HOLD)
1564  02e0 b603          	ld	a,_timeout_hold_counter
1565  02e2 a10a          	cp	a,#10
1566  02e4 250d          	jrult	L134
1567                     ; 221             GPIO_WriteHigh(GPIOA, GPIO_PIN_1); // release PA1
1569  02e6 4b02          	push	#2
1570  02e8 ae5000        	ldw	x,#20480
1571  02eb cd0000        	call	_GPIO_WriteHigh
1573  02ee 84            	pop	a
1574                     ; 223             timeout_active = FALSE;
1576  02ef 3f02          	clr	_timeout_active
1577                     ; 224             seconds_counter = 0;
1579  02f1 3f01          	clr	_seconds_counter
1580  02f3               L134:
1581                     ; 227 }
1584  02f3 85            	popw	x
1585  02f4 bf00          	ldw	c_lreg,x
1586  02f6 85            	popw	x
1587  02f7 bf02          	ldw	c_lreg+2,x
1588  02f9 85            	popw	x
1589  02fa bf00          	ldw	c_y,x
1590  02fc 320002        	pop	c_y+2
1591  02ff 85            	popw	x
1592  0300 bf00          	ldw	c_x,x
1593  0302 320002        	pop	c_x+2
1594  0305 80            	iret
1678                     	xdef	f_tim2Handler
1679                     	xdef	_main
1680                     	xdef	_init_tim2
1681                     	xdef	_downwardFade
1682                     	xdef	_linearSine
1683                     	xdef	_clear_lights
1684                     	xdef	_write_display
1685                     	xdef	_ws_write_byte_bot
1686                     	xdef	_ws_write_byte_top
1687                     	xdef	_delay_ms
1688                     	xdef	_timeout_hold_counter
1689                     	xdef	_timeout_active
1690                     	xdef	_seconds_counter
1691                     	switch	.ubsct
1692  0000               _lights:
1693  0000 000000000000  	ds.b	42
1694                     	xdef	_lights
1695                     	xdef	_change
1696                     	xref	_srand
1697                     	xref	_rand
1698                     	xref	_GPIO_WriteLow
1699                     	xref	_GPIO_WriteHigh
1700                     	xref	_GPIO_Init
1701                     	xref	_CLK_SYSCLKConfig
1702                     	xref	_CLK_HSIPrescalerConfig
1703                     	xref	_CLK_HSICmd
1704                     	xref	_CLK_DeInit
1705                     .const:	section	.text
1706  0000               L73:
1707  0000 3ecccccc      	dc.w	16076,-13108
1708                     	xref.b	c_lreg
1709                     	xref.b	c_x
1710                     	xref.b	c_y
1730                     	xref	c_idiv
1731                     	xref	c_ftoi
1732                     	xref	c_fmul
1733                     	xref	c_uitof
1734                     	end

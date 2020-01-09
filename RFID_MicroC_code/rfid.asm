
_main:

;rfid.c,17 :: 		void main()
;rfid.c,19 :: 		char i,rfid[13] = "123456781212";
	MOVLW      49
	MOVWF      main_rfid_L0+0
	MOVLW      50
	MOVWF      main_rfid_L0+1
	MOVLW      51
	MOVWF      main_rfid_L0+2
	MOVLW      52
	MOVWF      main_rfid_L0+3
	MOVLW      53
	MOVWF      main_rfid_L0+4
	MOVLW      54
	MOVWF      main_rfid_L0+5
	MOVLW      55
	MOVWF      main_rfid_L0+6
	MOVLW      56
	MOVWF      main_rfid_L0+7
	MOVLW      49
	MOVWF      main_rfid_L0+8
	MOVLW      50
	MOVWF      main_rfid_L0+9
	MOVLW      49
	MOVWF      main_rfid_L0+10
	MOVLW      50
	MOVWF      main_rfid_L0+11
	CLRF       main_rfid_L0+12
;rfid.c,20 :: 		Lcd_Init();                         // Initialize LCD
	CALL       _Lcd_Init+0
;rfid.c,21 :: 		Lcd_Cmd(_LCD_CLEAR);                // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;rfid.c,22 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);           // Cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;rfid.c,23 :: 		Lcd_Out(1,1,"ICE RFID PROJECT");     // Write text in first row
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_rfid+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;rfid.c,24 :: 		Lcd_Out(2,1,"SWAP YOUR CARD");     // Write text in first row
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_rfid+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;rfid.c,26 :: 		UART1_Init(9600);
	MOVLW      51
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;rfid.c,28 :: 		rfid[12] = '\0';
	CLRF       main_rfid_L0+12
;rfid.c,30 :: 		while(1)
L_main0:
;rfid.c,32 :: 		if(UART1_Data_Ready())
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main2
;rfid.c,34 :: 		for(i=0;i<12;)
	CLRF       main_i_L0+0
L_main3:
	MOVLW      12
	SUBWF      main_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main4
;rfid.c,36 :: 		if(UART1_Data_Ready())
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main6
;rfid.c,38 :: 		rfid[i] = UART1_Read();
	MOVF       main_i_L0+0, 0
	ADDLW      main_rfid_L0+0
	MOVWF      FLOC__main+0
	CALL       _UART1_Read+0
	MOVF       FLOC__main+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;rfid.c,39 :: 		i++;
	INCF       main_i_L0+0, 1
;rfid.c,40 :: 		}
L_main6:
;rfid.c,41 :: 		}
	GOTO       L_main3
L_main4:
;rfid.c,43 :: 		if((rfid[0] ^ rfid[2] ^ rfid[4] ^ rfid[6] ^ rfid[8] == rfid[10]) && (rfid[1] ^ rfid[3] ^ rfid[5] ^ rfid[7] ^ rfid[9] == rfid[11]))
	MOVF       main_rfid_L0+2, 0
	XORWF      main_rfid_L0+0, 0
	MOVWF      R0+0
	MOVF       main_rfid_L0+4, 0
	XORWF      R0+0, 1
	MOVF       main_rfid_L0+6, 0
	XORWF      R0+0, 0
	MOVWF      R1+0
	MOVF       main_rfid_L0+8, 0
	XORWF      main_rfid_L0+10, 0
	MOVLW      1
	BTFSS      STATUS+0, 2
	MOVLW      0
	MOVWF      R0+0
	MOVF       R1+0, 0
	XORWF      R0+0, 1
	BTFSC      STATUS+0, 2
	GOTO       L_main9
	MOVF       main_rfid_L0+3, 0
	XORWF      main_rfid_L0+1, 0
	MOVWF      R0+0
	MOVF       main_rfid_L0+5, 0
	XORWF      R0+0, 1
	MOVF       main_rfid_L0+7, 0
	XORWF      R0+0, 0
	MOVWF      R1+0
	MOVF       main_rfid_L0+9, 0
	XORWF      main_rfid_L0+11, 0
	MOVLW      1
	BTFSS      STATUS+0, 2
	MOVLW      0
	MOVWF      R0+0
	MOVF       R1+0, 0
	XORWF      R0+0, 1
	BTFSC      STATUS+0, 2
	GOTO       L_main9
L__main17:
;rfid.c,45 :: 		if(((rfid[10]=='3') && (rfid[11]=='4')) ^ ((rfid[10]=='5') && (rfid[11]=='0')) )
	MOVF       main_rfid_L0+10, 0
	XORLW      51
	BTFSS      STATUS+0, 2
	GOTO       L_main11
	MOVF       main_rfid_L0+11, 0
	XORLW      52
	BTFSS      STATUS+0, 2
	GOTO       L_main11
	MOVLW      1
	MOVWF      R1+0
	GOTO       L_main10
L_main11:
	CLRF       R1+0
L_main10:
	MOVF       main_rfid_L0+10, 0
	XORLW      53
	BTFSS      STATUS+0, 2
	GOTO       L_main13
	MOVF       main_rfid_L0+11, 0
	XORLW      48
	BTFSS      STATUS+0, 2
	GOTO       L_main13
	MOVLW      1
	MOVWF      R0+0
	GOTO       L_main12
L_main13:
	CLRF       R0+0
L_main12:
	MOVF       R1+0, 0
	XORWF      R0+0, 1
	BTFSC      STATUS+0, 2
	GOTO       L_main14
;rfid.c,47 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;rfid.c,48 :: 		Lcd_Out(1,1,"      YOU       ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_rfid+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;rfid.c,49 :: 		Lcd_Out(2,1," ARE PERMITTED ");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr4_rfid+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;rfid.c,50 :: 		delay_ms(3000);
	MOVLW      31
	MOVWF      R11+0
	MOVLW      113
	MOVWF      R12+0
	MOVLW      30
	MOVWF      R13+0
L_main15:
	DECFSZ     R13+0, 1
	GOTO       L_main15
	DECFSZ     R12+0, 1
	GOTO       L_main15
	DECFSZ     R11+0, 1
	GOTO       L_main15
	NOP
;rfid.c,52 :: 		}
	GOTO       L_main16
L_main14:
;rfid.c,54 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;rfid.c,55 :: 		Lcd_Out(1,1," NOT AUTHORISED ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr5_rfid+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;rfid.c,56 :: 		Lcd_Out(2,1," ACCESS DENIED  ");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr6_rfid+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;rfid.c,59 :: 		}
L_main16:
;rfid.c,61 :: 		}
L_main9:
;rfid.c,63 :: 		}
L_main2:
;rfid.c,65 :: 		}
	GOTO       L_main0
;rfid.c,66 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

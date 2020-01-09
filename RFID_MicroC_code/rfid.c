// LCD module connections
sbit LCD_RS at RB1_bit;
sbit LCD_EN at RB2_bit;
sbit LCD_D4 at RB3_bit;
sbit LCD_D5 at RB4_bit;
sbit LCD_D6 at RB5_bit;
sbit LCD_D7 at RB6_bit;

sbit LCD_RS_Direction at TRISB1_bit;
sbit LCD_EN_Direction at TRISB2_bit;
sbit LCD_D4_Direction at TRISB3_bit;
sbit LCD_D5_Direction at TRISB4_bit;
sbit LCD_D6_Direction at TRISB5_bit;
sbit LCD_D7_Direction at TRISB6_bit;
// End LCD module connections

void main()
{
  char i,rfid[13] = "123456781212";
  Lcd_Init();                         // Initialize LCD
  Lcd_Cmd(_LCD_CLEAR);                // Clear display
  Lcd_Cmd(_LCD_CURSOR_OFF);           // Cursor off
  Lcd_Out(1,1,"ICE RFID PROJECT");     // Write text in first row
  Lcd_Out(2,1,"SWAP YOUR CARD");     // Write text in first row

  UART1_Init(9600);
  
  rfid[12] = '\0';

  while(1)
  {
     if(UART1_Data_Ready())
     {
       for(i=0;i<12;)
       {
         if(UART1_Data_Ready())
         {
            rfid[i] = UART1_Read();
            i++;
         }
       }

       if((rfid[0] ^ rfid[2] ^ rfid[4] ^ rfid[6] ^ rfid[8] == rfid[10]) && (rfid[1] ^ rfid[3] ^ rfid[5] ^ rfid[7] ^ rfid[9] == rfid[11]))
       {
           if(((rfid[10]=='3') && (rfid[11]=='4')) ^ ((rfid[10]=='5') && (rfid[11]=='0')) )
           {
          Lcd_Cmd(_LCD_CLEAR);
          Lcd_Out(1,1,"      YOU       ");
          Lcd_Out(2,1," ARE PERMITTED ");
          delay_ms(3000);

          }
       else {
          Lcd_Cmd(_LCD_CLEAR);
          Lcd_Out(1,1," NOT AUTHORISED ");
          Lcd_Out(2,1," ACCESS DENIED  ");


  }

}

}

}
}
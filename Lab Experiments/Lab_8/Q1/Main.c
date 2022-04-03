#include <at89c5131.h>
#include "lcd.h"				//Header file with LCD interfacing functions
#include "MorseCode.h"	//Header file for Morse Code 

/*
Port P0.7 is used for the audio signal output
*/	
//Main function
void main()
{
	//Call initialization functions
	// Read input nibble here
	P1 = 0x0F;
	lcd_init();
	if(P1_0==1){
		lcd_cmd(0x88);
		lcd_write_char('A');
		morse_a();
		msdelay(1000);
	}
	else if(P1_1==1){
		lcd_cmd(0x88);
		lcd_write_char('B');
		morse_b();
		msdelay(1000);
	}
	else if(P1_2==1){
		lcd_cmd(0x88);
		lcd_write_char('C');
		morse_c();
		msdelay(1000);
	}
	else if(P1_3==1){
		lcd_cmd(0x88);
		lcd_write_char('D');
		morse_d();
		msdelay(1000);
	}
	else{
		lcd_cmd(0x88);
		lcd_write_char('E');
		morse_e();
		msdelay(1000);
	}
	lcd_init();
	while(1){}
	// Insert Priority Logic
	// Inside each condition, call the functions from MorseCode.h. Fill functions in MorseCode.h
	// Write to LCD using function lcd_write_string() in side the condition as well
}

#include <at89c5131.h>
#include "endsem.h"

char S_str[6]= {0,0,0,0,0,0};   //String for Balance Sita
char G_str[6] = {0,0,0,0,0,0};  //String for Balance Gita
char n500_s[3]= {0,0,0};    // STRING FOR 500RS NOTE
char n100_s[3]= {0,0,0};    // STRING FOR 100RS NOTE
char password[5] = {0,0,0,0,0} ;   //PASSWORD ARRAY

unsigned int sita = 10000;
unsigned int gita = 10000;

void msdelay(unsigned int time)
{
	int i,j;
	for(i=0;i<time;i++)
	{
		for(j=0;j<382;j++);
	}
}

void account_display(void)
{
	int i=0;
	unsigned char cha = 0;
	transmit_string("Hello, Please enter Account Number\r\n");
	cha = receive_char();
	switch(cha)
	{
		case '1':
			transmit_string("Account Holder: Sita\r\n");
			transmit_string("Account Balance: ");
			int_to_string(sita,S_str);
			for(i=0;i<6;i++)
			{
				transmit_char(S_str[i]);
			}
			transmit_string("\r\n");
			break;
		
		case '2':
			transmit_string("Account Holder: Gita\r\n");
			transmit_string("Account Balance: ");
			int_to_string(gita,G_str);
			for(i=0;i<6;i++)
			{
				transmit_char(G_str[i]);
			}
			transmit_string("\r\n");
			break;
		
		default:
			transmit_string("No such account, please enter valid details\r\n");
			break;
	}
	msdelay(100);
}

void withdraw_money(void)
{
	int i=0;
	unsigned char chw = 0;
	transmit_string("Withdraw state, enter account number\r\n");
	chw = receive_char();
	switch(chw)
	{
		case '1':
			transmit_string("Account Holder: Sita\r\n");
			transmit_string("Account Balance: ");
			int_to_string(sita,S_str);
			for(i=0;i<6;i++)
			{
				transmit_char(S_str[i]);
			}
			transmit_string("\r\n");
			transmit_string("Enter Amount, in hundreds\r\n");
			break;
		
		case '2':
			transmit_string("Account Holder: Gita\r\n");
			transmit_string("Account Balance: ");
			int_to_string(gita,G_str);
			for(i=0;i<6;i++)
			{
				transmit_char(G_str[i]);
			}
			transmit_string("\r\n");
			transmit_string("Enter Amount, in hundreds\r\n");
			break;
		
		default:
			transmit_string("No such account, please enter valid details\r\n");
			break;
	}
	msdelay(100);
}

void main(void)
{
		unsigned char ch = 0;
		uart_init();            // Please finish this function in endsem.h 
		while (1)
    {
			transmit_string("Press A for Account display and W for withdrawing cash\r\n");
			ch = receive_char();
			switch(ch)
			{
			case 'A':account_display();
							 break;
			
			case 'a':account_display();
							 break;
			
			case 'W':withdraw_money();
							 break;
			
			case 'w':withdraw_money();
							 break;
						
			default:transmit_string("Incorrect input entered. Try again!\r\n");
							 break;
			}
			msdelay(100);			
		}
}



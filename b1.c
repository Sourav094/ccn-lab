#include<stdio.h>
#include<stdlib.h>
#define maxsize 100
int main()
{
	char *p,*q;
	char temp;
	char in[maxsize];
	char stuff[maxsize];
	char destuff[maxsize];
	int count=0;

	printf(" Enter the input character string (0's & 1's only):\n ");
	scanf("%s",in);

	p=in;
	q=stuff;

	while(*p!='\0')
	{
		if(*p=='0')
		{
			*q=*p;
			q++;
			p++;
		}
		else
		{
			while(*p=='1' && count !=5)
			{
				count++;
				*q=*p;
				q++;
				p++;
			}
			if(count==5)
			{
				*q='0';
				q++;
			}
			count=0;
		}
	}
	*q='\0';
	printf(" The stuffed character string is ");
	printf("\n %s",stuff);

	p=stuff;
	q=destuff;
	while(*p!='\0')
	{
		if(*p=='0')
		{
			*q=*p;
			q++;
			p++;
		}
		else
		{
			while(*p=='1'&& count!=5)
			{
				count++;
				*q=*p;
				q++;
				p++;
			}
			if(count==5)
			{
				p++;
			}
			count=0;
		}
	}
	*q='\0';
	printf("\n The destuff character string is ");
	printf("\n %s\n",destuff);
	return 0;
}

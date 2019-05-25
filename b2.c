#include<stdio.h>
#include<stdlib.h>
#include<string.h>
void charc(void);
void main()
{
	int choice;
	while(1)
	{
		printf("\n1.character stuffing");
		printf("\n2.exit");
		printf("\nEnter choice");
		scanf("%d",&choice);
		//printf("%d",choice);
		if(choice>2)
		printf("\n\n invalid option");
		switch(choice)
		{
			case 1: charc();
					break;
			case 2:exit(0);
		}
	}
}
void charc(void)
{
	char c[50],d[50],t[50],*temp;
	int i,m=0,j;
	printf("enter the data to be char stuffed:\n");
	scanf("%s",c);
	printf("\ninput data :%s,length = %d\n",c,strlen(c));
	temp = c;

	while(*temp !='\0')
	m++,temp++;

	printf("m=%d",m);
	printf("\noriginal data:\n");

	for(i=0;i<m+1;i++)
	printf("%c",c[i]);
	d[0]='d';d[1]='l';d[2]='e';d[3]='s';d[4]='t';d[5]='x';
	for(i=0,j=6;i<m+1;i++,j++)
	{
		if((c[i]=='d'&&c[i+1]=='l'&&c[i+2]=='e'))
		{
			d[j]='d';j++;d[j]='l';j++;d[j]='e';j++;m=m+3;
		}
		d[j]=c[i];
	}
	m=m+6;m++;
	d[m]='d';m++;
	d[m]='l';m++;
	d[m]='e';m++;
	d[m]='s';m++;
	d[m]='t';m++;
	d[m]='x';m++;

	printf("\ntransmitted data : \n");
	for(i=0;i<m;i++)
	printf("%c",d[i]);
	for(i=6,j=0;i<m-6;i++,j++)
	{
		if(d[i]=='d'&&d[i+1]=='l'&&d[i+2]=='e'&&d[i+3]=='d'&&d[i+4]=='l'&&d[i+5]=='e')
		i=i+3;
		t[j]=d[i];
	}
	printf("\nreceived data:\n");
	for(i=0;i<j;i++)
	printf("%c",t[i]);
}



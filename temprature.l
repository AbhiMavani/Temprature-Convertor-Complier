/*** Declaration ***/
%{
	#include<stdio.h>
	#include<string.h>
	#include<stdlib.h>
	#include "y.tab.h"
	char* p;
	int isFirst = 0;
%}

DIGIT	[0-9]

/* Rules Section Starts */

%%

{DIGIT}+									{ 
												printf("Digit %s\n",yytext);
												yylval.d = atof(yytext);
												return VALUE;
											}

{DIGIT}*.{DIGIT}+							{ 
												printf("Digit %s\n",yytext);
												yylval.d = atof(yytext); 
												return VALUE;
											}

[=]											{ 	printf("eq %s\n",yytext);return EQ;	}

[?]											{ 	printf("que %s\n",yytext);return QUE;	}

CEL|FAH|KEL|RAN|REA		{   	
												printf("val %s\n",yytext);
												p=(char *)calloc(strlen(yytext)+1,sizeof(char));
												strcpy(p,yytext);
												if(isFirst == 0)
													yylval.c1 = p;
												else
													yylval.c2 = p;
												isFirst = 1;
												return TEMPARATURE;
											}

[ \t\b]										{ 	printf("space %ss\n",yytext);return SPACE;	}

[\n] 										{	printf("new line....",yytext);return NEWLINE;	}

.											{ 	
												printf("Unrecognized : %s\n",yytext);
												yyerror("Invalid Command");
											}

%%

int yywrap() {
	return 1;
}

/*
int main(int argc, char **argv) {
	if(argc > 1) {
		yyin = fopen(argv[1],"r");
	}
	else {
		yyin = stdin;
	}
	yylex();
	return 0;
}
*/
%{
	#include<stdio.h>
	#include<stdlib.h>
	#include<string.h>
	#include<math.h>
	int yylex(void);
	void yyerror(const char *s);
	extern char *yytext;
	
	void calcAns();
	float convertToCEL(float num);
	float convertFromCEL(float num);
	
	char* fromTemparature;
	char* toTemparature;
	int isAns = 0;
	float num;
	float ans = 0.0;
	float ans1 = 0.0;
%}

%union {
	char* c1;
	char* c2;
	float d;
}

%token VALUE TEMPARATURE EQ QUE NEWLINE SPACE

%%
	START: conversion  			{	
											calcAns();
											return 0;
										}
										
	conversion: VALUE SPACE 			{
											num = yylval.d;
										}
				expr
	
	expr: 		TEMPARATURE SPACE 			{
											fromTemparature = yylval.c1;
										}
				op

	op: 		EQ SPACE QUE SPACE second {}
	
	second:		TEMPARATURE				{
											toTemparature = yylval.c2;
										}
	
%%

void calcAns() {
	ans = convertToCEL(num);
	ans = convertFromCEL(ans);
	
	ans1 = convertToCEL(1.0);
	ans1 = convertFromCEL(ans1);
		
	printf("\n-->  %f  <--",ans);
	printf("\n 1 %s = %f %s\n",fromTemparature,ans1,toTemparature);
}

float convertToCEL(float num) {
	
	if(strcmp(fromTemparature, "FAH")==0) {
		num = (num - 32) * 0.555555556;
	}
	else if(strcmp(fromTemparature, "KEL")==0) {
		num = num - 273.15;
	}
	else if(strcmp(fromTemparature, "RAN")==0) {
		num = (num - 491.67) * 0.555555556;
	}
	else if(strcmp(fromTemparature, "REA")==0) {
		num = num * 1.25;
	}
	return num;
}

float convertFromCEL(float num) {
	
	if(strcmp(toTemparature, "FAH")==0) {
		num = (1.8 * num )  + 32;
	}
	else if(strcmp(toTemparature, "KEL")==0) {
		num = num + 273.15;
	}
	else if(strcmp(toTemparature, "RAN")==0) {
		num = (1.8 * num) + 491.67;
	}
	else if(strcmp(toTemparature, "REA")==0) {
		num = num * 0.8;
	}
	return num;
}

void languageInformation() {
	printf("\n\n***************\tTemprature CONVERTER\t***************\n");
	printf("\t     Developer : Abhishek Mavani , Dipali Mishra\n\n");
	printf("Input format:\n");
	printf("\t  Value Unit1 = ? Unit2\n\n");
	printf("Value --> Value to be convert from Unit1 to Unit2\n");
	printf("\n\nValue --> Integer or Float\n");
	printf("TEMPARATURE :\n");
	printf("\t\tCEL -> Celsius\n");
	printf("\t\tFAH -> Fahrenheit\n");
	printf("\t\tKEL -> Kelvin\n");
	printf("\t\tRAN -> Rankine\n");
	printf("\t\tREA -> Reaumur\n");	
}

int main() {
	languageInformation();
	yyparse();
    return 0;
}

void yyerror(const char *s){
    fprintf(stderr, "%s\n", s);
    return;
}
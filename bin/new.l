%{
#include"y.tab.h"
extern yylval;
int c=2;
%}

alpha [a-zA-Z]
digit [0-9]

%%


^{digit}+      {c=atoi(yytext);
								return NUM;	}
[ \t]		;
[ \n]   { yylineno = yylineno + 1;
          if(c+1==yylineno){
         return 0; }}
"int"	{return INT;}
"float" {return FLOAT;}
"char" {return CHAR;}
"void" {return VOID;}
"double" {return DOUBLE;}
"for" 	{return FOR;}
"while"	{return WHILE;}
"if"	{return IF;}
"else"	{return ELSE;}
"printf"  {return PRINTF;}
"scanf" {return SCANF;}
"struct" {return STRUCT;}
"long" {return LONG;}
"return" {return RETURN;}
"#include<stdio.h>" {return INCLUDE;}
"#include<stdlib.h>" {return INCLUDE;}
"#include<string.h>" {return INCLUDE;}
"#include<math.h>" {return INCLUDE;}
"#include<conio.h>" {return INCLUDE;}
{digit}+       {return NUM;}
{alpha}({alpha}|{digit})* {return ID;}
"<="    {return LE;}
">="    {return GE;}
"=="    {return EQ;}
"!="    {return NE;}
">"	{return GT;}
"<"	{return LT;}
"."     {return DOT;}
\/\/.* ;
\/\*(.*\n)*.*\*\/ ;


.       {return yytext[0];}
%%
int yywrap()
{
    return 0;
}

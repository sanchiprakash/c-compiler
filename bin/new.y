%{
#include<stdio.h>
extern FILE *fp;

%}
%token NUMBER ID IF OPER ELSE OR SP
%left '+' '-'
%left '*' '/'
%%
expr: IF '(' S W S ')' A
S: ID|NUMBER
W: OPER|OR
A: '{' ID '('')'';' '}'
;
%%

#include"lex.yy.c"
#include<ctype.h>
int main(int argc, char *argv[])
{
yyin = fopen(argv[1], "r");
if(yyparse()==0)
    printf("\nExpression is valid\n");
else
    printf("error");
}
int yyerror()
{
return 1;
}

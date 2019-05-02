%{
#include"y.tab.h"
extern yylval;
%}
%%
"if" {return IF;}
"else" {return ELSE;}
"OR" {return OR;}
[< > >= <=] {return OPER;}
[0-9]+ {yylval=atoi(yytext); return NUMBER;}
[a-zA-Z]+ {return ID;}
[\t]+ {return SP;}
\n {return 0;}
. {return yytext[0];}
%%
int yywrap()
{
    return 0;
}

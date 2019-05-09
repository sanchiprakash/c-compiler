%{
#include<stdio.h>
extern FILE *fp;

%}
%token INT FLOAT CHAR DOUBLE VOID FOR WHILE IF ELSE PRINTF NUM ID INCLUDE DOT OPER NUMBER SP STRUCT LONG RETURN SCANF

%right '='
%left AND OR
%left '<' '>' LE GE EQ NE LT GT

%%
start: NUM A B
;
A:  	INCLUDE A
	|INCLUDE
	;

B: Function
	| Declaration
;


/* Declaration block */
Declaration: Type Assignment ';'
	| Assignment ';'
	| FunctionCall ';'
	| ArrayUsage ';'
	| Type ArrayUsage ';'
	| StructStmt ';'
	| error
	| CHAR chararray
;


/* Assignment block */
Assignment: Equal
	| Operators
;

PRINTSCAN : PRINTSCAN P
	|
	;
P : 	ID
 	|NUM
	|'='
	|':'
	|LE
	|GE
	|EQ
	|NE
	|LT
	|GT
	;
Equal:  ID '=' Assign
	| ID '=' Operators
	| ID '=' FunctionCall
	| ID '=' ArrayUsage
	| ArrayUsage '=' Assign
;
Operators: ID ',' Assign
	| NUM ',' Assign
	| Assign '+' Assign
	| Assign '-' Assign
	| Assign '*' Assign
	| Assign '/' Assign
	| '\'' Assignment '\''
	| '(' Assignment ')'
	| '-' '(' Assignment ')'
	| '-' NUM
	| '-' ID
	|   NUM
	|   ID

;
chararray: ID '[' ID ']' '=' '"' ID '"' ';'
	| ID '[' ID ']' '=' '"' NUM '"' ';'
	| ID '[' NUM ']' '=' '"' ID '"' ';'
	| ID '[' NUM ']' '=' '"' NUM '"' ';'
	| ID '=' '"' NUM '"' ';'
	| ID '=' '"' ID '"' ';'
;


Assign: ID
	|NUM;

/* Function Call Block */
FunctionCall : ID'('')'
	| ID'('FUNCTONCALLARG')'
	;
FUNCTONCALLARG: FUNCTONCALLARG ',' ID
		| FUNCTONCALLARG ',' NUM
		| ID
		| NUM
		;

/* Array Usage */
ArrayUsage : ID'['Assign']'
	;

/* Function block */
Function: Type ID '(' ArgListOpt ')' CompoundStmt
	| VOID ID '(' ArgListOpt ')' CompoundStmt
	;
ArgListOpt: ArgList
	|
	;
ArgList:  ArgList ',' Arg
	| Arg
	;
Arg:	Type ID
	| CHAR ID
	| CHAR '*'ID
	| Type '*' ID
	;
CompoundStmt:	'{' StmtList '}'
	;
StmtList:	StmtList Stmt
	|
	;

Stmt:	WhileStmt
	| Declaration
	| ForStmt
	| IfStmt
	| PrintFunc
	| ';'
	| RETURN NUM
	| RETURN ID
	| ScanFunc
	;

/* Type Identifier block */
Type:	INT
	| FLOAT
	| DOUBLE
	| LONG
;

/* Loop Blocks */
WhileStmt: WHILE '(' Expr ')' Stmt
	| WHILE '(' Expr ')' CompoundStmt
	;

/* For Block */
ForStmt: FOR '(' Expr ';' Expr ';' Expr ')' Stmt
       | FOR '(' Expr ';' Expr ';' Expr ')' CompoundStmt
       | FOR '(' Expr ')' Stmt
       | FOR '(' Expr ')' CompoundStmt
	;

/* IfStmt Block */
IfStmt : IF '(' Expr ')'
	 	CompoundStmt
	|IF '(' Expr ')'
	 	Stmt
	;

/* Struct Statement */
StructStmt : STRUCT ID '{' Type Assignment '}'
	;

/* Print Function */
PrintFunc : PRINTF '(' PRINTEXP ')' ';'
	;
ScanFunc : SCANF '(' SCANEXP ')' ';'
/*Expression Block*/
Expr:
	| Expr LE Expr
	| Expr GE Expr
	| Expr NE Expr
	| Expr EQ Expr
	| Expr GT Expr
	| Expr LT Expr
	| Assignment
	| ArrayUsage
;
SCANEXP:  '"' X '"' Y
	    ;
X: 	X '%' ID
	|
	;
Y:	Y ',' '&' ID
	|
	;
PRINTEXP : '"'PRINTSCAN'"'
	    | '"' X '"' O
	    | '"'PRINTSCAN  X '"' O
	    ;
O:	O ',' ID
	|
	;

%%

#include"lex.yy.c"
#include<ctype.h>
int a=0;
//int count=0;
int main(int argc, char *argv[])
{
yyin = fopen(argv[1], "r");
//count =yyin[0];
if(yyparse()==0 && a==0)
    printf("\nExpression is valid\n");
else
    printf("\nExpression is not valid\n");

//fclose(yyin);
return 0;


}
int yyerror(char *s)
{
a=1;
printf("%d : %s %s\n", yylineno, s, yytext );
return 1;
}

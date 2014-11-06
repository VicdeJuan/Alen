%{
	#include <stdio.h>
	#include <stdlib.h>

void yyerror(char* s){

	fprintf(stdout,"error\n",s);
	return;
}
%}

%union{
	float float_val;
	int int_val;
}

%token <float_val> TOK_FLOAT
%token <int_val> TOK_ENTERO

%type <float_val> exp
%type <float_val> cte

%start exp_prn

%%
 
exp_prn : exp  { printf("Resultado: %f",$1); }
	;

exp : exp '+' exp { $$ = $1 + $3; }
 | exp '-' exp { $$ = $1 - $3; }
 | exp '*' exp { $$ = $1 * $3; }
 | exp '/' exp { $$ = $1 / $3; }
 | '-' exp { $$ = -$2; }
 | '(' exp ')'{ $$ = $2; }
 | cte { $$ = $1; }
 ;

cte: TOK_ENTERO { $$ = $1; } 
	| TOK_FLOAT { $$ = $1; } 
	;
%%

int main(){
	yyparse();
}
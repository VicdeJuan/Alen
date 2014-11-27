%{
	#include <stdio.h>
	#include <stdlib.h>
	#include "y.tab.h"

void yyerror(char* s){

	fprintf(stdout,"%s\n",s);
	return;
}

int tipo,var,error;

#define C1 1
#define C2 2
#define C3 3
%}

%union{
	int valor;
}


%token <valor> TOK_AND
%token <valor> TOK_OR
%token <valor> TOK_NOT
%token <valor> TOK_NAND
%token <valor> TOK_NOR
%token <valor> TOK_VAR
%token <valor> TOK_FALSE
%token <valor> TOK_TRUE

%type <valor> exp
%type <valor> cte
%type <valor> variable
%type <valor> exp_prn

%left TOK_OR TOK_NOR TOK_NAND
%left TOK_AND
%left TOK_NOT

%start exp_prn

%%
 
exp_prn : exp  { if(!error) printf("Conjunto: C%d\n",$1.tipo); else printf("Está mal formada\n");
		 if (!var) if ($1) printf("True\n"); else printf("False\n"); else printf("Expresión no evaluable\n"); }
	;

exp : exp TOK_AND exp { if (tipo==0) tipo = C1;  if (tipo == C1) $$ = $1 && $3; else error=1;}
 | exp TOK_OR exp { if (tipo==0) tipo = C1;  if (tipo == C1) $$ = $1 || $3; else error=1;}
 | TOK_NOT exp { if (tipo==0) tipo = C1;  if (tipo == C1) $$ = !$2; else error=1;}
 | exp TOK_NOR exp { if (tipo==0) tipo = C2;  if (tipo == C2) $$ = !($1 || $3); else error=1;}
 | exp TOK_NAND exp { if (tipo==0) tipo = C3;  if (tipo == C3) $$ = !($1 && $3); else error=1;}
 | cte { $$ = $1; }
 | '(' exp ')' { $$ = $2; }
 | variable { $$ = 0; }
 ;

variable : TOK_VAR { var = 1;}

cte: TOK_FALSE { $$ = 0;}
 | TOK_TRUE {$$ = 1;}
;

%%

int main(){
	tipo = 0;
	var = 0;
	error = 0;
	yyparse();
}
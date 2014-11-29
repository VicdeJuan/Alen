%{
	#include <stdio.h>
	#include <stdlib.h>
	#include "valor.h"

void yyerror(char* s){

	fprintf(stdout,"%s\n",s);
	return;
}


#define C1 1
#define C2 2
#define C3 4
%}

%union{
	val_struct valor;
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
 
exp_prn : exp  {
	int error = $1.tipo & 7;
	int set = 0;
	switch (error){
		case 1:
			set=1;
			break;
		case 2:
			set=2;
			break;
		case 4:
			set=3;
			break;
		default:
			set = 0;
			break;

	}
	if(set) 
		printf("Conjunto: C%d\n",set);
	else
		printf("Está mal formada\n");
	if (!$$.var)
		if ($1.value) printf("True\n"); 
		else printf("False\n"); 
	else 
		printf("Expresión no evaluable\n"); 
	};

exp : exp TOK_AND exp {
	$$.tipo = $1.tipo | $3.tipo | 1;
	$$.var = $1.var || $3.var;
 	$$.value = $1.value && $3.value; 
	}
 | exp TOK_OR exp {
	$$.tipo = $1.tipo | $3.tipo | 1;
	$$.var = $1.var || $3.var;
 	$$.value = $1.value || $3.value;
	}
 | TOK_NOT exp {
	$$.tipo = $2.tipo | 1;
	$$.var = $2.var;
 	$$.value = !$2.value;
 	}
 | exp TOK_NOR exp {
	$$.tipo = $1.tipo | $3.tipo | 2;
	$$.var = $1.var || $3.var;
 	$$.value = !($1.value || $3.value);
 	}
 | exp TOK_NAND exp {
	$$.tipo = $1.tipo | $3.tipo | 4;
	$$.var = $1.var || $3.var;
 	$$.value = !($1.value && $3.value);
 	}
 | cte { $$.value = $1.value; $$.var = $1.var; $$.tipo=0;}
 | '(' exp ')' { $$.value = $2.value; $$.var = $2.var; $$.tipo = $2.tipo;}
 | variable { $$.value = 0; $$.var = $1.var; $$.tipo=0; }
 ;

variable : TOK_VAR { $$.var = 1;}
;

cte: TOK_FALSE { $$.value = 0; $$.var = 0;}
 | TOK_TRUE {$$.value = 1; $$.var = 0;}
;

%%

int main(){
	yyparse();
}
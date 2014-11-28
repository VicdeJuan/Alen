%{
#include <stdio.h>
#include "y.tab.h"

%}
%option noyywrap

extern int tipo;


%%

"AND" { return TOK_AND; }

"OR" { return TOK_OR; }

"NOT" { return TOK_NOT; }

"NAND" { return TOK_NAND; }

"NOR" { return TOK_NOR; }

")" { return ')'; }

"(" { return '('; }

"T" { return TOK_TRUE; }
"F" { return TOK_FALSE; }
[a-z]+ {
	return TOK_VAR;
}

. {
	
} 


%%


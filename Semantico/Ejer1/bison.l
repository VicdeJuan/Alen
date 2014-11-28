%{
#include <stdio.h>
#include "y.tab.h"
%}
%option noyywrap



%%

"+" { return '+'; }


"-" { return '-'; }

"*" { return '*'; }

"/" { return '/'; }

"(" { return '('; }

")" { return ')'; }


[0-9]+ {
	yylval.int_val = atoi(yytext);
	return TOK_ENTERO;
}

[0-9]+"."[0-9]+ {
	yylval.float_val = atof(yytext);
	return TOK_FLOAT;
}

. {
	
} 


%%


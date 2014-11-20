%{
#include <stdio.h>
#include "symbol.h"
#include "y.tab.h"

%}
%option noyywrap


%%
[ \t] { 
}
"sensor" { printf("%s",yytext); return sensor;}
"motor" { printf("%s",yytext); return motor;}
"end" { printf("%s",yytext); return end;}
"halt" { printf("%s",yytext); return halt;}
[a-zA-Z]+ { strcpy(yylval.sim.key,yytext); printf("%s",yytext); return name;}
"(" { printf("%s",yytext); return '(';}
")" { printf("%s",yytext); return ')';}
"[" { printf("%s",yytext); return '[';}
"]" { printf("%s",yytext); return ']';}
"," { printf("%s",yytext); return ',';}
"=" { printf("%s",yytext); return '=';}
">" { printf("%s",yytext); return '>';}
"<" { printf("%s",yytext); return '<';}
[0-9]+|"-"[0-9]+ { yylval.sim.value = atoi(yytext); printf("%s",yytext); return num; }

. { return -1;}

%%
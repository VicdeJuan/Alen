%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#include "symbol_table.h"
	#include "symbol.h"

void yyerror(char* s){

	fprintf(stdout,"%s\n\n",(char *)yyerror);
	exit(-1);
}

symbol_table * tabla;

%}

%union{
	symbol sim;
}


%type <sim> program
%type <sim> sensorsDecl
%type <sim> motorsDecl
%type <sim> sensorDecl
%type <sim> motorDecl
%type <sim> port
%type <sim> rank
%type <sim> actionStmts
%type <sim> action
%type <sim> sensorAction
%type <sim> value
%type <sim> motorActions
%type <sim> motorAction
%type <sim> power
%type <sim> tiempo


%token <sim> num
%token <sim> name
%token <sim> sensor
%token <sim> motor
%token <sim> end
%token <sim> halt


%start program
%%


program : sensorsDecl motorsDecl actionStmts 
;

sensorsDecl : sensorDecl 
 | sensorDecl sensorsDecl 
;

motorsDecl : motorDecl 
 | motorDecl motorsDecl 
;

sensorDecl : sensor name port rank /* Insertar en tabla símbolos */{
	symbol * sen = search_symbol(tabla,$2.key,1);
	if (sen)
		yyerror("Sensor ya definido");
	else{
		/* Puerto vacío, que de momento nada. */
		symbol * sim = malloc(sizeof(symbol)*1);
		initialize_simbolo(sim);
		sim->min = $4.min;
		sim->max = $4.max;
		strcpy(sim->key,$2.key);
		sim->port = $3.value;
	}
}
;

motorDecl : motor name port /* Insertar en tabla símbolos y comprobar puerto vacío */{
	symbol * sen = search_symbol(tabla,$2.key,1);
	if (sen)
		yyerror("Motor ya definido");
	else{
		/* Puerto vacío, que de momento nada. */
		symbol * sim = malloc(sizeof(symbol)*1);
		initialize_simbolo(sim);
		sim->min = 0;
		sim->max = 0;
		strcpy(sim->key,$2.key);
		sim->port = $3.value;
	}

}
;

port : num {
	$$.value = $1.value;
}
;

rank : '['num',' num']' /* Max y min */{
	$$.min = $2.value;
	$$.max = $4.value;
}
;

actionStmts : action 
 | action actionStmts 
;

action : sensorAction motorActions end
;

sensorAction : name cmpSymbol value { /* Buscar en tabla símbolo name y value dentro de range*/
	symbol * sen = search_symbol(tabla,$1.key,1);
	if (!sen)
		yyerror("Sensor no definido previamente");
	if (!(($3.value <= sen->max) && ($3.value >= sen->min)))
		yyerror("Valor fuera de rango");
}
;

value : num {$$.value = $1.value;}
;

motorActions : motorAction /* Buscar en tabla símbolo motorAction*/ {
	if (!search_symbol(tabla,$1.key,1)){
		yyerror("motor no definido anteriormente");
	}
	}
 | motorAction motorActions /* Buscar en tabla símbolo motorAction*/ {
	if (!search_symbol(tabla,$1.key,1))
	{
		yyerror("motor no definido anteriormente");
	}
}
;

motorAction : name '('power ',' tiempo')' { 
	if(!search_symbol(tabla,$1.key,1))
		yyerror("Sensor no definido");
	}
 | halt {
 	if(!search_symbol(tabla,$1.key,1))
		yyerror("Sensor no definido");
	return 0;
	}
;

power : num { if (!(($1.value <= 100) && ($1.value >= 100))) yyerror("Tiempo fuera de rango"); $$.value = $1.value; }
;

tiempo : num { if ($1.value <= 0) yyerror("Tiempos positivos por favor"); $$.value = $1.value; }/* tiempo ≥ 0*/
;

cmpSymbol : '='
 | '>' 
 | '<' 
;


%%

int main(){
	tabla =  create_symbol_table();
	if (!tabla){
		return -1;
	}

	yyparse();
}
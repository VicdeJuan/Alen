%{
	#include <stdio.h>
	#include <stdlib.h>
%}

%token ARTICULO
%token NOMBRE
%token VERBO
%token PREPOSICION

%start texto

%%
 

texto : oracion '.' {fprintf(stdout,"<texto> -> <oracion> .") ;}
 | oracion '.' texto {fprintf(stdout,"<texto> -> <oracion> . <texto>"); } ;

oracion : sujeto predicado  {fprintf(stdout,"<oracion> -> <sujeto> <predicado> ") ;}
 | predicado sujeto {fprintf(stdout, "<oracion> -> <predicado> <sujeto>"); ;} ;

sujeto : grupo_nombre   {fprintf(stdout,"<sujeto> -> <grupo_nombre>") ;}

grupo_nombre : articulo nombre  {fprintf(stdout,"<grupo_nombre> -> <articulo> <nombre> ") ;}
 | nombre  {fprintf(stdout,"<gurpo_nombre> -> <nombre>") ;} ;

predicado : verbo complemento  {fprintf(stdout,"<predicado> -> <verbo> <complemento> ") ;}

complemento : preposicion grupo_nombre  {fprintf(stdout,"<complemento> -> ") ;}
 | grupo_nombre  {fprintf(stdout,"complemento -> <grupo_nombre") ;} ;




articulo : ARTICULO

nombre : NOMBRE

verbo : VERBO

preposicion : PREPOSICION

%%
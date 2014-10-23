 /** Codigo c que se copia integro */
%{
#include <stdio.h>

%}

 /** Opción de compilación:  Para decirle a flex que solo vamos a trabajar con 1 fichero */
%option noyywrap

%%

INICIO { 
	printf("reconocido INICIO\n");
	}

FIN { 
	printf("reconocido FIN\n");
	}

VECTOR { 
	printf("reconocido VECTOR\n");
	}

ENTERO { 
	printf("reconocido ENTERO\n");
	}

LOGICO { 
	printf("reconocido LOGICO\n");
	}



%%


int main(int argc,char ** argv){
	if(argc >= 1)
		yyin = fopen(argv[1],"r");
	else return 0;

	if (yyin != NULL)
		return yylex();
	else return 0;
}

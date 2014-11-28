 /** Codigo c que se copia integro */
%{
#include <stdio.h>

%}

 /** Opción de compilación:  Para decirle a flex que solo vamos a trabajar con 1 fichero */
%option noyywrap

%%

INICIO { 
	return 8;
}

FIN { 
	return 9;
	}

VECTOR { 
	return 10;
}

ENTERO { 
	return 11;
}

LOGICO { 
	return 12;
}

. {
	return 13;
}




%%


int main(int argc,char ** argv){
	if(argc >= 2){
		yyin = fopen(argv[1],"r");
	}
	else return 0;

	if (yyin != NULL)
	{
		int aux = yylex();
		while (aux != 0)
		{
			switch (aux){
				case 8:
					printf("reconocido INICIO\n");
					break;
				case 9:
					printf("reconocido FIN\n");
					break;
				case 10:
					printf("reconocido VECTOR\n");
					break;
				case 11:
					printf("reconocido ENTERO\n");
					break;
				case 12:
					printf("reconocido LOGICO\n");
					break;
				case 13:
					break;
				default:
					printf("JAMAS!");
					break;
			}
			aux = yylex();
		}
		fclose(yyin);
		return 0;
	}
	else return 0;
}

 /** Codigo c que se copia integro */
%{
#include <stdio.h>
#include <string.h>

#define TOK_NOMBRE_AUTOR 1;
#define TOK_PARAM_TIPO 2;
#define TOK_PARAM_STRING 3;
#define TOK_RETURN 4;
#define TOK_SEE 5;
#define TOK_VERSION 6;
#define TOK_ERROR 16;


char autor[3][100];
char  param[30][100];
char errors[30][100];
char description[100];
char toptr_paquete[10000];
char paquete[100];
char clase[100];
char miembro[100];
float version;
char fecha[12];
char aux[100];
char str_ret[100];

int ret_bool = 0;
int autors = 0;
int version_bool = 0;
int params = 0;
int comentario =0;
int toptr_index = 0;
int docs = 0;
int i;

%}

 /** Opción de compilación:  Para decirle a flex que solo vamos a trabajar con 1 fichero */
%option noyywrap

%%

"\/\*\*" {
	comentario = 1;
}

"\*\/" {
	comentario = 0;
	docs ++;
	printf("Sesion documental %d\n",docs);
	printf("Authors:\n\t");
	for (i = 0; i<autors-1;i++)
		printf("%s,",autor[i]);
	printf("%s\n",autor[i]);

	printf("Parameters: \n\t");
	for (i = 0; i<params-1;i++)
		printf("%s\n\t",param[i]);
	printf("%s\n",param[i]);

	

	printf("Returns: \n\t%s\n",str_ret);

	printf("See also: \n\t%s\n",toptr_paquete);


	printf("Version: \n\t");
	printf("%.2f\t %s\n\n\n\n",version,fecha);

	autors = 0;
	params = 0;
	comentario =0;
	toptr_index = 0;
	version_bool = 0;
	ret_bool = 0;

}

"@author "[A-Z][a-z]+ {

	if(comentario == 1 && autors <= 2){
		strcpy(autor[autors],yytext+8*sizeof(char));
		autors++;
		i=1;
	} 	
	
	

}

"@param "<[a-z]+>[a-z ]* {
	if(comentario == 1 && params < 100){
		strcpy(param[params],yytext+7);
		params ++;
	}
} 


"@param "[a-z]+[a-z ]* {
	if(comentario == 1 && params < 100){
		strcpy(param[params],yytext+7);
		params ++;
	}
}

"@return "[a-zA-Z]+"." {
	if(comentario == 1){
		strcpy(str_ret,yytext+7);
		ret_bool = 1;
	}
}

"@see "[a-z]+"."[a-z]+"#"[a-z]+ {
	if(comentario == 1){
		strcpy(toptr_paquete+toptr_index,yytext+4*sizeof(char));
		toptr_index += strlen(yytext+4*sizeof(char));
	}
}

"@version "[0-9]"."[0-9]{2}" "[0-9]{2}"/"[0-9]{2}"/"[0-9]{4} {
	if(comentario == 1){
		strncpy(aux,yytext+9,4);
		version = atof(aux);
		strcpy(fecha,yytext+14);
		version_bool = 1;
	}
}

[\n] {

}

. {

}

%%


int main(){
	yyin = fopen("prueba","r");
	int aux = yylex();
	return 0;
}

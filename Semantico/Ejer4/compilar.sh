bison -ydv bison.y&& flex bison.l&&  gcc lex.yy.c y.tab.c && ./a.out < prueba

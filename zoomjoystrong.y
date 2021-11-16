%{
	#include <stdio.h>
  #include <stdlib.h>
  #include <math.h>
  #include "zoomjoystrong.tab.h"
  #include "zoomjoystrong.h"
  int yyerror(const char*);
  int yylex();
%}

%union {
	int iVal;
  float fVal;
	char* sVal;
}

%start program
%token END
%token END_STATEMENT
%token POINT
%token LINE
%token CIRCLE
%token RECTANGLE
%token SET_COLOR

%token INT
%type<iVal> INT
%token FLOAT
%type<fVal> FLOAT

%%

program       : statement_list
              ;

statement_list: statement
              | statement statement_list
              ;

statement     : POINT INT INT END_STATEMENT {point($2,$3);}
              | LINE INT INT INT INT END_STATEMENT {line($2,$3,$4,$5);}
              | CIRCLE INT INT INT END_STATEMENT {circle($2,$3,$4);}
              | RECTANGLE INT INT INT INT END_STATEMENT {rectangle($2,$3,$4,$5);}
              | SET_COLOR INT INT INT END_STATEMENT {set_color($2,$3,$4);}
              | END END_STATEMENT {finish();}
              ;



%%

int yyerror(const char* msg) {
	return fprintf(stderr, "YACC: %s\n", msg);
}

int main(int argc, char** argv){
  setup();
  yyparse();
  return 0;
}


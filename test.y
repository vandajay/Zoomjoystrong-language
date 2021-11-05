%{
	include <stdio.h>
	#include <math.h>
	void yyerror(const char* msg);
	void yyerror(const char* msg);
	entern int yylineo;
	double total = 0;

%}

%union {
	double fVal;
}

%type<fVal> NUMBER
%token MEMORY
%token NUMBER
%token ADD_OP
%token SUB_OP
%token MUL_OP
%token DIV_OP
%token POW_OP
%token CLR_OP
%token EQL_OP
%start program

%%

program		:			statement_list
			;

statement_list:			statement
			|			statement statement_list
			;

statement	:			ADD_OP NUMBER			{total += $2;}
			|			SUB_OP NUMBER			{total -= $2;}
			|			MUL_OP NUMBER			{total *= $2;}
			|			DIV_OP NUMBER			{total /= $2;}
			|			POW_OP NUMBER			{total += pow(total, $2);}
			|			EQL_OP				{printf(“%f\n”, total);}
			|			CLR_OP				{total = 0;}
			;

%%
void yyerror(const char* msg) {
	fprintf(stder, “Error on line %d.%s\n”, yylineno, msg);
}
int main(int argc, char** argv) {

}
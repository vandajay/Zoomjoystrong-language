/***********************************************************************
    Zoomjoystrong Programming Language: Parser

    This is a parser written in bison that defines the grammar for the
    Zoomjoystrong language of the lexemes passed from the lexer.
    
    @author Jay Van Dam
    @version November 2021
 **********************************************************************/

%{ // C declarations


    #include <stdio.h>
    #include <stdlib.h>
    #include <math.h>
    #include "zoomjoystrong.tab.h"
    #include "zoomjoystrong.h"
    int yyerror(const char*);
    int yylex();
    extern int yylineno;
%}


%union { // %union define lexeme types passed from lexer to parser
    int iVal;
    float fVal;
    char* sVal;
}

// Bison Declarations

%start program
%token END
%token END_STATEMENT
%token POINT
%token LINE
%token CIRCLE
%token RECTANGLE
%token SET_COLOR

%type<iVal> INT
%token INT
%type<fVal> FLOAT
%token FLOAT

%%

// Grammer Rules

program         :   statement_list
                ;

statement_list  :   statement
                |   statement statement_list
                ;

statement       :   POINT INT INT END_STATEMENT {
                        if( $2 >= 0 && $2 <= WIDTH &&
                            $3 >= 0 && $3 <= HEIGHT) {
                            point($2,$3);
                        } else {
                            yyerror("INVALID POINT!");
                        }
                    }
                |   LINE INT INT INT INT END_STATEMENT {
                        if( $2 >= 0 && $2 <= WIDTH &&
                            $3 >= 0 && $3 <= HEIGHT &&
                            $4 >= 0 && $4 <= WIDTH &&
                            $5 >= 0 && $5 <= HEIGHT) {
                            line($2,$3,$4,$5);
                        } else {
                            yyerror("INVALID LINE!");
                        }
                    }
                |   CIRCLE INT INT INT END_STATEMENT {
                        if( $2 >= 0 && $2 <= WIDTH &&
                            $3 >= 0 && $3 <= HEIGHT &&
                            $4 >= 0 && $4 <= WIDTH &&
                            $4 >= 0 && $4 <= HEIGHT) {
                            circle($2,$3,$4);
                        } else {
                            yyerror("INVALID CIRCLE!");
                        }
                    }
                |   RECTANGLE INT INT INT INT END_STATEMENT {
                        if( $2 >= 0 && $2 <= WIDTH &&
                            $3 >= 0 && $3 <= HEIGHT &&
                            $4 >= 0 && $4 <= WIDTH &&
                            $5 >= 0 && $5 <= HEIGHT) {
                            rectangle($2,$3,$4,$5);
                        } else {
                            yyerror("INVALID RECTANGLE!");
                        }
                    }
                |   SET_COLOR INT INT INT END_STATEMENT {
                        if( $2 >= 0 && $2 <= 255 &&
                            $3 >= 0 && $3 <= 255 &&
                            $4 >= 0 && $4 <= 255) {
                            set_color($2,$3,$4);
                        } else {
                            yyerror("INVALID COLOR!");
                        }
                    }
                |   END END_STATEMENT {finish();}
                ;

%%

/***********************************************************************
    Error reporting function for parsing or syntax errors within the 
    language.
    @param const char msg message of the error to be reported from
    grammar definitions.
    @return int the total number of characters to be written to the 
    stream.
 **********************************************************************/
int yyerror(const char* msg) {
    return fprintf(stderr, "Error: %s Line %d\n", msg, yylineno);
}

int main(int argc, char** argv){
    setup();
    yyparse();
    return 0;
}


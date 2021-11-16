%{
/***********************************************************************
    Zoomjoystrong Programming Language: Lexer

    This is a lexer written in flex that defines the tokens for the
    Zoomjoystrong language to pass to the parser for interpretation.
    
    @author Jay Van Dam
    @version November 2021
**********************************************************************/
    #include "zoomjoystrong.tab.h"
    #include "zoomjoystrong.h"
    #include <stdlib.h>
    #include <stdio.h>
    int yyerror(char*);
%}

%option yylineno

%%

point           { return POINT;                             }
line            { return LINE;                              }
circle          { return CIRCLE;                            }
rectangle       { return RECTANGLE;                         }
set_color       { return SET_COLOR;                         }
[0-9]+          { yylval.iVal = atoi(yytext); return INT;   }
[0-9]+\.[0-9]+  { yylval.fVal = atof(yytext); return FLOAT; }
end             { return END;                               }
;               { return END_STATEMENT;                     }
[ \t\n\r]       ;
.               { yyerror("INVALID INPUT.");                }

%%



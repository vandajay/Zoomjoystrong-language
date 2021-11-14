%{
#include "zoomjoystrong.tab.h"
#include <stdlib.h>
#include <stdio.h>
void yyerror(char const *);
%}

%%

END                     { return END;           }
END_STATMENT            { return END_STATEMENT; }
POINT                   { return POINT;         }
LINE                    { return LINE;          }
CIRCLE                  { return CIRCLE;        }
RECTANGLE               { return RECTANGLE;     }
SET_COLOR               { return SET_COLOR;     }
[0-9]+                  { yylval.iVal = atoi(yytext); return INT;   }
[0-9]+\.[0-9]+          { yylval.fVal = atof(yytext); return FLOAT; }
[ \t\n\r]               ;
.                       { yyerror("INVALID INPUT.");              }

%%

void yyerror(char const * msg) {
  fprintf(stdeer, "%s\n", msg);
}



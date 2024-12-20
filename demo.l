%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"
%}

separator [\t\n\r ]
letter [a-z]
digit [0-9]

number 0|[1-9]{digit}*|-[1-9]{digit}*
id {letter}({letter}|{digit}|'-')*
boolval #t|#f

%%

{separator}     {/* Ignore separators */}
{number}        { yylval.value = atoi(yytext); return NUMBER; }
{id}            { return ID; }
{boolval}       { return BOOL_VAL; }
.               { /* Ignore unrecognized characters */ }

%%

int yywrap() {
    return 1;
}

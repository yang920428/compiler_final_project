%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
%}

%union {
    int value;
    char *str;
}

%token<value> BOOL_VAL NUMBER
%token<str> ID
%type<value> EXP NUM_OP LOGICAL_OP PLUS MINUS MULTIPLY DIVIDE MODULUS GREATER SMALLER EQUAL


%left '+' '-'
%left '*' '/'
%left '<' '>' '='

%%
PROGRAM
    : STMT_LIST
    ;

STMT_LIST
    : STMT
    | STMT_LIST STMT
    ;

STMT
    : EXP
    | DEF_STMT
    | PRINT_STMT
    ;

PRINT_STMT
    : '(' "print-num" EXP ')'
        { printf("Number: %d\n", $3); }
    | '(' "print-bool" EXP ')'
        { printf("Boolean: %d\n", $3); }
    ;

EXP
    : BOOL_VAL
        { $$ = $1; }
    | NUMBER
        { $$ = $1; }
    | VARIABLE
        { /* Handle variable evaluation */ }
    | NUM_OP
        { $$ = $1; }
    | LOGICAL_OP
        { $$ = $1; }
    | FUN_EXP
    | FUN_CALL
    | IF_EXP
    ;

NUM_OP
    : PLUS
    | MINUS
    | MULTIPLY
    | DIVIDE
    | MODULUS
    | GREATER
    | SMALLER
    | EQUAL
    ;

PLUS
    : '(' '+' EXP_LIST ')'
        {}
    ;

MINUS
    : '(' '-' EXP EXP ')'
        {}
    ;

MULTIPLY
    : '(' '*' EXP_LIST ')'
        {}
    ;

DIVIDE
    : '(' '/' EXP EXP ')'
        {}
    ;

MODULUS
    : '(' "mod" EXP EXP ')'
        {}
    ;

GREATER
    : '(' '>' EXP EXP ')'
        {}
    ;

SMALLER
    : '(' '<' EXP EXP ')'
        {}
    ;

EQUAL
    : '(' '=' EXP_LIST ')'
        {}
    ;

LOGICAL_OP
    : AND_OP
    | OR_OP
    | NOT_OP
    ;

AND_OP
    : '(' "and" EXP_LIST ')'
        {}
    ;

OR_OP
    : '(' "or" EXP_LIST ')'
        {}
    ;

NOT_OP
    : '(' "not" EXP ')'
        {}
    ;

DEF_STMT
    : '(' "define" ID EXP ')'
        {}
    ;

VARIABLE
    : ID
    ;

FUN_EXP
    : '(' "fun" FUN_IDS FUN_BODY ')'
        {}
    ;

FUN_IDS
    : '(' ID_LIST ')'
    ;

FUN_BODY
    : EXP
    ;

FUN_CALL
    : '(' FUN_EXP PARAM_LIST ')'
    | '(' FUN_NAME PARAM_LIST ')'
    ;

PARAM_LIST
    : /* empty */
    | PARAM_LIST PARAM
    ;

PARAM
    : EXP
    ;

FUN_NAME
    : ID
    ;

IF_EXP
    : '(' "if" TEST_EXP THEN_EXP ELSE_EXP ')'
        {}
    ;

TEST_EXP
    : EXP
    ;

THEN_EXP
    : EXP
    ;

ELSE_EXP
    : EXP
    ;

EXP_LIST
    : EXP
    | EXP_LIST EXP
    ;

ID_LIST
    : /* empty */
    | ID_LIST ID
    ;

%%

int main() {
    yyparse();
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

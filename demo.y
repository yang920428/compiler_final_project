%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
%}

%union{
    int value;
}

%token<value> NUMBER
%token BOOL_VAL ID
%type<value> EXP PLUS MINUS MULTIPLY DIVIDE MODULUS GREATER SMALLER EQUAL NUM_OP 


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
        {printf("%s\n" , $3);}
    | '(' "print-bool" EXP ')'
        {}
    ;

EXP
    : BOOL_VAL
    | NUMBER{
        $$ = $1
    }
    | VARIABLE
    | NUM_OP{
        $$ = $1
    }
    | LOGICAL_OP
    | FUN_EXP
    | FUN_CALL
    | IF_EXP
    ;

NUM_OP
    : PLUS{
        $$ = $1
    }
    | MINUS{
        $$ = $1
    }
    | MULTIPLY
    | DIVIDE
    | MODULUS
    | GREATER
    | SMALLER
    | EQUAL
    ;

PLUS
    : '(' '+' EXP EXP_LIST ')'
        {
           
        }
    ;

MINUS
    : '(' '-' EXP EXP ')'
        {
            $$ = $3 - $4
        }
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
    : '(' '=' EXP EXP_LIST ')'
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

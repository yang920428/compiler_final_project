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

%left '+' '-'
%left '*' '/'
%left '<' '>' '='

%%

PROGRAM
    : STMTs
    ;

STMTs
    : STMT STMTs {  }
    | {  }
    ;

STMT
    : EXP {  }
    | DEF_STMT {  }
    | PRINT_STMT {  }
    ;

PRINT_STMT
    : '(' "print-num" EXP ')' { printf("Number: %d\n", $3); }
    | '(' "print-bool" EXP ')' { printf("Boolean: %d\n", $3); }
    ;

EXP
    : BOOL_VAL {  }
    | NUMBER { }
    | VARIABLE {  }
    | NUM_OP {  }
    | LOGICAL_OP {  }
    | FUN_EXP {  }
    | FUN_CALL {  }
    | IF_EXP { }
    ;

DEF_STMT
    : '(' "define" ID EXP ')' {  }
    ;

VARIABLE
    : ID { }
    ;

FUN_EXP
    : '(' "fun" FUN_IDS FUN_BODY ')' { }
    ;

FUN_IDS
    : '(' IDs ')' {  }
    ;

FUN_BODY
    : EXP {  }
    ;

FUN_CALL
    : '(' FUN_EXP PARAMs ')' {  }
    | '(' FUN_NAME PARAMs ')' {  }
    ;

PARAM
    : EXP {  }
    ;

PARAMs
    : PARAM PARAMs { }
    | {  }
    ;

IF_EXP
    : '(' "if" TEST_EXP THEN_EXP ELSE_EXP ')' {  }
    ;

TEST_EXP
    : EXP {  }
    ;

THEN_EXP
    : EXP { }
    ;

ELSE_EXP
    : EXP { }
    ;

EXPs
    : EXP EXPs {  }
    | {  }
    ;

IDs
    : ID IDs {  }
    | {  }
    ;

%%

int main() {
    yyparse();
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

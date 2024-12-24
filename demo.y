%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int val;
    int num;
    int Bool;
    char name[32];
}info;

%}

%union {
    int num;
    int val;
    int Bool;
    char name[32];
    info information;
}

%token<information> EXP STMT
%token<num> Number NUM_OP
%token<Bool> BOOL_VAL LOGICAL_OP IF_EXP
%token<name> VARIABLE
%token<val> FUN_EXP FUN_CALL

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

// print

PRINT_STMT
    : '(' "print-num" EXP ')' { printf("Number: %d\n", $3); }
    | '(' "print-bool" EXP ')' { printf("Boolean: %d\n", $3); }
    ;

//exp 

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

// num op

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
    : '(' '+' EXP EXPs ')'
        {}
    ;

MINUS
    : '(' '-' EXP EXP ')' {}
    ;

MULTIPLY
    : '(' '*' EXP EXPs ')'
        {}
    ;

DIVIDE
    : '(' '/' EXP EXP ')' {}
    ;

MODULUS
    : '(' 'mod' EXP EXP ')' {}
    ;



EQUAL
    : '(' '=' EXP EXPs ')'
        {}
    ;

// logical op

LOGICAL_OP
    : AND_OP {}
    | OR_OP {}
    | NOT_OP {}
    ;


AND_OP
    : '(' "and" EXP EXPs ')'
        {}
    ;

OR_OP
    : '(' "or" EXP EXPs ')'
        {}
    ;

NOT_OP 
    : '(' 'not' EXP ')' {}
    ;

// def stmt

DEF_STMT
    : '(' "define" ID EXP ')' {  }
    ;

VARIABLE
    : ID { }
    ;

// function

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

// if 

IF_EXP
    : '(' "if" TEST_EXP THEN_EXP ELSE_EXP ')' { 
     }
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

// other

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
    printf("syntax error");
}

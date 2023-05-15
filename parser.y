%{
#include <stdio.h>
#include <stdlib.h>
void yyerror(const char* msg);
int yylex(void);
extern FILE* yyin;
%}

%start query
%token SELECT FROM WHERE
%token CREATE ALTER DROP
%token AVERAGE COUNT MAXIMUM MINIMUM SUM
%token SET INTO VALUES
%token DELETE INSERT UPDATE
%token EQUALITY GREATERTHAN LESSTHAN
%token IDENTIFIER LITERAL ASTERISK SEMICOLON
%token COMMA LEFTPARENTHESIS RIGHTPARENTHESIS
%%

query: select_query | alter_query | create_query | delete_query | drop_query | update_query | insert_query;

select_query: SELECT select_list FROM IDENTIFIER where_clause SEMICOLON {printf("Statement Parsed --> SELECT \n");};
alter_query: ALTER IDENTIFIER SEMICOLON {printf("Statement Parsed --> ALTER\n");};
create_query: CREATE IDENTIFIER IDENTIFIER LEFTPARENTHESIS column_def_list RIGHTPARENTHESIS SEMICOLON {printf("Statement Parsed --> CREATE\n");};
column_def_list: IDENTIFIER | IDENTIFIER COMMA column_def_list | IDENTIFIER IDENTIFIER | IDENTIFIER IDENTIFIER COMMA column_def_list;
delete_query: DELETE FROM IDENTIFIER where_clause SEMICOLON {printf("Statement Parsed --> DELETE\n");};
drop_query: DROP IDENTIFIER IDENTIFIER SEMICOLON {printf("Statement Parsed --> DROP\n");};
update_query: UPDATE IDENTIFIER SET set_clause where_clause SEMICOLON {printf("Statement Parsed --> UPDATE\n");};
insert_query: INSERT INTO IDENTIFIER LEFTPARENTHESIS column_def_list RIGHTPARENTHESIS VALUES LEFTPARENTHESIS literal_list RIGHTPARENTHESIS SEMICOLON {printf("Statement Parsed --> INSERT\n");};
literal_list: LITERAL | LITERAL COMMA literal_list;
set_clause: IDENTIFIER EQUALITY LITERAL  | IDENTIFIER EQUALITY LITERAL COMMA set_clause;

select_list: ASTERISK | column_list |function_list;           
function_list: function_call | function_call COMMA function_list;
function_call: AVERAGE LEFTPARENTHESIS IDENTIFIER RIGHTPARENTHESIS | COUNT LEFTPARENTHESIS IDENTIFIER RIGHTPARENTHESIS | MAXIMUM LEFTPARENTHESIS IDENTIFIER RIGHTPARENTHESIS | MINIMUM LEFTPARENTHESIS IDENTIFIER RIGHTPARENTHESIS | SUM LEFTPARENTHESIS IDENTIFIER RIGHTPARENTHESIS;
column_list: IDENTIFIER | IDENTIFIER COMMA column_list;
where_clause: WHERE condition | /* empty */;
condition: IDENTIFIER operator LITERAL;
operator: EQUALITY | GREATERTHAN | LESSTHAN;
%%

int main(int argc, char **argv) {
  if (argc == 2)
  {
    yyin = fopen(argv [1], "r");
  }
  yyparse();
  return 0;
}
void yyerror(const char* a) {
  fprintf(stderr, "THERE IS A PARSING ERROR: %s\n", a);
  exit(1);
}

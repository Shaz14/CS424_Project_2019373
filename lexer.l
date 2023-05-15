%{
#include "parser.tab.h"
%}

%option noyywrap

%%
[ \t\n]     { /* ignore whitespace */ }

"SELECT"  {return SELECT;}
"FROM"    {return FROM;}
"WHERE"   {return WHERE;}
"CREATE" {return CREATE;}
"ALTER" {return ALTER;}
"DROP" {return DROP;}
"DELETE" {return DELETE;}
"INSERT" {return INSERT;}
"UPDATE" {return UPDATE;}
"INTO" {return INTO;}
"SET" {return SET;}
"VALUES" {return VALUES;}
"*"       {return ASTERISK;}
">"       {return GREATERTHAN;}
"<"      {return LESSTHAN;}
"="       {return EQUALITY;}
"AVG"     {return AVERAGE;}
"COUNT"   {return COUNT;}
"MAX"     {return MAXIMUM;}
"MIN"     {return MINIMUM;}
"SUM"     {return SUM;}
"," {return COMMA;}
"(" {return LEFTPARENTHESIS;}
")" {return RIGHTPARENTHESIS;}
[+-]?[0-9]+(\.[0-9]*)?  {return LITERAL;}
'[^']*'|\"[^"]*\"       {return LITERAL;}
[a-zA-Z]+[a-zA-Z0-9_]*  {return IDENTIFIER;}
";"      {return SEMICOLON; }
%%

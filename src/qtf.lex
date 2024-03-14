%{
    #include "main.hpp"
%}

%option yylineno noyywrap

s [+\-]?
n [0-9]+

%%
#.*             {}      // line comment
[ \t\r\n]+      {}      // drop spaces

[_a-zA-Z][_a-zA-Z0-9]*      { yylval.s = new std::string(yytext); return SYM; }

{s}{n}"."{n}                { yylval.f = atof(yytext); return FLO; }
{s}{n}("."{n})?[eE]{s}{n}   { yylval.f = atof(yytext); return FLO; }
{s}{n}                      { yylval.n = atoi(yytext); return INT; }

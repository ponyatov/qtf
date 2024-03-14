%{
    #include "main.hpp"
%}

%option yylineno noyywrap

%%
#.*             {}      // line comment
[ \t\r\n]+      {}      // drop spaces

[_a-zA-Z][_a-zA-Z0-9]*  { yylval.s = new std::string(yytext); return SYM; }

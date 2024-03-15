%{
    #include "main.hpp"
    #include "qtf.lexer.hpp"
%}

%defines %union { float f; int n; std::string *s; }

%token<f> FLO
%token<n> INT
%token<s> SYM

%%

syntax : | syntax ex

ex : FLO { std::cout << "<flo:" <<  $1 << '>' << std::endl;            }
   | INT { std::cout << "<int:" <<  $1 << '>' << std::endl;            }
   | SYM { std::cout << "<sym:" << *$1 << '>' << std::endl; delete $1; }

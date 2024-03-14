%{
    #include "main.hpp"
%}

%defines %union { std::string *s; }

%token<s> SYM

%%
syntax : | syntax ex
ex : SYM { std::cout << '<' << *$1 << '>' << std::endl; delete $1; }

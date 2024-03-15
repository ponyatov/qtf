/// @file
#pragma once

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

#include <iostream>

#include <readline/readline.h>
#include <readline/history.h>

// #include <QtWidgets>
#include <QApplication>
#include <QLabel>

/// @defgroup main main
/// @{

/// @brief print command line argument `argv[1] = <ini/qtf.ini>`
/// @param[in] argc index
/// @param[in] argv argument value
extern void arg(int argc, char argv[]);

/// @brief program entry point
/// @param[in] argc number of command line arguments +1
/// @param[in] argv array of command line arguments
/// @return
extern int main(int argc, char* argv[]);

/// @}

/// @defgroup skelex skelex
/// @brief lexical skeleton
/// @{

extern int yylex();
extern int yylineno;
extern char* yytext;
extern void yyset_in(FILE*);
extern int yyparse();
extern void yyerror(std::string msg);
#include "qtf.lexer.hpp"
#include "qtf.parser.hpp"

/// @}

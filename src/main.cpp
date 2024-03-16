#include "main.hpp"

#include "CAD.hpp"

int main(int argc, char* argv[]) {
    QApplication app(argc, argv);
    arg(0, argv[0]);
    for (int i = 1; i < argc; i++) {  //
        arg(i, argv[i]);
        FILE* src = NULL;
        assert(src = fopen(argv[i], "r"));
        yyset_in(src);
        yyparse();
        fclose(src);
    }
    QLabel lbl("Hello, World");
    lbl.show();
    std::cout << new CAD << std::endl;
    return app.exec();
}

void arg(int argc, char argv[]) {  //
    printf("argv[%i] = <%s>\n", argc, argv);
}

extern void yyerror(std::string msg) {
    std::cerr << msg << std::endl;
    exit(-1);
}

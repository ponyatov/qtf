#include "main.hpp"

QApplication* app = nullptr;
MainWindow* win = nullptr;

int main(int argc, char* argv[]) {
    arg(0, argv[0]);
    assert(app = new QApplication(argc, argv));
    for (int i = 1; i < argc; i++) {  //
        arg(i, argv[i]);
        FILE* src = NULL;
        assert(src = fopen(argv[i], "r"));
        yyset_in(src);
        yyparse();
        fclose(src);
    }
    assert(win = new MainWindow(argv[0]));
    win->show();

    QObject::connect(win, SIGNAL(clicked()), app, SLOT(quit()));

    return app->exec();
}

void arg(int argc, char argv[]) {  //
    printf("argv[%i] = <%s>\n", argc, argv);
}

extern void yyerror(std::string msg) {
    std::cerr << msg << std::endl;
    exit(-1);
}

#include "main.hpp"

int main(int argc, char* argv[]) {
    QApplication app(argc, argv); 
    arg(0, argv[0]);
    for (int i = 1; i < argc; i++) {  //
        arg(i, argv[i]);
        FILE* src = NULL;
        assert(src = fopen(argv[i], "r"));
        fclose(src);
    }
    return app.exec();
}

void arg(int argc, char argv[]) {  //
    printf("argv[%i] = <%s>\n", argc, argv);
}

#pragma once

class MainWindow : public QMainWindow {
    Q_OBJECT

    QMenuBar *menu = nullptr;
    void Menu();

    QMenu *file = nullptr;
    QMenu *quit = nullptr;
    void File();

    QMenu *edit = nullptr;
    void Edit();

    QMenu *view = nullptr;
    void View();

    QMenu *draw = nullptr;
    void Draw();

    QMenu *config = nullptr;
    void Config();

    QMenu *help = nullptr;
    void Help();

   public:
    MainWindow(QString title, QWidget *pwgt = NULL);
};

#include "main.hpp"

void MainWindow::Menu() {  //
    assert(menu = new QMenuBar);
    setMenuBar(menu);
    File();
    Edit();
    View();
    Draw();
    Config();
    Help();
}

void MainWindow::File() {
    assert(file = new QMenu("&File"));
    menu->addMenu(file);
}

void MainWindow::Edit() {
    assert(edit = new QMenu("&Edit"));
    menu->addMenu(edit);
}

void MainWindow::View() {
    assert(view = new QMenu("&View"));
    menu->addMenu(view);
}

void MainWindow::Draw() {
    assert(draw = new QMenu("&Draw"));
    menu->addMenu(draw);
}

void MainWindow::Config() {
    assert(config = new QMenu("&Config"));
    menu->addMenu(config);
}

void MainWindow::Help() {
    assert(help = new QMenu("&Help"));
    menu->addMenu(help);
}

MainWindow::MainWindow(QString title, QWidget *pwgt) : QMainWindow(pwgt) {
    setWindowTitle(title);
    Menu();
}

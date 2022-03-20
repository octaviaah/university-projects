//
// Created by Expert on 3/20/2021.
//

#include <iostream>
#include "service.h"
#include "main_window.h"
#include <QApplication>

using namespace std;

int main(int argc, char* argv[])
{
    Repository repo = Repository();
    Service serv = Service(repo);
    QApplication a(argc, argv);
    MainWindow w(serv);
    w.setFixedSize(400, 300);
    w.show();

    return a.exec();
}


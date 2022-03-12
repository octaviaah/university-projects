#include <iostream>
#include "mainwindow.h"
#include <QApplication>
#include "session.h"
#include "repository.h"
#include "searchwindow.h"

int main(int argc, char* argv[]) {
    QApplication a(argc, argv);
    Session s;
    Repository repo(s);

    for (const auto &user: repo.getUsers()) {
        user->show();
    }

    searchwindow searchw(s);
    searchw.show();
    return a.exec();
}
